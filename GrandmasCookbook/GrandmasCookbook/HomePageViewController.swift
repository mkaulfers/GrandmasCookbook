//
//  HomePageViewController.swift
//  GrandmasCookbook
//
//  Created by Matthew Kaulfers on 2/14/20.
//  Copyright © 2020 Matthew Kaulfers. All rights reserved.
//

import UIKit
import FirebaseAuth

class HomePageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var savedRecipeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    @IBAction func viewAccountSelected(_ sender: UIButton) {
        //TODO: properly configure segue and check to segue if the user is already logged in.
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        //TODO: Check if user logged in status.
        return true
    }
    
    //MARK: - Table View Management
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}
