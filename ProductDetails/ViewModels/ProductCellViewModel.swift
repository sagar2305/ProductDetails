//
//  ProductCellViewModel.swift
//  ProductDetails
//
//  Created by Sagar Mutha on 2/26/18.
//  Copyright © 2018 Sagar Mutha. All rights reserved.
//

import Foundation

struct ProductCellViewModel {
    
    let productId: String
    let productName: String
    let longDescription: String?
    let currentPrice: String
    let productImage: String?
    
    static func modelsFromData(_ data: [Product]?) -> [ProductCellViewModel]? {
        guard let data = data else {
            return nil
        }

        var models = [ProductCellViewModel]()
        for product in data {
            let currentPrice = product.inStock ? product.price : Constants.ProductDetailsVC.outOfStock
            let model = ProductCellViewModel(productId: product.productId, productName: product.productName, longDescription: product.longDescription, currentPrice: currentPrice, productImage: product.productImage)
            models.append(model)
        }

        return models
    }
}
