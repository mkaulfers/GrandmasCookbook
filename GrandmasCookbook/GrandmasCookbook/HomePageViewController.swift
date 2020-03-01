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
        
        let reusableRecipe = UINib.init(nibName: "RecipeTableViewCell", bundle: Bundle.main)
        savedRecipeTableView.register(reusableRecipe, forCellReuseIdentifier: "recipeTableViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        savedRecipeTableView.reloadData()
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
        return Utilities.GlobalData.savedRecipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = savedRecipeTableView.dequeueReusableCell(withIdentifier: "recipeTableViewCell") as! RecipeTableViewCell

        return cell
    }
    
}
