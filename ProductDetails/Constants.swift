//
//  Constants.swift
//  ProductDetails
//
//  Created by Sagar Mutha on 2/26/18.
//  Copyright © 2018 Sagar Mutha. All rights reserved.
//

struct Constants {
    static let productsEndpoint = "https://walmartlabs-test.appspot.com/_ah/api/walmart/v1/walmartproducts/c7a363d8-874d-49a7-8744-a2f228e4e705"
    
    struct ProductsListVC {
        static let title = "Products"
    }
    
    struct ProductDetailsVC {
        static let title = "Product Details"
        static let outOfStock = "OUT OF STOCK"
    }
    
    struct Error {
        static let productCellLoad = "Could not load ProductCell"
        static let productDetailsCellLoad = "Could not load ProductDetailsCell"
    }
    
    struct CellReuseIdentifier {
        static let product = "ProductCell"
        static let productDetails = "ProductDetailsCell"
    }
}
