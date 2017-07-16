//
//  ProductInformationCell.swift
//  JohnLewis
//
//  Created by Niall Watchorn on 16/07/2017.
//  Copyright © 2017 EpiTech. All rights reserved.
//

import UIKit

class ProductInformationCell: UITableViewCell {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var productCodeLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        descriptionLabel.text = nil
        productCodeLabel.text = nil
    }
}
