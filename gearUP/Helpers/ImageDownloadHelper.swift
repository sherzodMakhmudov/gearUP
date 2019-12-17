//
//  ImageDownloadHelper.swift
//  gearUP
//
//  Created by Sherzod Makhmudov on 11/10/19.
//  Copyright © 2019 com.SherzodMakhmudov. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, AnyObject>()
extension UIImageView{
    
    func cacheProfileImages(imageURL: String){
        self.image = nil //blank out the profileImageView till the image is downloaded
        
        //Check if there is an image in cache bank
        if let cachedImages = imageCache.object(forKey: imageURL as NSString) as? UIImage{
            self.image = cachedImages
            return
        }
        
        guard let url = URL(string: imageURL) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil{
                print("Image download hit an error", error!)
                return
            }
            
            DispatchQueue.main.async { //Read about dispatch main queue. If i dont use this function my code crashes with an error background thread and does not load the image
                
                if let downloadedImage = UIImage(data: data!){
                    imageCache.setObject(downloadedImage, forKey: imageURL as NSString)
                    self.image = downloadedImage
                }
            }
                
        }.resume()
    }
}
