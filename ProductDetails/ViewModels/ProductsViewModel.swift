//
//  ProductsListViewModel.swift
//  ProductDetails
//
//  Created by Sagar Mutha on 2/26/18.
//  Copyright © 2018 Sagar Mutha. All rights reserved.
//

import Foundation
import UIKit

class ProductsViewModel {
    
    private let productsClient: ProductsClientProtocol
    var reloadTableViewClosure: (()->())?
    var selectedIndex: Int = 0
    
    private var cellViewModels: [ProductCellViewModel] = [ProductCellViewModel]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    
    var numberOfRoutes: Int {
        return cellViewModels.count
    }
    
    lazy var imageProvider: ImageProvider = {
        let queue = OperationQueue()
        let dict:[String: Operation] = [:]
        let cache = NSCache<NSString, UIImage>()
        return ImageHelper(queue: queue, dict: dict, cache: cache)
    }()
    
    init(client: ProductsClientProtocol) {
        self.productsClient = client
    }
    
    func fetchProducts() {
        productsClient.fetchProducts { [weak self] (products) in
            guard let cellModels = ProductCellViewModel.modelsFromData(products) else {
                return
            }
            self?.cellViewModels = cellModels
        }
    }
}

// setup product list cell
extension ProductsViewModel {
    func configureRouteListCell(cell: ProductCell, at index: Int) {
        let cellViewModel = cellViewModels[index]
        cell.configure(cellViewModel, imageProvider: imageProvider)
    }

    func didEndDisplayingCell(at index: Int) {
        let cellViewModel = cellViewModels[index]
        imageProvider.cancelFetchRequest(forImage: cellViewModel.productImage)
    }

    func didSelectRow(at index: Int) {
        self.selectedIndex = index
    }
}

// setup product details cell
extension ProductsViewModel {
    func configureRouteDetailsCell(cell: ProductDetailsCell, at index: Int) {
        let cellViewModel = cellViewModels[index]
        cell.configure(cellViewModel, imageProvider: imageProvider)
    }
}

