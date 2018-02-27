//
//  ProductsClient.swift
//  ProductDetails
//
//  Created by Sagar Mutha on 2/26/18.
//  Copyright © 2018 Sagar Mutha. All rights reserved.
//

import Foundation

protocol ProductsClientProtocol {
    func fetchProducts(completion: @escaping ([Product]?)->())
}

struct ProductsClient: ProductsClientProtocol {
    func fetchProducts(completion: @escaping ([Product]?)->()) {
        let urlSession = URLSession.shared
        
        let urlString = Constants.productsEndpoint
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        let dataTask = urlSession.dataTask(with: url) { (data, response, error) in
            // check for errors
            guard error == nil else {
                print("ProductsClient request error - \(error.debugDescription)")
                completion(nil)
                return
            }
            
            // check http response valid
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(nil)
                return
            }
            
            // check data valid
            guard let data = data else {
                completion(nil)
                return
            }
            
            do {
                let productsList = try JSONDecoder().decode(ProductsList.self, from: data)
                print("\(productsList)")
                completion(productsList.products)
            } catch let jsonErr {
                print(jsonErr.localizedDescription)
            }
        }
        dataTask.resume()
    }
}
