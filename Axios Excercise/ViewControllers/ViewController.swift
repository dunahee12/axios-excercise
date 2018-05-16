//
//  ViewController.swift
//  Axios Excercise
//
//  Created by Jake Dunahee on 5/15/18.
//  Copyright © 2018 Jake Dunahee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // IBOutlet
    @IBOutlet var movieTableView: UITableView!
    
    // Local Properties
    var lblNoResults: UILabel?
    var movieArray: NSMutableArray? = nil
    var selectedIndex = -1
    
    // Constants
    let DEFAULT_CELL_HEIGHT: CGFloat = 155.0

    
    // MARK: Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        populateMovieArray()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: IBActions
    @IBAction func refreshMovies() {
        populateMovieArray()
    }

    
    // MARK: Fileprivate Functions
    fileprivate func populateMovieArray() {
        if movieArray == nil {
            movieArray = NSMutableArray()
        } else {
            movieArray?.removeAllObjects()
        }
        
        let requestString = "https://api.themoviedb.org/3/discover/movie?api_key=1821c6b6049945b0e08619035590d15b&page=1"
        
        AELoadingView.shared.showLoadingView(forViewController: self)
        AENetworkManager.makeRequest(urlString: requestString, completion: { (jsonArray) in
            // Goes through each JSON object and creates array of movies objects
            for object in jsonArray {
                let dictionary = object as! NSDictionary
                let movie = AEMovie(json: dictionary)
                
                self.movieArray?.add(movie)
            }
            
            // Fire table reload on main thread
            DispatchQueue.main.async {
                AELoadingView.shared.hideLoadingView()
                self.hideNoResultsMessage()
                self.movieTableView.reloadData()
            }
        }) { (error) in
            // Fire alert on main thread
            DispatchQueue.main.sync {
                AELoadingView.shared.hideLoadingView()
                self.showNoResultsMessage()
                
                // Present alert letting user know error occurred
                let alert = UIAlertController(title: "Uh oh!", message: "There was an error retrieving movies.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    fileprivate func showNoResultsMessage() {
        if (lblNoResults == nil) {
            lblNoResults = UILabel(frame: CGRect(x: 0, y: view.frame.height/2 - 25, width: view.frame.width, height: 50))
            lblNoResults?.text = "No Results"
            lblNoResults?.textAlignment = NSTextAlignment.center
            lblNoResults?.font = UIFont.boldSystemFont(ofSize: 22)
            view.addSubview(lblNoResults!)
        }
        
        lblNoResults?.isHidden = false
        movieTableView.isHidden = true
    }
    
    fileprivate func hideNoResultsMessage() {
        if (lblNoResults != nil) {
            lblNoResults?.isHidden = true
        }
        
        movieTableView.isHidden = false
    }

}


// MARK: UITableView
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: Datasource
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return selectedIndex == indexPath.row ? UITableViewAutomaticDimension : DEFAULT_CELL_HEIGHT
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movieArray != nil ? (movieArray?.count)! : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = movieArray![indexPath.row] as! AEMovie
        let cell = tableView.dequeueReusableCell(withIdentifier: AEMovieTableViewCell.CELL_IDENTIFIER, for: indexPath) as! AEMovieTableViewCell
        cell.delegate = self
        cell.setData(withMovie: movie, isSelected: selectedIndex == indexPath.row)
        cell.cellIndex = indexPath.row
        
        return cell
    }
    
    
    // MARK: Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
}


// MARK: AEMovieTableViewCell Delegate
extension ViewController: AEMovieTableViewCellDelegate {
    
    func buttonTappedForCellAtIndex(index: Int) {
        selectedIndex = selectedIndex == index ? -1 : index
        movieTableView.reloadRows(at: [IndexPath.init(row: index, section: 0)], with: UITableViewRowAnimation.fade)
    }
    
}

