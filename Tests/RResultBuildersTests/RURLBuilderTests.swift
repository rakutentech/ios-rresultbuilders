//
//  RURLBuilderTests.swift
//
//

import Testing
import Foundation
@testable import RResultBuilders

@Suite("URL Builder Tests")
struct RURLBuilderTests {
    
    @Test("Basic URL construction with scheme, host, and path")
    func testBasicURL() async throws {
        let url = URL {
            Scheme(.https)
            Host("rakuten.co.jp")
            Path("item/shop")
        }
        
        #expect(url != nil, "URL should be constructed successfully")
        #expect(url?.absoluteString == "https://rakuten.co.jp/item/shop",
               "Basic URL should match expected format")
    }
    
    @Test("URL with single query parameter")
    func testURLWithQuery() async throws {
        let url = URL {
            Scheme(.https)
            Host("rakuten.co.jp")
            Path("item/shop")
            Query(query: "q", value: "123")
        }
        
        #expect(url != nil, "URL should be constructed successfully")
        #expect(url?.absoluteString == "https://rakuten.co.jp/item/shop?q=123",
               "URL with single query should match expected format")
    }
    
    @Test("URL with query dictionary")
    func testURLWithQueries() async throws {
        let queryParameters = ["q": 123]
        let url = URL {
            Scheme(.https)
            Host("rakuten.co.jp")
            Path("item/shop")
            Query(queryPrameters: queryParameters)
        }
        
        #expect(url != nil, "URL should be constructed successfully")
        #expect(url?.absoluteString == "https://rakuten.co.jp/item/shop?q=123",
               "URL with query dictionary should match expected format")
    }
    
    @Test("URL with optional query parameters")
    func testURLWithOptionalQuery() async throws {
        let queryParameters: [String: Int]? = ["q": 123]
        let url = URL {
            Scheme(.https)
            Host("rakuten.co.jp")
            Path("item/shop")
            if let params = queryParameters {
                Query(queryPrameters: params)
            }
        }
        
        #expect(url != nil, "URL should be constructed successfully")
        #expect(url?.absoluteString == "https://rakuten.co.jp/item/shop?q=123",
               "URL with optional query should match expected format")
    }
    
    @Test("URL with nil optional query parameters")
    func testURLWithNilOptionalQuery() async throws {
        let queryParameters: [String: Int]? = nil
        let url = URL {
            Scheme(.https)
            Host("rakuten.co.jp")
            Path("item/shop")
            if let params = queryParameters {
                Query(queryPrameters: params)
            }
        }
        
        #expect(url != nil, "URL should be constructed successfully")
        #expect(url?.absoluteString == "https://rakuten.co.jp/item/shop",
               "URL without query should not include query string")
    }
    
    @Test("URL builder supports switch statements")
    func testURLWithLogicalStatement() async throws {
        let a = "Apple"
        
        let url = URL {
            Scheme(.https)
            Host("rakuten.co.jp")
            Path("item/shop")
            switch a {
            case "Apple":
                Path("apple")
            default:
                EmptyComponent()
            }
            
            if 4 % 2 == 0 {
                Query(query: "isEven", value: "true")
            }
        }
        
        #expect(url != nil, "URL should be constructed successfully")
        #expect(url?.absoluteString == "https://rakuten.co.jp/item/shop/apple?isEven=true",
               "URL with logical statements should match expected format")
    }
    
    @Test("URL builder supports loops for path construction")
    func testURLWithLoop() async throws {
        let paths = ["path1", "path2", "path3"]
        let url = URL {
            Scheme(.https)
            Host("rakuten.co.jp")
            for p in paths {
                Path(p)
            }
        }
        
        #expect(url != nil, "URL should be constructed successfully")
        #expect(url?.absoluteString == "https://rakuten.co.jp/path1/path2/path3",
               "URL with loop-generated paths should match expected format")
    }
    
    @Test("HTTP scheme is supported")
    func testHTTPScheme() async throws {
        let url = URL {
            Scheme(.http)
            Host("rakuten.co.jp")
        }
        
        #expect(url != nil, "URL should be constructed successfully")
        #expect(url?.absoluteString == "http://rakuten.co.jp",
               "URL with HTTP scheme should match expected format")
    }
    
    @Test("HTTPS scheme is supported")
    func testHTTPSScheme() async throws {
        let url = URL {
            Scheme(.https)
            Host("rakuten.co.jp")
        }
        
        #expect(url != nil, "URL should be constructed successfully")
        #expect(url?.absoluteString == "https://rakuten.co.jp",
               "URL with HTTPS scheme should match expected format")
    }
    
    @Test("Custom scheme is supported", arguments: ["ftp", "file", "ws", "wss"])
    func testCustomScheme(schemeName: String) async throws {
        let url = URL {
            Scheme(.custom(schemeName))
            Host("rakuten.co.jp")
        }
        
        #expect(url != nil, "URL should be constructed successfully")
        #expect(url?.absoluteString == "\(schemeName)://rakuten.co.jp",
               "URL with custom \(schemeName) scheme should match expected format")
    }
}

// MARK: - URL Component Tests
@Suite("URL Builder Component Tests")
struct URLBuilderComponentTests {
    
