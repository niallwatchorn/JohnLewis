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
    
    
}

struct MockNetworkManager: NetworkManagerProtocol {
    
    func makeRequest(request: URLRequest, completion: @escaping ([String : Any]?, Error?) -> Void) {
        
    }
}
