//
//  AELoadingView.swift
//  Axios Excercise
//
//  Created by Jake Dunahee on 5/16/18.
//  Copyright © 2018 Jake Dunahee. All rights reserved.
//

import UIKit

class AELoadingView: NSObject {
    
    // Public vars
    public static let shared = AELoadingView()
    
    // Fileprivate vars
    fileprivate var backgroundView: UIView?
    fileprivate var spinner: UIActivityIndicatorView?
    
    public func showLoadingView(forViewController viewController: UIViewController) {
        if (backgroundView == nil) {
            backgroundView = UIView(frame: viewController.view.frame)
            backgroundView?.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
        }
        
        if (spinner == nil) {
            spinner = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
            spinner?.startAnimating()
            spinner?.frame = CGRect(x: (backgroundView?.frame.width)!/2 - 25, y: (backgroundView?.frame.height)!/2 - 25, width: 50, height: 50)
            backgroundView?.addSubview(spinner!)
        }
        
        viewController.view.addSubview(backgroundView!)
    }
    
    public func hideLoadingView() {
        if (backgroundView != nil) {
            backgroundView?.removeFromSuperview()
        }
    }
   
}
