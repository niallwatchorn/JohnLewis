//
//  ProductsNetworkAdapterTests.swift
//  JohnLewis
//
//  Created by Niall Watchorn on 14/07/2017.
//  Copyright © 2017 EpiTech. All rights reserved.
//

import XCTest
@testable import JohnLewis

class ProductsNetworkAdapterTests: XCTestCase {
    
    private var productsNetworkAdapter: ProductsNetworkAdapter!
    
    override func setUp() {
        super.setUp()
        
        productsNetworkAdapter = ProductsNetworkAdapter(networkManager: MockNetworkManager())
    }
    
    func testThatItCorrectlyParsesJSON() {
        productsNetworkAdapter.getListOfProducts { (dishwashers, error) in
            XCTAssertNil(error)
            XCTAssertNotNil(dishwashers)
            XCTAssertEqual(dishwashers?.count, 5)
            
            XCTAssertEqual(dishwashers?.first?.title, "Samsung AX100")
            XCTAssertEqual(dishwashers?.first?.price.now, "225.00")
        }
    }
}

struct MockNetworkManager: NetworkManagerProtocol {
    
    func makeRequest(request: URLRequest, completion: @escaping ([String : Any]?, Error?) -> Void) {
        completion(mockProductsJSON(), nil)
    }
    
    private func mockProductsJSON() -> [String: Any] {
        return ["products" : [
            ["productId" : "1", "price" : ["now" : "225.00", "currency" : "GBP"], "title" : "Samsung AX100", "image" : "//johnlewis.scene7.com/is/image/JohnLewis/234326372?"],
            ["productId" : "2", "price" : ["now" : "205.00", "currency" : "GBP"], "title" : "Samsung AX200", "image" : "//johnlewis.scene7.com/is/image/JohnLewis/234326372?"],
            ["productId" : "3", "price" : ["now" : "329.00", "currency" : "GBP"], "title" : "Samsung AX300", "image" : "//johnlewis.scene7.com/is/image/JohnLewis/234326372?"],
            ["productId" : "4", "price" : ["now" : "179.00", "currency" : "GBP"], "title" : "Samsung AX400", "image" : "//johnlewis.scene7.com/is/image/JohnLewis/234326372?"],
            ["productId" : "5", "price" : ["now" : "449.00", "currency" : "GBP"], "title" : "Samsung AX500", "image" : "//johnlewis.scene7.com/is/image/JohnLewis/234326372?"]
        ]]
    }
}
