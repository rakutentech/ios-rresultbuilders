//
//  File.swift
//  File
//
//  Created by Mahadevaiah, Pavan | Pavan | ECMPD on 2021/08/27.
//


import XCTest
@testable import RResultBuilders

final class RURLBuilderTests: XCTestCase {
    func testBasicURL() {
        let url = URL {
            Scheme(.https)
            Host("rakuten.co.jp")
            Path("item/shop")            
        }
        
        XCTAssertEqual(url!.absoluteString, "https://rakuten.co.jp/item/shop")
    }
    
    func testURLWithQuery() {
        let url = URL {
            Scheme(.https)
            Host("rakuten.co.jp")
            Path("item/shop")
            Query(query: "q", value: "123")
        }
        
        XCTAssertEqual(url!.absoluteString, "https://rakuten.co.jp/item/shop?q=123")
    }
    
    func testURLWithQueries() {
        let queryParameters = ["q": 123]
        let url = URL {
            Scheme(.https)
            Host("rakuten.co.jp")
            Path("item/shop")
            Query(queryPrameters: queryParameters)
        }
        
        XCTAssertEqual(url!.absoluteString, "https://rakuten.co.jp/item/shop?q=123")
    }
    
    func testURLWithOptionalQuery() {
        let queryParameters: [String: Int]? = ["q": 123]
        let url = URL {
            Scheme(.https)
            Host("rakuten.co.jp")
            Path("item/shop")
            if let params = queryParameters {
                Query(queryPrameters: params)
            }
        }
        
        XCTAssertEqual(url!.absoluteString, "https://rakuten.co.jp/item/shop?q=123")
    }
    
    func testURLWithLogicalStatement() {
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
        
        XCTAssertEqual(url!.absoluteString, "https://rakuten.co.jp/item/shop/apple?isEven=true")
    }
    
    func testURLWithLoop() {
        let paths = ["path1", "path2", "path3"]
        let url = URL {
            Scheme(.https)
            Host("rakuten.co.jp")
            for p in paths {
                Path(p)
            }
        }
        
        XCTAssertEqual(url!.absoluteString, "https://rakuten.co.jp/path1/path2/path3")
    }
}

