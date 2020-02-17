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
    
    //MARK: - Parent View Controller Management
    override func viewDidLoad() {
        super.viewDidLoad()

        //INFO: Load the header view.
        let headerNib = UINib.init(nibName: "searchHeader", bundle: Bundle.main)
        recipesTableView.register(headerNib, forHeaderFooterViewReuseIdentifier: "searchHeader")
        
        //INFO: Hide the separator
        recipesTableView.separatorColor = .clear
    }
    
    //MARK: - Table View Managment
    //INFO: Anytime a search is updated do this check.
    func updateSearchResults(for searchController: UISearchController) {
        //TODO: Update what the search results do.
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let headerView = recipesTableView.dequeueReusableHeaderFooterView(withIdentifier: "searchHeader") as! searchHeader
        return headerView.bounds.size.height
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 0
        {
            return recipesTableView.dequeueReusableHeaderFooterView(withIdentifier: "searchHeader") as! searchHeader
        }
        
        //TODO: Temporary placeholder.
        return UIView()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}
