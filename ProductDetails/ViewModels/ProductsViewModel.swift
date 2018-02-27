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
    var reloadTableViewClosure: (([IndexPath])->())?
    var selectedIndex: Int = 0
    
    // paging
    private let pageSize = 20
    private var totalProducts = 0
    private var currentPage = 0
    private var fetchInProgress = false
    
    // insert new rows once view model updated
    private var cellViewModels: [ProductCellViewModel] = [ProductCellViewModel]() {
        didSet {
            let start = numberOfProducts - 20 < 0 ? 0 : numberOfProducts - 20
            let indexPaths = (start..<numberOfProducts).map {IndexPath(row: $0, section: 0)}
            self.reloadTableViewClosure?(indexPaths)
        }
    }
    
    var numberOfProducts: Int {
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
    
    private func fetchProducts() {
        productsClient.fetchProducts(currentPage: currentPage, pageSize: pageSize) { [weak self] (productsList) in
            self?.fetchInProgress = false
            guard let productsList = productsList else {
                return
            }
            
            self?.totalProducts = productsList.totalProducts
            guard let cellModels = ProductCellViewModel.modelsFromData(productsList.products) else {
                return
            }
            if self?.currentPage == 1 {
                self?.cellViewModels = cellModels
            } else {
                self?.cellViewModels.append(contentsOf: cellModels)
            }
        }
    }
    
    private func isFirstPage() -> Bool {
        return currentPage == 0
    }
    
    func fetchNextPage() {
        if fetchInProgress {
            return
        }
        
        if numberOfProducts < totalProducts || isFirstPage() {
            currentPage += 1
            fetchInProgress = true
            fetchProducts()
        }
    }
}

// setup product list cell
extension ProductsViewModel {
    func configureProductListCell(cell: ProductCell, at index: Int) {
        let cellViewModel = cellViewModels[index]
        cell.configure(cellViewModel, imageProvider: imageProvider)
        if index == numberOfProducts - 5 {
            fetchNextPage()
        }
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
    func configureProductDetailsCell(cell: ProductDetailsCell, at index: Int) {
        let cellViewModel = cellViewModels[index]
        cell.configure(cellViewModel, imageProvider: imageProvider)
    }
}

