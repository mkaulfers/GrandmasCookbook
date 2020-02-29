//
//  RecipePage.swift
//  GrandmasCookbook
//
//  Created by Matthew Kaulfers on 2/29/20.
//  Copyright © 2020 Matthew Kaulfers. All rights reserved.
//

import UIKit

class RecipePage: UITableViewController {
    
    let selectedRecipe = Recipe()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //INFO: Load the header view.
        let headerNib = UINib.init(nibName: "ReusableRecipeViewHeader", bundle: Bundle.main)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: "ReusableRecipeViewHeader")
        
        let sectionHeader = UINib.init(nibName: "ReusableHeader", bundle: Bundle.main)
        tableView.register(sectionHeader, forHeaderFooterViewReuseIdentifier: "ReusableHeader")
        
        let reusableCell = UINib.init(nibName: "ReusableIngredient", bundle: Bundle.main)
        tableView.register(reusableCell, forCellReuseIdentifier: "ReusableIngredient")
        
        //INFO: Hide the separator
        tableView.separatorColor = .clear
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let ingredients = selectedRecipe.extendedIngredients else { return 0 }
        
        switch section
        {
        case 0:
            return 0
        case 1:
            return 3
        case 2:
            return 0
        default:
            print("Error 404")
        }
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableIngredient", for: indexPath) as! ReusableIngredient
            
            return cell
        }
        else if indexPath.section == 2
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableIngredient", for: indexPath) as! ReusableIngredient
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let recipeViewHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ReusableRecipeViewHeader") as! ReusableRecipeViewHeader
        
        let ingredientViewHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ReusableHeader") as! ReusableHeader
        
        let directionsViewHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ReusableHeader") as! ReusableHeader
        
        if section == 0
        {
            return recipeViewHeader.bounds.size.height
        }
        else if section == 1
        {
            return ingredientViewHeader.bounds.size.height
        }
        else if section == 2
        {
            return directionsViewHeader.bounds.size.height
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let recipeViewHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ReusableRecipeViewHeader") as! ReusableRecipeViewHeader
        
        let ingredientViewHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ReusableHeader") as! ReusableHeader
        
        let directionsViewHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ReusableHeader") as! ReusableHeader
        
        if section == 0
        {
            return recipeViewHeader
        }
        else if section == 1
        {
            ingredientViewHeader.HeaderText.text = "Ingredients"
            return ingredientViewHeader
        }
        else if section == 2
        {
            directionsViewHeader.HeaderText.text = "Directions"
            return directionsViewHeader
        }
        
        return UIView()
    }
}
