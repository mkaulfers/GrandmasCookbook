//
//  PantryItemsView.swift
//  GrandmasCookbook
//
//  Created by Matthew Kaulfers on 3/3/20.
//  Copyright © 2020 Matthew Kaulfers. All rights reserved.
//

import UIKit

class PantryItemsView: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate {
    var pantryItems = [PantryItem]()
    var filteredPantry = [PantryItem]()
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text?.lowercased(), !searchText.isEmpty {
            filteredPantry = pantryItems.filter { (item) -> Bool in
                return item.itemName.lowercased().contains(searchText)
            }
        }
        else {
            filteredPantry = pantryItems
        }
        tableView.reloadData()
    }
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filteredPantry = pantryItems
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
        
        let path = Bundle.main.path(forResource: "SearchableIngredients", ofType: "txt")
        let contents = try! String(contentsOfFile: path!)
        let lines = contents.split(separator: "\n")
        
        for line in lines
        {
            let tempPantryItem = PantryItem()
            let itemDetails = line.split(separator: ";")
            tempPantryItem.itemName = String(itemDetails[0])
            tempPantryItem.itemId = Int(String(itemDetails[1]))!
            pantryItems.append(tempPantryItem)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return filteredPantry.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reusableLocalCell")
        cell?.textLabel?.text = filteredPantry[indexPath.row].itemName
        return cell!
    }
}
