//
//  Dishwasher.swift
//  JohnLewis
//
//  Created by Niall Watchorn on 14/07/2017.
//  Copyright © 2017 EpiTech. All rights reserved.
//

import Foundation

struct Dishwasher {
    let productId: String
    let price: Price
    let title: String
    let image: String
    
    init(json: [String: Any]) {
        productId = json["productId"] as! String
        price = Price(json: json["price"] as! [String: Any])
        title = json["title"] as! String
        if let url = json["image"] as? String {
            image = "https:" + url
        } else {
            image = ""
        }
    }
}

struct Price {
    let now: String
    let currency: String
    
    init(json: [String: Any]) {
        now = json["now"] as! String
        currency = json["currency"] as! String
    }
}
