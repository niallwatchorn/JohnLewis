//
//  NetworkManager.swift
//  JohnLewis
//
//  Created by Niall Watchorn on 14/07/2017.
//  Copyright © 2017 EpiTech. All rights reserved.
//

import Foundation

protocol NetworkManagerProtocol {
    func makeRequest(request: URLRequest, completion: @escaping (_ products: [String: Any]?, _ error: Error?) -> Void)
}

class NetworkManager: NetworkManagerProtocol {
    
    func makeRequest(request: URLRequest, completion: @escaping (_ products: [String: Any]?, _ error: Error?) -> Void) {
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            if error != nil {
                completion(nil, error)
            } else {
                if let data = data {
                    do {
                        let productsJSON = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                        completion(productsJSON, nil)
                    } catch {
                        completion(nil, error)
                    }
                } else {
                    completion(nil, NetworkError.nilData)
                }
            }
        }
        
        task.resume()
    }
}

enum NetworkError: Error {
    case nilData
    case nilJSON
    case productsNotFound
}
