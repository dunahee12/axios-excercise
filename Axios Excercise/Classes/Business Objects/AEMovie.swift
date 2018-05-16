//
//  AEMovie.swift
//  Axios Excercise
//
//  Created by Jake Dunahee on 5/15/18.
//  Copyright © 2018 Jake Dunahee. All rights reserved.
//

import UIKit

class AEMovie: NSObject {
    
    // Properties
    public var title: String!
    public var popularity = 0.0
    public var overview: String!
    public var fullPosterUrl: String {
        get {
            return "http://image.tmdb.org/t/p/w185" + posterUrl
        }
    }
    
    public var formattedReleaseDate: String {
        get {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YYYY-MM-dd"
            
            let date = dateFormatter.date(from: releaseDate)
            dateFormatter.dateFormat = "MMMM dd, yyyy"
            
            return date != nil ? dateFormatter.string(from: date!) : releaseDate
        }
    }
    
    // Fileprivate vars
    fileprivate var releaseDate: String!
    fileprivate var posterUrl: String!
    
    
    // MARK: Custom Initializers
    convenience init(json: NSDictionary) {
        self.init()
        
        title = json["original_title"] as? String ?? "No title available"
        popularity = json["popularity"] as! Double
        posterUrl = json["poster_path"] as? String ?? ""
        releaseDate = json["release_date"] as? String ?? ""
        overview = json["overview"] as? String ?? "No overview available."
    }

}
