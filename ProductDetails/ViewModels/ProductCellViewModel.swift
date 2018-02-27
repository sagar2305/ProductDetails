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
    let shortDescription: String?
    let longDescription: String?
    let price: String
    let productImage: String?
    let reviewRating: Float
    let reviewCount: Int
    let inStock: Bool
    
    static func modelsFromData(_ data: [Product]?) -> [ProductCellViewModel]? {
        guard let data = data else {
            return nil
        }

        var models = [ProductCellViewModel]()
        for product in data {
            let model = ProductCellViewModel(productId: product.productId, productName: product.productName, shortDescription: product.shortDescription, longDescription: product.longDescription, price: product.price, productImage: product.productImage, reviewRating: product.reviewRating, reviewCount: product.reviewCount, inStock: product.inStock)
            models.append(model)
        }

        return models
    }
}
