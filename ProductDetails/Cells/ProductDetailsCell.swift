//
//  ProductDetailsCell.swift
//  ProductDetails
//
//  Created by Sagar Mutha on 2/26/18.
//  Copyright © 2018 Sagar Mutha. All rights reserved.
//

import UIKit

class ProductDetailsCell: UICollectionViewCell {
    @IBOutlet private weak var productImage: UIImageView!
    @IBOutlet private weak var productName: UILabel!
    @IBOutlet private weak var productDescription: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    private var imageUrl: String?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        productImage.image = nil
        productName.text = nil
        productDescription.text = nil
        priceLabel.text = nil
    }
    
    func configure(_ viewModel: ProductCellViewModel, imageProvider: ImageProvider) {
        imageUrl = viewModel.productImage
        productName.text = viewModel.productName
        productDescription.text = viewModel.longDescription
        priceLabel.text = viewModel.currentPrice
        setCellImage(viewModel, imageProvider: imageProvider)
    }
}

// MARK:- ProductDetailsCell
extension ProductDetailsCell: ImageSettable {
    var cellImageView: UIImageView {
        return productImage
    }
    
    var validUrl: String? {
        return imageUrl
    }
}

