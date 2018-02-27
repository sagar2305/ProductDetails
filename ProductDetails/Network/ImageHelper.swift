//
//  ImageHelper.swift
//  ProductDetails
//
//  Created by Sagar Mutha on 2/26/18.
//  Copyright © 2018 Sagar Mutha. All rights reserved.
//

import Foundation
import UIKit

protocol ImageProvider {
    func cachedImage(for url: String) -> UIImage?
    func fetchImage(for urlStr: String, completion: @escaping (UIImage?) -> Void)
    func cancelFetchRequest(forImage url: String?)
    func cancelAllFetchRequests()
}

class ImageHelper: ImageProvider {
    
    let operationQueue: OperationQueue
    var operationsDictionary: [String: Operation]
    let imageCache: NSCache<NSString, UIImage>
    
    init(queue: OperationQueue, dict: [String: Operation], cache: NSCache<NSString, UIImage>) {
        operationQueue = queue
        operationsDictionary = dict
        imageCache = cache
        operationQueue.maxConcurrentOperationCount = 3
    }
    
    func cachedImage(for url: String) -> UIImage? {
        if let image = imageCache.object(forKey: url as NSString) {
            return image
        }
        
        return nil
    }
    
    func fetchImage(for urlStr: String, completion: @escaping (UIImage?) -> Void) {
        
        // fetch the image from url
        let operation = BlockOperation {
            guard let url = URL(string: urlStr) else {
                completion(nil)
                return
            }
            
            guard let data = try?Data(contentsOf: url) else {
                completion(nil)
                return
            }
            
            guard let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            
            // add image to the cache
            self.imageCache.setObject(image, forKey: urlStr as NSString)
            completion(image)
        }
        
        operationsDictionary[urlStr] = operation
        operationQueue.addOperation(operation)
    }
    
    func cancelFetchRequest(forImage url: String?) {
        guard let url = url else {
            return
        }
        
        if let operation = operationsDictionary[url] {
            operation.cancel()
            operationsDictionary[url] = nil
        }
    }
    
    func cancelAllFetchRequests() {
        operationQueue.cancelAllOperations()
        operationsDictionary.removeAll()
    }
}
