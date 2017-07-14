//
//  ProductsGridViewModel.swift
//  JohnLewis
//
//  Created by Niall Watchorn on 14/07/2017.
//  Copyright © 2017 EpiTech. All rights reserved.
//

import Foundation

struct ProductsGridViewModel {
    
    private var networkAdapter: ProductsNetworkAdapter
    
    init(networkAdapter: ProductsNetworkAdapter = ProductsNetworkAdapter()) {
        self.networkAdapter = networkAdapter
    }
    
    func title() -> String {
        return "Dishwashers"
    }
}
