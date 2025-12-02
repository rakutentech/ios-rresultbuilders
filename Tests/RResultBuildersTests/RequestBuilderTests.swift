//
//  RResultBuilders.swift
//
//  Created by Pavan on 2021/09/01.
//  Migrated to Swift Testing with async/await
//

import Testing
import Foundation
@testable import RResultBuilders

// MARK: - Test Models
struct Todo: Codable, Sendable {
    let title: String
    let completed: Bool
    let userId: Int
}

@Suite("Request Builder Tests")
struct RequestBuilderTests {
    
    // MARK: - Basic Request Construction Tests
    
    @Test("Basic data request can be constructed with URL builder")
    func testBasicDataRequest() async throws {
        let request = DataRequest {
            URL {
                Scheme(.https)
                Host("jsonplaceholder.typicode.com")
                Path("todos")
            }!
        }
        
        let data = try await request.data()
        #expect(data.count > 0, "Should receive data from API")
    }
    
    @Test("Data request with control statements and headers")
    func testDataRequestWithControlStatements() async throws {
        let headers: [RequestParameter] = [
            Header.Accept(.json),
            Header.Authorization(.basic(username: "test", password: "rest")),
            Header.CacheControl(.noCache)
        ]
        
        let request = DataRequest {
            URL(string: "https://jsonplaceholder.typicode.com/todos")!
            Headers {
                if !headers.isEmpty {
                    for header in headers {
                        header
                    }
                }
            }
        }
        
        let data = try await request.data()
        #expect(data.count > 0, "Should receive data with headers")
    }
    
    @Test("POST request with body can be constructed")
    func testPostDataRequest() async throws {
        let sampleTodo = Todo(title: "My Post", completed: true, userId: 1)
        
        let request = DataRequest {
            URL(string: "https://jsonplaceholder.typicode.com/todos")!
            Method.POST
            RequestBody(sampleTodo)
        }
        
        // Note: This endpoint accepts POST requests
        let data = try await request.data()
        #expect(data.count > 0, "Should receive response from POST request")
    }
    
    // MARK: - URLRequest Conversion Tests
    
    @Test("URLRequest is properly constructed from builder")
    func testURLRequest() async throws {
        let request = DataRequest {
            URL(string: "https://jsonplaceholder.typicode.com/todos")!
            Method.GET
            CachePolicy(.reloadIgnoringLocalCacheData)
            Headers {
                Header.Accept(.json)
                Header.Authorization(.basic(username: "test", password: "rest"))
                Header.CacheControl(.noCache)
            }
        }.asURLRequest()
        
        #expect(request.httpMethod == "GET", "HTTP method should be GET")
        #expect(request.url?.absoluteString == "https://jsonplaceholder.typicode.com/todos",
               "URL should match")
        
        let headerFields = request.allHTTPHeaderFields!
        #expect(headerFields["Accept"] == "application/json",
               "Accept header should be application/json")
        #expect(headerFields["Authorization"] == "Basic dGVzdDpyZXN0",
               "Authorization header should be properly encoded")
        #expect(headerFields["Cache-Control"] == "no-cache",
               "Cache-Control header should be no-cache")
        #expect(request.cachePolicy == .reloadIgnoringLocalCacheData,
               "Cache policy should match")
    }
    
    // MARK: - Async/Await Response Tests
    
    @Test("Data response can be retrieved using async/await")
    func testDataResponseAsync() async throws {
        let request = DataRequest {
            URL(string: "https://jsonplaceholder.typicode.com/todos")!
        }
        
        let data = try await request.data()
        
        #expect(data.count > 0, "Should receive non-empty data")
        
        // Verify it's valid JSON
        let json = try JSONSerialization.jsonObject(with: data)
        #expect(json is [Any], "Response should be a JSON array")
    }
    
    @Test("Object response can be decoded using async/await")
    func testObjectResponseAsync() async throws {
        let request = Request<[Todo]> {
            URL(string: "https://jsonplaceholder.typicode.com/todos")!
        }
        
        let todos = try await request.object()
        
        #expect(todos.count > 0, "Should receive array of todos")
        #expect(!todos[0].title.isEmpty, "First todo should have a title")
    }
    
    @Test("Response with URLResponse can be retrieved")
    func testDataWithResponseAsync() async throws {
        let request = DataRequest {
            URL(string: "https://jsonplaceholder.typicode.com/todos")!
        }
        
        let (data, response) = try await request.dataWithResponse()
        
        #expect(data.count > 0, "Should receive data")
        
        if let httpResponse = response as? HTTPURLResponse {
            #expect(httpResponse.statusCode == 200, "Status code should be 200")
            #expect(httpResponse.url?.host == "jsonplaceholder.typicode.com",
                   "Host should match")
        } else {
            Issue.record("Response should be HTTPURLResponse")
        }
    }
    
    @Test("Object with response can be decoded")
    func testObjectWithResponseAsync() async throws {
        let request = Request<[Todo]> {
            URL(string: "https://jsonplaceholder.typicode.com/todos")!
        }
        
        let (todos, response) = try await request.objectWithResponse()
        
        #expect(todos.count > 0, "Should receive todos")
        
        if let httpResponse = response as? HTTPURLResponse {
            #expect(httpResponse.statusCode == 200, "Status code should be 200")
            #expect(httpResponse.allHeaderFields["Content-Type"] != nil,
                   "Should have Content-Type header")
        }
    }
    
    @Test("Non-throwing response method handles errors gracefully")
    func testNonThrowingResponse() async throws {
        let request = DataRequest {
            URL(string: "https://jsonplaceholder.typicode.com/todos")!
        }
        
        let (data, response, error) = await request.response()
        
        #expect(error == nil, "Should not have error for valid endpoint")
        #expect(data != nil, "Should have data")
        #expect(response != nil, "Should have response")
    }
    
    // MARK: - Error Handling Tests
    
    @Test("HTTP error is properly thrown for invalid endpoint")
    func testErrorResponseAsync() async throws {
        let request = DataRequest {
            URL(string: "https://jsonplaceholder.typicode.com/nonexistent")!
        }
        
        do {
            _ = try await request.data()
            Issue.record("Should throw error for invalid endpoint")
        } catch let error as RError {
            // Verify it's an HTTP error (404)
            if case .http(let statusCode, _) = error {
                #expect(statusCode == 404, "Should be 404 error")
            } else {
                Issue.record("Should be HTTP error, got: \(error)")
            }
        } catch {
            Issue.record("Should throw RError, got: \(error)")
        }
    }
    
    @Test("Network error is properly handled")
    func testNetworkError() async throws {
        let request = DataRequest {
            URL(string: "https://invalid-domain-that-does-not-exist-12345.com")!
        }
        
        let (data, response, error) = await request.response()
        
        #expect(error != nil, "Should have error for invalid domain")
        #expect(data == nil, "Should not have data")
        #expect(response == nil, "Should not have response")
    }
    
    @Test("Decoding error is properly thrown for invalid JSON")
    func testDecodingError() async throws {
        // This endpoint returns a single object, not an array
        let request = Request<[Todo]> {
            URL(string: "https://jsonplaceholder.typicode.com/todos/1")!
        }
        
        do {
            _ = try await request.object()
            Issue.record("Should throw decoding error")
        } catch let error as RError {
            if case .decoding = error {
                // Expected error
                #expect(true, "Should be decoding error")
            } else {
                Issue.record("Should be decoding error, got: \(error)")
            }
        }
    }
}

