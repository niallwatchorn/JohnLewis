//
//  ProductsGridViewModelTests.swift
//  JohnLewis
//
//  Created by Niall Watchorn on 14/07/2017.
//  Copyright © 2017 EpiTech. All rights reserved.
//

import XCTest
@testable import JohnLewis

class ProductsGridViewModelTests: XCTestCase {
    
    var viewModel: ProductsGridViewModel!
    
    override func setUp() {
        super.setUp()
        
        let mockNetwork = MockNetworkManager()
        let networkAdapter = ProductsNetworkAdapter(networkManager: mockNetwork)
        viewModel = ProductsGridViewModel(networkAdapter: networkAdapter)
    }
    
    func testThatItReturnsTheCorrectTitle() {
        XCTAssertEqual(viewModel.title(), "Dishwashers")
    }
}
