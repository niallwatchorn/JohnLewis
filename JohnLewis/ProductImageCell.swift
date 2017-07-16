//
//  ProductImageCell.swift
//  JohnLewis
//
//  Created by Niall Watchorn on 16/07/2017.
//  Copyright © 2017 EpiTech. All rights reserved.
//

import UIKit

class ProductImageCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
    }
}