// MARK: - HTTP Methods Tests
@Suite("Request HTTP Methods")
struct RequestHTTPMethodsTests {
    
    @Test("GET request works correctly")
    func testGETRequest() async throws {
        let request = DataRequest {
            URL(string: "https://jsonplaceholder.typicode.com/todos/1")!
            Method.GET
        }
        
        let data = try await request.data()
        #expect(data.count > 0, "GET request should receive data")
    }
    
    @Test("POST request receives successful response")
    func testPOSTRequest() async throws {
        let newTodo = Todo(title: "Test Todo", completed: false, userId: 1)
        
        let request = DataRequest {
            URL(string: "https://jsonplaceholder.typicode.com/todos")!
            Method.POST
            RequestBody(newTodo)
        }
        
        let (data, response) = try await request.dataWithResponse()
        
        #expect(data.count > 0, "POST should receive response data")
        
        if let httpResponse = response as? HTTPURLResponse {
            #expect(httpResponse.statusCode == 201 || httpResponse.statusCode == 200,
                   "POST should return 200 or 201")
        }
        
        // Verify response contains valid JSON
        let json = try? JSONSerialization.jsonObject(with: data)
        #expect(json != nil, "Response should be valid JSON")
    }
    
    @Test("PUT request receives successful response")
    func testPUTRequest() async throws {
        let updatedTodo = Todo(title: "Updated Todo", completed: true, userId: 1)
        
        let request = DataRequest {
            URL(string: "https://jsonplaceholder.typicode.com/todos/1")!
            Method.PUT
            RequestBody(updatedTodo)
        }
        
        let (data, response) = try await request.dataWithResponse()
        
        #expect(data.count > 0, "PUT should receive response data")
        
        if let httpResponse = response as? HTTPURLResponse {
            #expect(httpResponse.statusCode == 200, "PUT should return 200")
        }
        
        // Verify response contains valid JSON
        let json = try? JSONSerialization.jsonObject(with: data)
        #expect(json != nil, "Response should be valid JSON")
    }
    
    @Test("DELETE request works correctly")
    func testDELETERequest() async throws {
        let request = DataRequest {
            URL(string: "https://jsonplaceholder.typicode.com/todos/1")!
            Method.DELETE
        }
        
        let (_, response) = try await request.dataWithResponse()
        
        if let httpResponse = response as? HTTPURLResponse {
            #expect(httpResponse.statusCode == 200, "DELETE should return 200")
        }
    }
}

// MARK: - Headers and Configuration Tests
@Suite("Request Headers and Configuration")
struct RequestHeadersTests {
    
