//
//  ProductDetailsViewController.swift
//  ProductDetails
//
//  Created by Sagar Mutha on 2/27/18.
//  Copyright © 2018 Sagar Mutha. All rights reserved.
//

import UIKit

class ProductDetailsViewController: UIViewController {

    @IBOutlet private weak var collectionView: UICollectionView!
    weak var productsViewModel: ProductsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        let indexToScrollTo = IndexPath(item: productsViewModel.selectedIndex, section: 0)
        self.collectionView.scrollToItem(at: indexToScrollTo, at: .left, animated: false)
    }
    
    func initView() {
        title = Constants.ProductDetailsVC.title
        collectionView.register(UINib(nibName: Constants.CellReuseIdentifier.productDetails, bundle: nil), forCellWithReuseIdentifier: Constants.CellReuseIdentifier.productDetails)
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
        }
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
    }
}

extension ProductDetailsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productsViewModel.numberOfProducts
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellReuseIdentifier.productDetails, for: indexPath) as? ProductDetailsCell else {
            fatalError(Constants.Error.productDetailsCellLoad)
        }
        
        productsViewModel.configureProductDetailsCell(cell: cell, at: indexPath.item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height-64)
    }
}
