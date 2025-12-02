//
//  Request.swift
//
//  Created by Pavan on 2021/08/27.
//  Migrated to Swift 6.2 with Swift Concurrency
//

import Foundation

/// Aliased Request specific to `Data` type
public typealias DataRequest = Request<Data>

public struct Request<T: Decodable & Sendable>: Sendable {
    private let sessionConfiguration: URLSessionConfiguration
    private let sessionDelegate: (any URLSessionDelegate)?
    private let sessionDelegateQueue: OperationQueue?
    private let rootParameter: RequestParameter
    
    /// Initializer that builds request parameters using result builder
    /// - Parameters:
    ///   - sessionConfiguration: url session configuration, it will be default if not specified
    ///   - delegate: url session delegate defaults to nil
    ///   - delegateQueue: url session delegate queue defaults to nil
    ///   - builder: request builder which returns request parameters
    public init(
        sessionConfiguration: URLSessionConfiguration = .default,
        sessionDelegate: (any URLSessionDelegate)? = nil,
        sessionDelegateQueue queue: OperationQueue? = nil,
        @RRequestBuilder builder: () -> RequestParameter
    ) {
        self.sessionConfiguration = sessionConfiguration
        self.sessionDelegate = sessionDelegate
        self.sessionDelegateQueue = queue
        self.rootParameter = builder()
    }
    
    // MARK: - Async/Await API
    
    /// Performs the request and returns raw response data (non-throwing)
    /// - Returns: Tuple containing data, response, and optional error
    public func response() async -> (Data?, URLResponse?, Error?) {
        let request = asURLRequest()
        let session = URLSession(
            configuration: sessionConfiguration,
            delegate: sessionDelegate,
            delegateQueue: sessionDelegateQueue
        )
        
        do {
            let (data, response) = try await session.data(for: request)
            return (data, response, nil)
        } catch {
            return (nil, nil, error)
        }
    }
    
    /// Performs the request and returns data
    /// - Throws: RError if request fails or status code is invalid
    /// - Returns: Response data
    public func data() async throws -> Data {
        let request = asURLRequest()
        let session = URLSession(
            configuration: sessionConfiguration,
            delegate: sessionDelegate,
            delegateQueue: sessionDelegateQueue
        )
        
        do {
            let (data, response) = try await session.data(for: request)
            
            // Validate HTTP status
            try validateResponse(response, data: data)
            
            return data
        } catch let error as RError {
            throw error
        } catch {
            throw RError.raw(error: error)
        }
    }
    
    /// Performs the request and returns decoded object
    /// - Parameter decoder: Decoder to use for parsing response (defaults to JSONDecoder)
    /// - Throws: RError if request fails, status code is invalid, or decoding fails
    /// - Returns: Decoded object of type T
    public func object(using decoder: any RLevelDecoder = JSONDecoder()) async throws -> T {
        let data = try await self.data()
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw RError.decoding(error: error)
        }
    }
    
    /// Performs the request and returns both data and response
    /// - Throws: RError if request fails or status code is invalid
    /// - Returns: Tuple containing data and URLResponse
    public func dataWithResponse() async throws -> (Data, URLResponse) {
        let request = asURLRequest()
        let session = URLSession(
            configuration: sessionConfiguration,
            delegate: sessionDelegate,
            delegateQueue: sessionDelegateQueue
        )
        
        do {
            let (data, response) = try await session.data(for: request)
            
            // Validate HTTP status
            try validateResponse(response, data: data)
            
            return (data, response)
        } catch let error as RError {
            throw error
        } catch {
            throw RError.raw(error: error)
        }
    }
    
    /// Performs the request and returns decoded object with response
    /// - Parameter decoder: Decoder to use for parsing response (defaults to JSONDecoder)
    /// - Throws: RError if request fails, status code is invalid, or decoding fails
    /// - Returns: Tuple containing decoded object and URLResponse
    public func objectWithResponse(using decoder: any RLevelDecoder = JSONDecoder()) async throws -> (T, URLResponse) {
        let (data, response) = try await dataWithResponse()
        
        do {
            let object = try decoder.decode(T.self, from: data)
            return (object, response)
        } catch {
            throw RError.decoding(error: error)
        }
    }
    
    // MARK: - AsyncSequence Support (Streaming)
    
    /// Performs the request and returns an async sequence of bytes
    /// Useful for streaming large responses
    /// - Throws: RError if request fails or status code is invalid
    /// - Returns: AsyncSequence of bytes
    @available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
    public func bytes() async throws -> (URLSession.AsyncBytes, URLResponse) {
        let request = asURLRequest()
        let session = URLSession(
            configuration: sessionConfiguration,
            delegate: sessionDelegate,
            delegateQueue: sessionDelegateQueue
        )
        
        do {
            let (bytes, response) = try await session.bytes(for: request)
            
            // Validate HTTP status
            try validateResponse(response, data: nil)
            
            return (bytes, response)
        } catch let error as RError {
            throw error
        } catch {
            throw RError.raw(error: error)
        }
    }
    
    // MARK: - Private Helpers
    
    private func validateResponse(_ response: URLResponse, data: Data?) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            return
        }
        
        let statusCode = httpResponse.statusCode
        if statusCode < 200 || statusCode >= 300 {
            throw RError.http(statusCode: statusCode, error: data)
        }
    }
}

// MARK: - Request Extensions
public extension Request {
    /// Generate `URLRequest` with all parameters applied recursively
    func asURLRequest() -> URLRequest {
        var request = URLRequest(url: URL(string: "https://")!)
        apply(param: rootParameter, to: &request, config: sessionConfiguration)
        return request
    }

    private func apply(param: RequestParameter,
                       to request: inout URLRequest,
                       config: URLSessionConfiguration) {

        // Apply this parameter to URLRequest
        param.buildParameter(&request)

        // Apply session configuration when supported
        if let sessionParam = param as? SessionParameter {
            sessionParam.buildConfiguration(config)
        }

        // Recursively apply all parameters inside CombinedParameters
        if let combo = param as? CombinedParameters {
            for child in combo.allParameters {
                apply(param: child, to: &request, config: config)
            }
        }
    }
}

// MARK: - TaskGroup Support
public extension Request {
    /// Executes multiple requests concurrently
    /// - Parameter requests: Array of requests to execute
    /// - Returns: Array of results (either success with object or failure with error)
    static func executeAll(_ requests: [Request<T>]) async -> [Result<T, Error>] {
        await withTaskGroup(of: (Int, Result<T, Error>).self) { group in
            for (index, request) in requests.enumerated() {
                group.addTask {
                    do {
                        let object = try await request.object()
                        return (index, .success(object))
                    } catch {
                        return (index, .failure(error))
                    }
                }
            }
            
            var results: [(Int, Result<T, Error>)] = []
            for await result in group {
                results.append(result)
            }
            
            // Sort by original index to maintain order
            return results.sorted { $0.0 < $1.0 }.map { $0.1 }
        }
    }
    
    /// Executes multiple requests concurrently and returns only successful results
    /// - Parameter requests: Array of requests to execute
    /// - Returns: Array of successfully decoded objects
    static func executeAllSuccessful(_ requests: [Request<T>]) async -> [T] {
        await withTaskGroup(of: T?.self) { group in
            for request in requests {
                group.addTask {
                    try? await request.object()
                }
            }
            
            var results: [T] = []
            for await result in group {
                if let result = result {
                    results.append(result)
                }
            }
            
            return results
        }
    }
}
