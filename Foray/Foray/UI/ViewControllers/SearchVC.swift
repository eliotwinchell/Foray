//
//  SearchVC.swift
//  Foray
//
//  Created by Eliot Winchell on 10/2/22.
//

import Foundation
import UIKit

class SearchVC: UITableViewController {
    //
    // MARK: - Properties
    //
    var resultSearchController: UISearchController? = nil
    
    //
    // MARK: - View Controller
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let searchVC = storyboard?.instantiateViewController(withIdentifier: "SearchVC") as! SearchVC
        resultSearchController = UISearchController(searchResultsController: searchVC)
        resultSearchController?.searchResultsUpdater = searchVC
        
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search"
        navigationItem.titleView = resultSearchController?.searchBar
    }
}

extension SearchVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}