    @Test("Accept header is properly set", arguments: [
        MediaType.json,
        MediaType.xml,
        MediaType.html,
        MediaType.custom("application/vnd.api+json")
    ])
    func testAcceptHeader(mediaType: MediaType) async throws {
        let request = DataRequest {
            URL(string: "https://jsonplaceholder.typicode.com/todos")!
            Header.Accept(mediaType)
        }.asURLRequest()
        
        let acceptHeader = request.allHTTPHeaderFields?["Accept"]
        #expect(acceptHeader != nil, "Accept header should be set")
    }
    
    @Test("Authorization header is properly encoded")
    func testAuthorizationHeader() async throws {
        let request = DataRequest {
            URL(string: "https://jsonplaceholder.typicode.com/todos")!
            Header.Authorization(.basic(username: "user", password: "pass"))
        }.asURLRequest()
        
        let authHeader = request.allHTTPHeaderFields?["Authorization"]
        #expect(authHeader?.hasPrefix("Basic ") == true,
               "Authorization should use Basic scheme")
    }
    
    @Test("Custom headers can be set")
    func testCustomHeaders() async throws {
        let request = DataRequest {
            URL(string: "https://jsonplaceholder.typicode.com/todos")!
            Headers {
                Header.Custom("X-Custom-Header", value: "CustomValue")
                Header.Custom("X-API-Key", value: "secret123")
            }
        }.asURLRequest()
        
        let customHeader = request.allHTTPHeaderFields?["X-Custom-Header"]
        let apiKeyHeader = request.allHTTPHeaderFields?["X-API-Key"]
        
        #expect(customHeader == "CustomValue", "Custom header should be set")
        #expect(apiKeyHeader == "secret123", "API key header should be set")
    }
    
    @Test("Cache policy can be configured", arguments: [
        URLRequest.CachePolicy.useProtocolCachePolicy,
        URLRequest.CachePolicy.reloadIgnoringLocalCacheData,
        URLRequest.CachePolicy.returnCacheDataElseLoad,
        URLRequest.CachePolicy.returnCacheDataDontLoad
    ])
    func testCachePolicy(policy: URLRequest.CachePolicy) async throws {
        let request = DataRequest {
            URL(string: "https://jsonplaceholder.typicode.com/todos")!
            CachePolicy(policy)
        }.asURLRequest()
        
        #expect(request.cachePolicy == policy,
               "Cache policy should be \(policy)")
    }
    
    @Test("Timeout interval can be configured")
    func testTimeoutInterval() async throws {
        let timeout: TimeInterval = 30.0
        
        let request = DataRequest {
            URL(string: "https://jsonplaceholder.typicode.com/todos")!
            Timeout(timeout)
        }.asURLRequest()
        
        #expect(request.timeoutInterval == timeout,
               "Timeout interval should be \(timeout) seconds")
    }
}

// MARK: - Concurrent Request Tests
@Suite("Concurrent Request Execution")
struct ConcurrentRequestTests {
    
    @Test("Multiple requests can be executed concurrently")
    func testConcurrentRequests() async throws {
        let request1 = Request<[Todo]> {
            URL(string: "https://jsonplaceholder.typicode.com/todos")!
        }
        
        let request2 = Request<[Todo]> {
            URL(string: "https://jsonplaceholder.typicode.com/todos")!
        }
        
        let request3 = Request<[Todo]> {
            URL(string: "https://jsonplaceholder.typicode.com/todos")!
        }
        
        async let todos1 = request1.object()
        async let todos2 = request2.object()
        async let todos3 = request3.object()
        
        let results = try await (todos1, todos2, todos3)
        
        #expect(results.0.count > 0, "First request should succeed")
        #expect(results.1.count > 0, "Second request should succeed")
        #expect(results.2.count > 0, "Third request should succeed")
    }
    
    @Test("executeAll handles multiple requests with mixed results")
    func testExecuteAllWithMixedResults() async throws {
        let successRequest = Request<[Todo]> {
            URL(string: "https://jsonplaceholder.typicode.com/todos")!
        }
        
        let failRequest = Request<[Todo]> {
            URL(string: "https://jsonplaceholder.typicode.com/nonexistent")!
        }
        
        let results = await Request.executeAll([successRequest, failRequest])
        
        #expect(results.count == 2, "Should have 2 results")
        
        // First should succeed
        if case .success(let todos) = results[0] {
            #expect(todos.count > 0, "First request should succeed")
        } else {
            Issue.record("First request should succeed")
        }
        
        // Second should fail
        if case .failure = results[1] {
            #expect(true, "Second request should fail")
        } else {
            Issue.record("Second request should fail")
        }
    }
    
    @Test("executeAllSuccessful returns only successful results")
    func testExecuteAllSuccessful() async throws {
        let request1 = Request<[Todo]> {
            URL(string: "https://jsonplaceholder.typicode.com/todos")!
        }
        
        let request2 = Request<[Todo]> {
            URL(string: "https://jsonplaceholder.typicode.com/nonexistent")!
        }
        
        let request3 = Request<[Todo]> {
            URL(string: "https://jsonplaceholder.typicode.com/todos")!
        }
        
        let results = await Request.executeAllSuccessful([request1, request2, request3])
        
        #expect(results.count == 2, "Should have 2 successful results (excluding the failed one)")
    }
}
