//
//  UIImageViewExtensions.swift
//  ProductDetails
//
//  Created by Sagar Mutha on 2/26/18.
//  Copyright © 2018 Sagar Mutha. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func setImageAnimated(_ image: UIImage?) {
        guard let image = image else {
            return
        }
        
        UIView.transition(with: self, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.image = image
        }, completion: nil)
    }
}
