//
//  UIImageViewExtension.swift
//  Axios Excercise
//
//  Created by Jake Dunahee on 5/15/18.
//  Copyright © 2018 Jake Dunahee. All rights reserved.
//

import UIKit

extension UIImageView {
    
    // Handles downloading images in tableView
    public func downloadImage(withUrl url:String, placeHolder: UIImage) {
        // Set placeholder image before making request
        image = placeHolder
        
        // Make to get image and set on main queue when done
        URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, error) in
            if (error == nil && data != nil) {
                DispatchQueue.main.async {
                    self.image = UIImage(data: data!)
                }
            } else {
                print("Error getting poster image - ", error?.localizedDescription ?? "")
            }
        }.resume()
    }
    
}
