//
//  ImageSettable.swift
//  ProductDetails
//
//  Created by Sagar Mutha on 2/26/18.
//  Copyright © 2018 Sagar Mutha. All rights reserved.
//

import Foundation
import UIKit

protocol ImageSettable {
    func setCellImage(_ viewModel: ProductCellViewModel, imageProvider: ImageProvider)
    var cellImageView: UIImageView { get }
    var validUrl: String? { get }
}

extension ImageSettable {
    func setCellImage(_ viewModel: ProductCellViewModel, imageProvider: ImageProvider) {
        guard let url = viewModel.productImage else {
            return
        }
        
        // check if image exists in cache
        if let image = imageProvider.cachedImage(for: url) {
            cellImageView.image = image
            return
        }
        
        // fetch image
        imageProvider.fetchImage(for: url, completion: { (image) in
            DispatchQueue.main.async {
                // check if the cell that requested the image is still around
                if self.validUrl == viewModel.productImage {
                    self.cellImageView.setImageAnimated(image)
                }
            }
        })
    }
}
