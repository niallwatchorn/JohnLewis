//
//  ProductsGridViewModel.swift
//  JohnLewis
//
//  Created by Niall Watchorn on 14/07/2017.
//  Copyright © 2017 EpiTech. All rights reserved.
//

import Foundation

protocol ProductsGridViewModelProtocol: class {
    func reloadData()
    func errorOccured(error: Error)
}

class ProductsGridViewModel {
    
    private var networkAdapter: ProductsNetworkAdapter
    private var dishwashers = [Dishwasher]()
    
    weak var delegate: ProductsGridViewModelProtocol?
    
    init(networkAdapter: ProductsNetworkAdapter = ProductsNetworkAdapter()) {
        self.networkAdapter = networkAdapter
        
        networkAdapter.getListOfProducts { (dishwashers, error) in
            if let error = error {
                self.delegate?.errorOccured(error: error)
            } else {
                guard let dishwashers = dishwashers else {
                    return
                }
                
                for dishwasher in dishwashers {
                    self.dishwashers.append(dishwasher)
                }
                
                self.delegate?.reloadData()
            }
        }
    }
    
    func title() -> String {
        return "Dishwashers"
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfItemsInSection(_ section: Int) -> Int {
        return dishwashers.count
    }
}