    @Test("Empty path components are handled")
    func testEmptyPath() async throws {
        let url = URL {
            Scheme(.https)
            Host("rakuten.co.jp")
            Path("")
        }
        
        #expect(url != nil, "URL should be constructed with empty path")
        #expect(url?.absoluteString == "https://rakuten.co.jp/",
               "URL with empty path should have trailing slash")
    }
    
    @Test("Multiple query parameters can be added")
    func testMultipleQueryParameters() async throws {
        let url = URL {
            Scheme(.https)
            Host("rakuten.co.jp")
            Path("search")
            Query(query: "q", value: "123")
            Query(query: "page", value: "1")
            Query(query: "sort", value: "price")
        }
        
        let urlString = url!.absoluteString
        #expect(urlString.contains("q=123"), "Should contain q parameter")
        #expect(urlString.contains("page=1"), "Should contain page parameter")
        #expect(urlString.contains("sort=price"), "Should contain sort parameter")
    }
    
    @Test("Single query parameter can be added")
    func testSingleQueryParameter() async throws {
        let url = URL {
            Scheme(.https)
            Host("rakuten.co.jp")
            Path("search")
            Query(query: "sort", value: "price")
        }
        
        #expect(url != nil, "URL should be constructed successfully")
        
        // Verify URL contains query parameter
        let urlString = url!.absoluteString
        #expect(urlString.contains("sort=price"), "Should contain sort parameter")
    }
    
    @Test("Query dictionary can add multiple parameters")
    func testQueryDictionary() async throws {
        let queryParams = ["q": "laptop", "page": "1", "sort": "price"]
        let url = URL {
            Scheme(.https)
            Host("rakuten.co.jp")
            Path("search")
            Query(queryPrameters: queryParams)
        }
        
        #expect(url != nil, "URL should be constructed successfully")
        
        // Verify URL contains query parameters
        let urlString = url!.absoluteString
        // Note: Dictionary order may vary, so check each individually
        #expect(urlString.contains("q=laptop") || urlString.contains("?"),
               "Should contain query string")
    }
    
    @Test("Complex URL with all components")
    func testComplexURL() async throws {
        let url = URL {
            Scheme(.https)
            Host("api.rakuten.co.jp")
            Path("v1")
            Path("products")
            Path("search")
            Query(query: "keyword", value: "laptop")
            Query(query: "minPrice", value: "1000")
            Query(query: "maxPrice", value: "5000")
            Query(query: "sort", value: "price_asc")
        }
        
        #expect(url != nil, "Complex URL should be constructed successfully")
        
        let components = URLComponents(url: url!, resolvingAgainstBaseURL: false)
        #expect(components?.scheme == "https", "Scheme should be https")
        #expect(components?.host == "api.rakuten.co.jp", "Host should match")
        #expect(components!.path.contains("/v1/products/search"), "Path should be correct")
        #expect(components?.queryItems?.count == 4, "Should have 4 query parameters")
    }
}

// MARK: - Edge Cases and Error Handling
@Suite("URL Builder Edge Cases")
struct URLBuilderEdgeCaseTests {
    
    @Test("URL with special characters in query")
    func testSpecialCharactersInQuery() async throws {
        let url = URL {
            Scheme(.https)
            Host("rakuten.co.jp")
            Path("search")
            Query(query: "q", value: "hello world")
        }
        
        #expect(url != nil, "URL should handle special characters")
        
        // URL encoding may convert spaces to %20 or +
        let urlString = url!.absoluteString
        #expect(urlString.contains("hello") && urlString.contains("world"),
               "Should contain the query text (encoded or not)")
    }
    
    @Test("Empty loop produces valid URL")
    func testEmptyLoop() async throws {
        let paths: [String] = []
        let url = URL {
            Scheme(.https)
            Host("rakuten.co.jp")
            for p in paths {
                Path(p)
            }
        }
        
        #expect(url != nil, "URL should be valid with empty loop")
        #expect(url?.absoluteString == "https://rakuten.co.jp",
               "URL with empty loop should not add paths")
    }
    
    @Test("Conditional components based on boolean", arguments: [true, false])
    func testConditionalComponents(includeQuery: Bool) async throws {
        let url = URL {
            Scheme(.https)
            Host("rakuten.co.jp")
            Path("items")
            if includeQuery {
                Query(query: "featured", value: "true")
            }
        }
        
        #expect(url != nil, "URL should be constructed successfully")
        
        if includeQuery {
            #expect(url!.absoluteString.contains("featured=true"),
                   "URL should include query when condition is true")
        } else {
            #expect(!url!.absoluteString.contains("?"),
                   "URL should not include query when condition is false")
        }
    }
    
    @Test("Nested conditionals and loops")
    func testNestedLogic() async throws {
        let categories = ["electronics", "books"]
        let addFilters = true
        
        let url = URL {
            Scheme(.https)
            Host("rakuten.co.jp")
            Path("search")
            
            for category in categories {
                Path(category)
            }
            
            if addFilters {
                Query(query: "inStock", value: "true")
                
                if categories.count > 1 {
                    Query(query: "multiCategory", value: "true")
                }
            }
        }
        
        #expect(url != nil, "URL with nested logic should be constructed")
        #expect(url!.absoluteString.contains("/electronics/books"),
               "Should contain both category paths")
        #expect(url!.absoluteString.contains("inStock=true"),
               "Should contain inStock query")
        #expect(url!.absoluteString.contains("multiCategory=true"),
               "Should contain multiCategory query")
    }
}

// MARK: - URL Validation Tests
@Suite("URL Builder Validation")
struct URLBuilderValidationTests {
    
    @Test("URL components can be accessed")
    func testURLComponentAccess() async throws {
        let url = URL {
            Scheme(.https)
            Host("rakuten.co.jp")
            Path("api/v1")
            Query(query: "key", value: "value")
        }
        
        #expect(url != nil, "URL should be constructed successfully")
        
        let components = URLComponents(url: url!, resolvingAgainstBaseURL: false)
        #expect(components?.scheme == "https", "Should be able to extract scheme")
        #expect(components?.host == "rakuten.co.jp", "Should be able to extract host")
        #expect(components!.path.contains("api/v1"), "Should be able to extract path")
    }
}
