//
//  ProductDetailsViewController.swift
//  JohnLewis
//
//  Created by Niall Watchorn on 16/07/2017.
//  Copyright © 2017 EpiTech. All rights reserved.
//

import UIKit

class ProductDetailsViewController: UIViewController {
    
    let networkAdapter = ProductsNetworkAdapter()
    var productId: String?
    
    private var dishwasher: Dishwasher?
    private var error: Error?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let productId = productId {
            networkAdapter.getProductWithId(productId) { (dishwasher, error) in
                self.dishwasher = dishwasher
                self.error = error
            }
        }
    }
}
