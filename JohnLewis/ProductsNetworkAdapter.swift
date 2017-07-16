//
//  ProductsNetworkAdapter.swift
//  JohnLewis
//
//  Created by Niall Watchorn on 14/07/2017.
//  Copyright © 2017 EpiTech. All rights reserved.
//

import Foundation

class ProductsNetworkAdapter {
    private var networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func getListOfProducts(_ completion: @escaping ([Dishwasher]?, Error?) -> Void) {
        guard let url = URL(string:Strings.baseURL + Strings.searchURL + "&" + Strings.apiKey + Strings.pageSize) else {
            completion(nil, nil)
            return
        }
        
        let request = URLRequest(url: url)
        networkManager.makeRequest(request: request) { (json, error) in
            if error != nil {
                completion(nil, error)
            } else {
                if let products = json?["products"] as? Array<[String: Any]> {
                    var productsArray = [Dishwasher]()
                    for productJSON in products {
                        productsArray.append(Dishwasher(json: productJSON))
                    }
                    completion(productsArray, nil)
                } else {
                    completion(nil, NetworkError.productsNotFound)
                }
            }
        }
    }
    
    func getProductWithId(_ id: String, _ completion: @escaping (Dishwasher?, Error?) -> Void) {
        guard let url = URL(string: Strings.baseURL + id + "?" + Strings.apiKey) else {
            completion(nil, nil)
            return
        }
        
        let request = URLRequest(url: url)
        networkManager.makeRequest(request: request) { (json, error) in
            if error != nil {
                completion(nil, error)
            } else {
                if let json = json {
                    completion(Dishwasher(json: json), nil)
                } else {
                    completion(nil, NetworkError.nilJSON)
                }
            }
        }
    }
}

fileprivate struct Strings {
    static let baseURL = "https://api.johnlewis.com/v1/products/"
    static let searchURL = "search?q=dishwasher"
    static let apiKey = "key=Wu1Xqn3vNrd1p7hqkvB6hEu0G9OrsYGb"
    static let pageSize = "&pageSize=20"
}
