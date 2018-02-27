//
//  Products.swift
//  ProductDetails
//
//  Created by Sagar Mutha on 2/26/18.
//  Copyright © 2018 Sagar Mutha. All rights reserved.
//

struct Product : Decodable {
    let productId: String
    let productName: String
    let shortDescription: String?
    let longDescription: String?
    let price: String
    let productImage: String?
    let reviewRating: Float
    let reviewCount: Int
    let inStock: Bool
}

extension Product : Equatable {
    static func ==(lhs: Product, rhs: Product) -> Bool {
        return lhs.productId == rhs.productId
    }
}

