//
//  AENetworkManager.swift
//  Axios Excercise
//
//  Created by Jake Dunahee on 5/15/18.
//  Copyright © 2018 Jake Dunahee. All rights reserved.
//

import UIKit

class AENetworkManager: NSObject {
    
    public class func makeRequest(urlString: String, completion: @escaping (_ result: NSArray)->(), errorHandler: @escaping (_ error: Error)->()) {
        let url = URL.init(string: urlString)
        let request = URLRequest(url: url!)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if (error == nil && data != nil) {
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                    completion(json["results"] as! NSArray)
                    print("Response - ", json);
                } catch {
                    print("Error reading data - ", response.debugDescription);
                }
            } else {
                errorHandler(error!)
            }
        }.resume()
    }

}
