//
//  ProductsList.swift
//  ProductDetails
//
//  Created by Sagar Mutha on 2/26/18.
//  Copyright © 2018 Sagar Mutha. All rights reserved.
//

struct ProductsList: Decodable {
    let pageNumber: Int
    let pageSize: Int
    let totalProducts: Int
    let id: String
    let products: [Product]
}
