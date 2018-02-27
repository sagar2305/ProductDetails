//
//  ProductsList.swift
//  ProductDetails
//
//  Created by Sagar Mutha on 2/26/18.
//  Copyright © 2018 Sagar Mutha. All rights reserved.
//

import UIKit

class ProductsListViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    lazy var productsViewModel: ProductsViewModel = {
        let client = ProductsClient()
        return ProductsViewModel(client: client)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initView()
        initViewModel()
    }
    
    func initView() {
        title = Constants.ProductsListVC.title
        
        tableView.register(UINib(nibName: Constants.CellReuseIdentifier.product, bundle: nil), forCellReuseIdentifier: Constants.CellReuseIdentifier.product)
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func startActivityIndicator() {
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
    }
    
    func stopActivityIndicator() {
        if !activityIndicator.isAnimating {
            return
        }
        activityIndicator.stopAnimating()
    }
    
    func initViewModel() {
        startActivityIndicator()
        productsViewModel.fetchNextPage()
        
        // insert new rows in tableview
        productsViewModel.reloadTableViewClosure = { (indexpaths) in
            DispatchQueue.main.async {
                self.stopActivityIndicator()
                self.tableView.insertRows(at: indexpaths, with: .none)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ProductsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productsViewModel.numberOfProducts
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellReuseIdentifier.product) as? ProductCell else {
            fatalError(Constants.Error.productCellLoad)
        }
        
        productsViewModel.configureProductListCell(cell: cell, at: indexPath.row)
        return cell
    }
}

extension ProductsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // cancel any pending image requests for the cell
        productsViewModel.didEndDisplayingCell(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        productsViewModel.selectedIndex = indexPath.row
        return indexPath
    }
}

extension ProductsListViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ProductsListViewController {
            vc.productsViewModel = productsViewModel
        }
    }
}

