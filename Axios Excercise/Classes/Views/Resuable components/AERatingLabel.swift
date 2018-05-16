//
//  AERatingLabel.swift
//  Axios Excercise
//
//  Created by Jake Dunahee on 5/15/18.
//  Copyright © 2018 Jake Dunahee. All rights reserved.
//

import UIKit

class AERatingLabel: UILabel {

    // MARK: Public Functions
    public func setValue(value: Double) {
        layer.borderWidth = 3
        layer.cornerRadius = frame.height/2
        
        let ratingString = String(format: "%.0f", value.rounded())
        text = ratingString as String
        
        let roundedValue = value.rounded()
        
        // Sets label color based on rating
        var color = UIColor()
        
        switch roundedValue {
            case 100..<1000: color = UIColor.colorWithHexCode(hex: "#358c58")
            case 50..<100: color = UIColor.orange
            case ..<50: color = UIColor.red
            default: break
        }
        
        layer.borderColor = color.cgColor
        textColor = color
    }

}
