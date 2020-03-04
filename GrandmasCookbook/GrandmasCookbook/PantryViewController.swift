//
//  PantryViewController.swift
//  GrandmasCookbook
//
//  Created by Matthew Kaulfers on 2/14/20.
//  Copyright © 2020 Matthew Kaulfers. All rights reserved.
//

import UIKit

class PantryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Class Vars and Outlets
    @IBOutlet var pantryTableView: UITableView!
    
    //MARK: - Parent ViewController Management
    override func viewDidLoad() {
        super.viewDidLoad()

        //INFO: Load the header view.
        let headerNib = UINib.init(nibName: "SectionHeader", bundle: Bundle.main)
        pantryTableView.register(headerNib, forHeaderFooterViewReuseIdentifier: "SectionHeader")
        
        //INFO: Hide the separator
        pantryTableView.separatorColor = .clear
    }
    
    //MARK: - Table View Management
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let headerView = pantryTableView.dequeueReusableHeaderFooterView(withIdentifier: "SectionHeader") as! SectionHeader
        return headerView.bounds.size.height
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = pantryTableView.dequeueReusableHeaderFooterView(withIdentifier: "SectionHeader") as! SectionHeader
        
        headerView.HeaderText.text = "Pantry"
        
        return headerView
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Utilities.GlobalData.savedPantryItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}
