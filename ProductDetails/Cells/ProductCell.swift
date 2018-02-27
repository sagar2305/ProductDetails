//
//  ProductCell.swift
//  ProductDetails
//
//  Created by Sagar Mutha on 2/26/18.
//  Copyright © 2018 Sagar Mutha. All rights reserved.
//

import UIKit

class ProductCell: UITableViewCell {

    @IBOutlet private weak var productImage: UIImageView!
    @IBOutlet private weak var productName: UILabel!
    private var imageUrl: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.productImage.image = nil
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configure(_ viewModel: ProductCellViewModel, imageProvider: ImageProvider) {
        imageUrl = viewModel.productImage
        productName.text = viewModel.productName
        setCellImage(viewModel, imageProvider: imageProvider)
    }
}

extension ProductCell: ImageSettable {
    var cellImageView: UIImageView {
        return productImage
    }
    
    var validUrl: String? {
        return imageUrl
    }
}
