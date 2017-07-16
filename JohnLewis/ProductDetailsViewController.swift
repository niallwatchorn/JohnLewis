//
//  ProductDetailsViewController.swift
//  JohnLewis
//
//  Created by Niall Watchorn on 16/07/2017.
//  Copyright © 2017 EpiTech. All rights reserved.
//

import UIKit

class ProductDetailsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.rowHeight = UITableViewAutomaticDimension
            tableView.estimatedRowHeight = 45.0
        }
    }
    
    private var dishwasher: Dishwasher?
    private var error: Error?
    
    var networkAdapter = ProductsNetworkAdapter()
    var productId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let productId = productId {
            networkAdapter.getProductWithId(productId) { (dishwasher, error) in
                self.dishwasher = dishwasher
                self.error = error
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    // MARK: UICollectionView methods
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dishwasher == nil ? 0 : 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dishwasher?.media.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productImageCell", for: indexPath) as? ProductImageCell else {
            fatalError("Unable to dequeue cell for product images")
        }
        
        if let image = dishwasher?.media[indexPath.row] {
            cell.imageView.sd_setImage(with: URL(string: image))
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
    // MARK: TableViewMethods
    func numberOfSections(in tableView: UITableView) -> Int {
        return dishwasher == nil ? 0 : 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 1
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductPriceCell") as? ProductPriceCell else {
                fatalError("Unable to dequeue ProductPriceCell")
            }
            
            cell.priceLabel.text = "£" + (dishwasher?.price.now ?? "")
            cell.specialOfferLabel.text = dishwasher?.displaySpecialOffer
            cell.gurantueeLabel.text = dishwasher?.includedServices?.first
            
            return cell
            
        } else if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductInformationCell") as? ProductInformationCell else {
                fatalError("Unable to dequeue ProductInformationCell")
            }
            
            cell.descriptionLabel.text = dishwasher?.productInformation
            cell.productCodeLabel.text = dishwasher?.code.map {"Product code: " + $0}
            
            return cell
            
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductSpecCell") as? ProductSpecCell else {
                fatalError("Unable to dequeue ProductSpecCell")
            }
            
            cell.titleLabel.text = dishwasher?.productSpecName
            cell.detailLabel.text = dishwasher?.productSpecValue
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 { return nil }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SectionHeaderCell") as? SectionHeaderCell else {
            fatalError("Unable to dequeue SectionHeaderCell")
        }
        
        cell.titleLabel.text = section == 1 ? "Product information" : "Product specification"
        
        return cell.contentView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0.001
        }
        return 60.0
    }
}
