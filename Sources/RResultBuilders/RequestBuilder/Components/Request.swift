//
//  File.swift
//  File
//
//  Created by Mahadevaiah, Pavan | Pavan | ECMPD on 2021/08/27.
//

import Foundation
import Combine

/// Aliased Request  specific to `Data` type
public typealias DataRequest = Request<Data>

public struct Request<T: Decodable> {
    private let sessionConfiguration: URLSessionConfiguration
    private let sessionDelegate: URLSessionDelegate?
    private let sessionDelegateQueue: OperationQueue?
    private let rootParameter: RequestParameter
    private var rawResponseHandler: ((Data?, URLResponse?, Error?) -> Void)?
    private var dataHandler: ((Data?) -> Void)?
    private var objectHandler: ((T) -> Void)?
    private var errorHandler: ((RError) -> Void)?
    private var decoder: RLevelDecoder?
    
    /// Initializer that builds request parameters using result builder
    /// - Parameters:
    ///   - sessionConfiguration: url sesssion configruation, it will be default if not specified
    ///   - delegate: url sesssion delegate defaults to nil
    ///   - delegateQueue: url sesssion delegate queue defaults to nil
    ///   - builder: request builder which returns request parameters
    public init(sessionConfiguration: URLSessionConfiguration = .default,
                sessionDelegate: URLSessionDelegate? = nil,
                sessionDelegateQueue queue: OperationQueue? = nil,
                @RRequestBuilder builder: () -> RequestParameter) {
        self.sessionConfiguration = sessionConfiguration
        self.sessionDelegate = sessionDelegate
        self.sessionDelegateQueue = queue
        rootParameter = builder()
    }
    
    /// Sets raw response handler for request
    /// - Parameter callback: callback handler for raw response
    /// - Returns: modified self
    public func onRawResponse(_ callback: @escaping (Data?, URLResponse?, Error?) -> Void) -> Self {
        modify { $0.rawResponseHandler = callback }
    }
    
    /// Sets onData handler for request
    /// - Parameter callback: data handler callback
    /// - Returns: modified self
    public func onData(_ callback: @escaping (Data?) -> Void) -> Self {
        modify { $0.dataHandler = callback }
    }
    
    /// Sets onData handler for request
    /// - Parameter callback: data handler callback
    /// - Returns: modified self
    public func onObject(using decoder: RLevelDecoder = JSONDecoder(), _ callback: @escaping (T) -> Void) -> Self {
        modify {
            $0.decoder = decoder
            $0.objectHandler = callback
        }
    }
    
    /// Sets the onError handler for request
    /// - Parameter callback: error handler callback
    /// - Returns: modified self
    public func onError(_ callback: @escaping (RError) -> Void) -> Self {
        modify { $0.errorHandler = callback }
    }
    
    
    /// Triggers API with all necessary info
    public func resume() {
        let request = asURLRequest()
        
        // Call API
        URLSession(configuration: self.sessionConfiguration, delegate: sessionDelegate, delegateQueue: sessionDelegateQueue)
            .dataTask(with: request) { data, response, error in
                if let rawResponseHandler = rawResponseHandler {
                    rawResponseHandler(data, response, error)
                }
                
                if let error = error, let errorHandler = self.errorHandler {
                    errorHandler(RError.raw(error: error))
                    return
                }
                
                // Validate HTTP status
                if let res = response as? HTTPURLResponse {
                    let statusCode = res.statusCode
                    if statusCode < 200 || statusCode >= 300 {
                        if let errorHandler = self.errorHandler {
                            errorHandler(RError.http(statusCode: statusCode, error: data))
                            return
                        }
                    }
                }
                
                // Report data by handler
                if let dataHandler = dataHandler {
                    dataHandler(data)
                }
                
                // Report parsed object if it required
                if let objectHandler = objectHandler,
                   let data = data, let decoder = decoder {
                    do {
                        let object = try decoder.decode(T.self, from: data)
                        objectHandler(object)
                    } catch {
                        errorHandler?(RError.decoding(error: error))
                    }
                }
            }
            .resume()                
    }
    
    /// Modify the self with given closure
    /// - Parameter modify: modify handler
    /// - Returns: modified self
    private func modify(_ modify: (inout Self) -> Void) -> Self {
        var mutableSelf = self
        modify(&mutableSelf)
        return mutableSelf
    }
}

// MARK: - Request
public extension Request {
    /// Generate `URLRequest` with rootParameter
    func asURLRequest() -> URLRequest {
        var request = URLRequest(url: URL(string: "https://")!)
        rootParameter.buildParameter(&request)
        (rootParameter as? SessionParameter)?.buildConfiguration(sessionConfiguration)
        return request
    }
}
