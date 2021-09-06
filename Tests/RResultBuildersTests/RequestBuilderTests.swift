//
//  File.swift
//  File
//
//  Created by Mahadevaiah, Pavan | Pavan | ECMPD on 2021/09/01.
//


/**
Request<Type> {
    URL(string: "https://jsonplaceholder.typicode.com/todo")!
    Header.Accept(.json)
}
.onData { data in
    ...
}
.onError { error in
    ...
}
.resume()
*/


import XCTest
@testable import RResultBuilders

final class RequestBuilderTests: XCTestCase {
    struct Todo: Codable {
        let title: String
        let completed: Bool
        let userId: Int
    }
    
    func testBasicDataRequest() {
        verifyRequest(
            DataRequest {
                URL {
                    Scheme(.https)
                    Host("jsonplaceholder.typicode.com")
                    Path("todos")
                }!
            }
        )
    }
    
    func testDataRequestWithControlStatements() {
        let headers: [RequestParameter] = [
            Header.Accept(.json),
            Header.Authorization(.basic(username: "test", password: "rest")),
            Header.CacheControl(.noCache)
        ]
        
        verifyRequest(DataRequest {
            URL(string: "https://jsonplaceholder.typicode.com/todos")!
            Headers {
                if !headers.isEmpty {
                    for header in headers {
                        header
                    }
                }
            }
        })
    }
    
    func testPostDataRequest() {
        let sampleTodo = Todo(title: "My Post", completed: true, userId: 1)
        verifyRequest(DataRequest {
            URL(string: "https://jsonplaceholder.typicode.com/todos")!
            Method.POST
            RequestBody(sampleTodo)
        })
    }
    
    func testURLRequest() {
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
        
        XCTAssertEqual(request.httpMethod, "GET")
        XCTAssertEqual(request.url!.absoluteString, "https://jsonplaceholder.typicode.com/todos")
        let headerFields = request.allHTTPHeaderFields!
        XCTAssertEqual(headerFields["Accept"], "application/json")
        XCTAssertEqual(headerFields["Authorization"], "Basic dGVzdDpyZXN0")
        XCTAssertEqual(headerFields["Cache-Control"], "no-cache")
        XCTAssertEqual(request.cachePolicy, .reloadIgnoringLocalCacheData)
    }
    
    func testRawResponse() {
        let expectation = self.expectation(description: #function)
        var rawResponse: (Data?, URLResponse?, Error?)? = nil
                
        DataRequest {
            URL(string: "https://jsonplaceholder.typicode.com/todos")!
        }
        .onRawResponse { (data, response, error) in
            rawResponse = (data, response, error)
            expectation.fulfill()
        }
        .resume()
        
        waitForExpectations(timeout: 10000)
        if rawResponse != nil {
            XCTAssert(true)
        } else {
            XCTAssert(false)
        }
    }
    
    func testDataResponse() {
        let expectation = self.expectation(description: #function)
        var responseData: Data? = nil
        
        DataRequest {
            URL(string: "https://jsonplaceholder.typicode.com/todos")!
        }
        .onData { data in
            responseData = data
            expectation.fulfill()
        }
        .resume()
        
        waitForExpectations(timeout: 10000)
        if responseData != nil {
            XCTAssert(true)
        } else {
            XCTAssert(false)
        }
    }
            
    func testObjectResponse() {
        let expectation = self.expectation(description: #function)
        var response: [Todo]? = nil
        var error: RError? = nil
        
        Request<[Todo]> {
            URL(string: "https://jsonplaceholder.typicode.com/todos")!
        }
        .onError { err in
            error = err
            expectation.fulfill()
        }
        .onObject { todos in
            response = todos
            expectation.fulfill()
        }
        .resume()
        
        waitForExpectations(timeout: 10000)
        if error != nil {
            XCTAssert(false)
        } else if response != nil {
            XCTAssert(true)
        }
    }
    
    func testErrorResponse() {
        let expectation = self.expectation(description: #function)
        var error: RError? = nil
        
        DataRequest {
            URL(string: "https://jsonplaceholder.typicode.com/error")!
        }
        .onError { err in
            error = err
            expectation.fulfill()
        }
        .resume()
        
        waitForExpectations(timeout: 10000)
        if error != nil {
            XCTAssert(true)
        } else {
            XCTAssert(false, "expects error response")
        }
    }
    
}

// MARK: - Helper methods
extension RequestBuilderTests {
    func verifyRequest<T: Decodable>(_ request: Request<T>) {
        let expectation = self.expectation(description: #function)
        var response: Data? = nil
        var error: RError? = nil
        
        request
            .onError { err in
                error = err
                expectation.fulfill()
            }
            .onData { data in
                response = data
                expectation.fulfill()
            }
            .resume()
        
        waitForExpectations(timeout: 10000)
        
        if error != nil {
            XCTAssert(false)
        } else if response != nil {
            XCTAssert(true)
        }
    }
}
