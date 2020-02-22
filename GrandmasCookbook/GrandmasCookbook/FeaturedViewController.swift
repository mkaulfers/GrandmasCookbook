//
//  FeaturedViewController.swift
//  GrandmasCookbook
//
//  Created by Matthew Kaulfers on 2/14/20.
//  Copyright © 2020 Matthew Kaulfers. All rights reserved.
//

import UIKit

class FeaturedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var featuredTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let headerNib = UINib.init(nibName: "RecipeTableViewCell", bundle: Bundle.main)
        featuredTableView.register(headerNib, forCellReuseIdentifier: Utilities.StaticStrings.recipeTableViewCell)
        
        let headerView = featuredTableView.dequeueReusableCell(withIdentifier: Utilities.StaticStrings.recipeTableViewCell) as! RecipeTableViewCell
        featuredTableView.rowHeight =  headerView.bounds.size.height
    }
    
    override func viewWillAppear(_ animated: Bool) {
        featuredTableView.reloadData()
    }
    
    //MARK: Table View Managment
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Utilities.GlobalData.currentRecipes?.recipes.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = featuredTableView.dequeueReusableCell(withIdentifier: Utilities.StaticStrings.recipeTableViewCell, for: indexPath) as! RecipeTableViewCell
        cell.foodImage.image = Utilities.GlobalData.currentRecipes?.recipes[indexPath.row].retrievedImage
        cell.recipeName.text = Utilities.GlobalData.currentRecipes?.recipes[indexPath.row].title
        return cell
    }

}
