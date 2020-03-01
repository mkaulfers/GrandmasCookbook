//
//  ShoppingListViewController.swift
//  GrandmasCookbook
//
//  Created by Matthew Kaulfers on 2/14/20.
//  Copyright © 2020 Matthew Kaulfers. All rights reserved.
//

import UIKit

class ShoppingListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    //MARK: - Vars and Outlets
    @IBOutlet var shoppingListTableView: UITableView!
    
    //MARK: - Parent View Controller Management
    override func viewDidLoad() {
        super.viewDidLoad()

        //INFO: Load the header view.
        let headerNib = UINib.init(nibName: "SectionHeader", bundle: Bundle.main)
        shoppingListTableView.register(headerNib, forHeaderFooterViewReuseIdentifier: "SectionHeader")
        
        //INFO: Hide the separator
        shoppingListTableView.separatorColor = .clear
    }
    

    //MARK: - Table View Management
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let headerView = shoppingListTableView.dequeueReusableHeaderFooterView(withIdentifier: "SectionHeader") as! SectionHeader
        return headerView.bounds.size.height
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = shoppingListTableView.dequeueReusableHeaderFooterView(withIdentifier: "SectionHeader") as! SectionHeader
        
        headerView.HeaderText.text = "Shopping List"
        
        return headerView
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    

}
