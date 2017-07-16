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
    
    var media = [String]()
    var productInformation: String?
    var displaySpecialOffer: String?
    var includedServices: [String]?
    var code: String?
    
    var productSpecName: String?
    var productSpecValue: String?
    
    init(json: [String: Any]) {
        productId = json["productId"] as! String
        price = Price(json: json["price"] as! [String: Any])
        title = json["title"] as! String
        if let url = json["image"] as? String {
            image = "https:" + url
        } else {
            image = ""
        }
        
        if let media = json["media"] as? [String: Any], let images = media["images"] as? [String: Any] {
            if let urls = images["urls"] as? [String] {
                for url in urls {
                    self.media.append("https:" + url)
                }
            }
        }
        
        if let details = json["details"] as? [String: Any] {
            if let info = details["productInformation"] as? String, let features = details["features"] as? Array<[String: Any]> {
                productInformation = info
                if let attributes = features.first?["attributes"] as? Array<[String: Any]> {
                    if let name = attributes.first?["name"] as? String {
                        productSpecName = name
                    }
                    if let value = attributes.first?["value"] as? String {
                        productSpecValue = value
                    }
                }
            }
        }
        
        if let specialOffer = json["displaySpecialOffer"] as? String {
            displaySpecialOffer = specialOffer
        }
        
        if let additionalServices = json["additionalServices"] as? [String: Any], let inclServices = additionalServices["includedServices"] as? [String] {
            includedServices = inclServices
        }
        
        if let code = json["code"] as? String {
            self.code = code
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
