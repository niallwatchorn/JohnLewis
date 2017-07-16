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
    
    func testThatItCorrectlyParsesProductsJSON() {
        productsNetworkAdapter = ProductsNetworkAdapter(networkManager: MockNetworkManager())
        productsNetworkAdapter.getListOfProducts { (dishwashers, error) in
            XCTAssertNil(error)
            XCTAssertNotNil(dishwashers)
            XCTAssertEqual(dishwashers?.count, 5)
            
            XCTAssertEqual(dishwashers?.first?.title, "Samsung AX100")
            XCTAssertEqual(dishwashers?.first?.price.now, "225.00")
            XCTAssertEqual(dishwashers?.first?.price.currency, "GBP")
            XCTAssertEqual(dishwashers?.first?.image, "https://johnlewis.scene7.com/is/image/JohnLewis/234326372?")
        }
    }
    
    func testThatItCorrectlyParsesProductJSON() {
        productsNetworkAdapter = ProductsNetworkAdapter(networkManager: MockProductNetworkManager())
        productsNetworkAdapter.getProductWithId("1") { (dishwasher, error) in
            XCTAssertNil(error)
            XCTAssertNotNil(dishwasher)
            
            XCTAssertEqual(dishwasher?.title, "Samsung AX100")
            XCTAssertEqual(dishwasher?.productId, "1")
            XCTAssertEqual(dishwasher?.price.now, "225.00")
            XCTAssertEqual(dishwasher?.price.currency, "GBP")
            XCTAssertEqual(dishwasher?.image, "https://johnlewis.scene7.com/is/image/JohnLewis/234326372?")
            XCTAssertEqual(dishwasher?.media.first, "https://image1")
            XCTAssertEqual(dishwasher?.productInformation, "The door panel shown is for illustration purposes only")
            XCTAssertEqual(dishwasher?.displaySpecialOffer, "Reduced to clear")
            XCTAssertEqual(dishwasher?.includedServices?.first, "2 year service included")
            XCTAssertEqual(dishwasher?.code, "101")
            XCTAssertEqual(dishwasher?.productSpecName, "Dimensions")
            XCTAssertEqual(dishwasher?.productSpecValue, "H81.5 x W59.8 x D55cm")
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

struct MockErrorNetworkManager: NetworkManagerProtocol {
    
    func makeRequest(request: URLRequest, completion: @escaping ([String : Any]?, Error?) -> Void) {
        completion(nil, NetworkError.nilData)
    }
}

struct MockProductNetworkManager: NetworkManagerProtocol {
    
    func makeRequest(request: URLRequest, completion: @escaping ([String : Any]?, Error?) -> Void) {
        completion(mockProductJSON(), nil)
    }
    
    private func mockProductJSON() -> [String: Any] {
        return ["productId" : "1", "price" : ["now" : "225.00", "currency" : "GBP"], "title" : "Samsung AX100", "image" : "//johnlewis.scene7.com/is/image/JohnLewis/234326372?", "code" : "101", "displaySpecialOffer" : "Reduced to clear", "additionalServices" : ["includedServices" : ["2 year service included"]], "media" : ["images" : ["urls" : ["//image1", "//image2", "//image3"]]], "details" : ["productInformation" : "The door panel shown is for illustration purposes only", "features" : [["attributes" : [["name" : "Dimensions", "value" : "H81.5 x W59.8 x D55cm"]]]]]]
    }
}
