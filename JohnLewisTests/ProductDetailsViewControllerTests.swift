//
//  ProductDetailsViewControllerTests.swift
//  JohnLewis
//
//  Created by Niall Watchorn on 16/07/2017.
//  Copyright © 2017 EpiTech. All rights reserved.
//

import XCTest
@testable import JohnLewis

class ProductDetailsViewControllerTests: XCTestCase {
    
    var viewController: ProductDetailsViewController!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        viewController = storyboard.instantiateViewController(withIdentifier: "ProductDetailViewController") as! ProductDetailsViewController
        _ = viewController.view
    }
    
    func testThatItReturnsCorrectNumberOfSectionsWhenDishwasherIsNil() {
        XCTAssertEqual(viewController.collectionView.numberOfSections, 0)
        XCTAssertEqual(viewController.tableView.numberOfSections, 0)
    }
    
    func testThatItReturnsCorrectNumberOfSectionsWhenDishwasherIsNotNil() {
        viewController.networkAdapter = ProductsNetworkAdapter(networkManager: MockProductNetworkManager())
        viewController.productId = "1"
        viewController.viewDidLoad()
        
        XCTAssertEqual(viewController.collectionView.numberOfSections, 1)
        XCTAssertEqual(viewController.tableView.numberOfSections, 3)
    }
}
