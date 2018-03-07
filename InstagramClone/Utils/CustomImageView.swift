//
//  CustomImageView.swift
//  InstagramClone
//
//  Created by Weijie Lin on 3/6/18.
//  Copyright © 2018 Weijie Lin. All rights reserved.
//

import UIKit

class CustomImageView: UIImageView {
    
    var lastURLUsedToLoadImage: String?
    
    func loadImage(urlString: String) {
        lastURLUsedToLoadImage = urlString
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            if let err = err {
                print("Failed to fetch profile image: ", err)
                return
            }
            
            if url.absoluteString != self.lastURLUsedToLoadImage {
                return
            }
            
            guard let imageData = data else { return }
            let image = UIImage(data: imageData)
            
            DispatchQueue.main.async {
                self.image = image
            }
            
            }.resume()
    }
    
}
