//
//  FeaturedViewController.swift
//  GrandmasCookbook
//
//  Created by Matthew Kaulfers on 2/14/20.
//  Copyright © 2020 Matthew Kaulfers. All rights reserved.
//

import UIKit

class FeaturedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: Table View Managment
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

}
