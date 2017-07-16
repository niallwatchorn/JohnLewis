//
//  ProductPriceCell.swift
//  JohnLewis
//
//  Created by Niall Watchorn on 16/07/2017.
//  Copyright © 2017 EpiTech. All rights reserved.
//

import UIKit

class ProductPriceCell: UITableViewCell {
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var specialOfferLabel: UILabel!
    @IBOutlet weak var gurantueeLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        priceLabel.text = nil
        specialOfferLabel.text = nil
        gurantueeLabel.text = nil
    }
}
