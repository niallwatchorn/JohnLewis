//
//  ProductsGridViewModel.swift
//  JohnLewis
//
//  Created by Niall Watchorn on 14/07/2017.
//  Copyright © 2017 EpiTech. All rights reserved.
//

import UIKit
import SDWebImage

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
    
    func cellForItemAtIndexPath(_ indexPath: IndexPath, collectionView: UICollectionView) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductGridCell", for: indexPath) as? ProductGridCell else {
            fatalError("Unable to dequeue ProductGridCell")
        }
        
        let dishwasher = dishwashers[indexPath.row]
        
        cell.imageView.sd_setImage(with: URL(string: dishwasher.image))
        cell.titleLabel.text = dishwasher.title
        cell.priceLabel.text = "£" + dishwasher.price.now
        
        return cell
    }
}
