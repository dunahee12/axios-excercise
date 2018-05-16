//
//  AEMovieTableViewCell.swift
//  Axios Excercise
//
//  Created by Jake Dunahee on 5/15/18.
//  Copyright © 2018 Jake Dunahee. All rights reserved.
//

import UIKit

protocol AEMovieTableViewCellDelegate {
    func buttonTappedForCellAtIndex(index: Int)
}

class AEMovieTableViewCell: UITableViewCell {
    
    static let CELL_IDENTIFIER = "MOVIE_TABLE_CELL"
    
    // IBOutlets
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var ivPoster: UIImageView!
    @IBOutlet var lblReleaseDate: UILabel!
    @IBOutlet var lblRating: AERatingLabel!
    @IBOutlet var lblOverview: UILabel!
    @IBOutlet var btnOverview: UIButton!
    
    // Public properties
    public var delegate: AEMovieTableViewCellDelegate?
    
    // Local properties
    var cellIndex = -1

    
    // MARK: Lifecycle Functions
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = UITableViewCellSelectionStyle.none
    }
    
    public func setData(withMovie movie: AEMovie, isSelected: Bool) {
        // Set title
        lblTitle.text = movie.title
        
        // Set movie poster
        ivPoster.downloadImage(withUrl: movie.fullPosterUrl, placeHolder: UIImage(named: "placeHolder")!)
        
        // Set rating
        lblRating.setValue(value: movie.popularity)
        
        // Set release date
        lblReleaseDate.text = movie.formattedReleaseDate
        
        // Set overview text
        lblOverview.text = movie.overview
        
        // Set overview button text based on if selected
        let buttonTitle = isSelected ? "Hide Overview" : "Show Overview"
        btnOverview.setTitle(buttonTitle, for: UIControlState.normal)
        btnOverview.backgroundColor = UIColor.red
        btnOverview.setTitleColor(UIColor.white, for: UIControlState.normal)
    }
    
    
    // MARK: IBActions
    @IBAction func handleOverviewTap(button: UIButton) {
        delegate?.buttonTappedForCellAtIndex(index: cellIndex)
    }
    
}
