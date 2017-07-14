//
//  ProductsGridViewControllerTests.swift
//  JohnLewis
//
//  Created by Niall Watchorn on 14/07/2017.
//  Copyright © 2017 EpiTech. All rights reserved.
//

import XCTest
@testable import JohnLewis

class ProductsGridViewControllerTests: XCTestCase {
    
    var viewController: ProductsGridViewController!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        viewController = storyboard.instantiateViewController(withIdentifier: "ProductsGridViewController") as! ProductsGridViewController
        _ = viewController.view
    }
    
    func testThatItSetsUpCorrectly() {
        XCTAssertEqual(viewController.numberOfSections(in: viewController.collectionView), 1)
        XCTAssertEqual(viewController.collectionView(viewController.collectionView, numberOfItemsInSection: 0), 0)
    }
    
    func testThatItReloadsDataCorrectly() {
        let networkAdapter = ProductsNetworkAdapter(networkManager: MockNetworkManager())
        viewController.viewModel = ProductsGridViewModel(networkAdapter: networkAdapter, delegate: viewController)
        
        XCTAssertEqual(viewController.numberOfSections(in: viewController.collectionView), 1)
        XCTAssertEqual(viewController.collectionView(viewController.collectionView, numberOfItemsInSection: 0), 5)
    }
    
    func testThatItHandlesNetworkErrorProperly() {
        let networkAdapter = ProductsNetworkAdapter(networkManager: MockErrorNetworkManager())
        viewController.viewModel = ProductsGridViewModel(networkAdapter: networkAdapter, delegate: viewController)
        
        XCTAssertEqual(viewController.numberOfSections(in: viewController.collectionView), 1)
        XCTAssertEqual(viewController.collectionView(viewController.collectionView, numberOfItemsInSection: 0), 0)
        XCTAssertNotNil(viewController.error)
        XCTAssert(viewController.error is NetworkError)
    }
    
    func testThatItCorrectlySetsUpCells() {
        let networkAdapter = ProductsNetworkAdapter(networkManager: MockNetworkManager())
        viewController.viewModel = ProductsGridViewModel(networkAdapter: networkAdapter, delegate: viewController)
        
        let cell = viewController.collectionView(viewController.collectionView, cellForItemAt: IndexPath(row: 0, section: 0)) as! ProductGridCell
        
        XCTAssertEqual(cell.titleLabel.text, "Samsung AX100")
        XCTAssertEqual(cell.priceLabel.text, "£225.00")
    }
}
