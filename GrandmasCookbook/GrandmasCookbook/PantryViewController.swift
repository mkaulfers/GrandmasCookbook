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
        let headerNib = UINib.init(nibName: "ReusableHeader", bundle: Bundle.main)
        pantryTableView.register(headerNib, forHeaderFooterViewReuseIdentifier: "ReusableHeader")
        
        //INFO: Hide the separator
        pantryTableView.separatorColor = .clear
    }
    
    //MARK: - Table View Management
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let headerView = pantryTableView.dequeueReusableHeaderFooterView(withIdentifier: "ReusableHeader") as! ReusableHeader
        return headerView.bounds.size.height
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = pantryTableView.dequeueReusableHeaderFooterView(withIdentifier: "ReusableHeader") as! ReusableHeader
        
        headerView.HeaderText.text = "Pantry"
        
        return headerView
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}
