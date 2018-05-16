//
//  UIColorExtension.swift
//  Axios Excercise
//
//  Created by Jake Dunahee on 5/15/18.
//  Copyright © 2018 Jake Dunahee. All rights reserved.
//

import UIKit

extension UIColor {
    
    // Ability to fetch UIColor with hex code
    public class func colorWithHexCode(hex: String) -> UIColor {
        var colorString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        // Remove '#' if added
        if (colorString.hasPrefix("#")) {
            colorString.remove(at: colorString.startIndex)
        }
        
        // If invalid length, return gray
        if ((colorString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: colorString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
}
