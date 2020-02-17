//
//  SearchViewController.swift
//  GrandmasCookbook
//
//  Created by Matthew Kaulfers on 2/14/20.
//  Copyright © 2020 Matthew Kaulfers. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
    //MARK: - Class Vars and Outlets
    @IBOutlet var recipesTableView: UITableView!
    @IBOutlet var searchBarWithScope: UISearchBar!
    
    //MARK: - Parent View Controller Management
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //INFO: Hide the separator
        recipesTableView.separatorColor = .clear
    }
    
    //MARK: - Table View Managment
    //INFO: Anytime a search is updated do this check.
    func updateSearchResults(for searchController: UISearchController) {
        //TODO: Update what the search results do.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}
