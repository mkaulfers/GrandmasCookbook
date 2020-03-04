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
    
    var neededIngredients = [Ingredient]()
    
    //MARK: - Parent View Controller Management
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let reusableIngredient = UINib.init(nibName: "IngredientTableViewCell", bundle: Bundle.main)
        shoppingListTableView.register(reusableIngredient, forCellReuseIdentifier: "IngredientTableViewCell")
        
        //INFO: Load the header view.
        let headerNib = UINib.init(nibName: "SectionHeader", bundle: Bundle.main)
        shoppingListTableView.register(headerNib, forHeaderFooterViewReuseIdentifier: "SectionHeader")
        
        //INFO: Hide the separator
        shoppingListTableView.separatorColor = .clear
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        neededIngredients = [Ingredient]()
        
        for recipe in Utilities.GlobalData.savedRecipes
        {
            for newIngredient in recipe.extendedIngredients!
            {
                if neededIngredients.contains(where: { (ingredient) -> Bool in
                    ingredient.id == newIngredient.id
                })
                {
                    neededIngredients[neededIngredients.firstIndex(where: { (oldIngredient) -> Bool in
                        oldIngredient.id == newIngredient.id
                    })!].measures!.us!.amount! += newIngredient.measures!.us!.amount!
                }
                else
                {
                    neededIngredients.append(newIngredient)
                }
            }
        }
        
        shoppingListTableView.reloadData()
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
        return neededIngredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientTableViewCell", for: indexPath) as! IngredientTableViewCell
        
        cell.ingredientName.text = neededIngredients[indexPath.row].name
        cell.quantityValue.text = neededIngredients[indexPath.row].measures?.us?.amount?.description ?? 0.0.description
        cell.quantityDescription.text = " \(neededIngredients[indexPath.row].measures?.us?.unitShort ?? "Unknown")"
        
        cell.ingredientStepper.value = (neededIngredients[indexPath.row].measures?.us!.amount)!
        
        return cell
    }
    
    
}
