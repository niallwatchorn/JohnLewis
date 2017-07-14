//
//  ProductsGridViewController.swift
//  JohnLewis
//
//  Created by Niall Watchorn on 14/07/2017.
//  Copyright © 2017 EpiTech. All rights reserved.
//

import UIKit

class ProductsGridViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, ProductsGridViewModelProtocol {

    @IBOutlet weak var collectionView: UICollectionView!
    var viewModel = ProductsGridViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        title = viewModel.title()
    }
    
    // MARK: UICollectionView methods
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection(section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return viewModel.cellForItemAtIndexPath(indexPath, collectionView: collectionView)
    }
    
    // MARK: ProductsGridViewModelDelegate methods
    func reloadData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func errorOccured(error: Error) {
        
    }
}
