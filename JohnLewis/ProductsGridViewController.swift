//
//  ProductsGridViewController.swift
//  JohnLewis
//
//  Created by Niall Watchorn on 14/07/2017.
//  Copyright © 2017 EpiTech. All rights reserved.
//

import UIKit

class ProductsGridViewController: UIViewController {

    private let viewModel = ProductsGridViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = viewModel.title()
    }
}
