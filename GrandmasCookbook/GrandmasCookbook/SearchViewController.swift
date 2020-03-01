//
//  SearchViewController.swift
//  GrandmasCookbook
//
//  Created by Matthew Kaulfers on 2/14/20.
//  Copyright © 2020 Matthew Kaulfers. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    //MARK: - Class Vars and Outlets
    @IBOutlet var recipesTableView: UITableView!
    @IBOutlet var searchBarWithScope: UISearchBar!
    @IBOutlet var searchTableView: UITableView!
    var searchableRecipes = Utilities.GlobalData.currentRecipes.recipes
    
    //MARK: - Parent View Controller Management
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let headerNib = UINib.init(nibName: "RecipeTableViewCell", bundle: Bundle.main)
        searchTableView.register(headerNib, forCellReuseIdentifier: Utilities.StaticStrings.recipeTableViewCell)
        
        let headerView = searchTableView.dequeueReusableCell(withIdentifier: Utilities.StaticStrings.recipeTableViewCell) as! RecipeTableViewCell
        searchTableView.rowHeight =  headerView.bounds.size.height
        
        searchBarWithScope.delegate = self
    }
    
    //MARK: - Search Methods
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        switch selectedScope
        {
        case 0:
            //ALL
            searchableRecipes = Utilities.GlobalData.currentRecipes.recipes
        case 1:
            //Healthy
            searchableRecipes = Utilities.GlobalData.currentRecipes.recipes.filter { $0.veryHealthy == true }
        case 2:
            //Vegetarian
            searchableRecipes = Utilities.GlobalData.currentRecipes.recipes.filter { $0.vegetarian == true }
        case 3:
            //Custom
            //TODO: - Not yet implemented
            searchableRecipes = Utilities.GlobalData.currentRecipes.recipes
        default:
            print("Nothing will reach this dark place.")
        }
        
        searchTableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchableRecipes = [Recipe]()
        let searchedText = searchBar.text
        
        guard let filter = searchedText else { return }
        
        for recipe in Utilities.GlobalData.currentRecipes.recipes
        {
            //INFO: Speeding the searching up a bit by filtering on the title first.
            if recipe.title!.lowercased().contains(filter.lowercased())
            {
                searchableRecipes.append(recipe)
                continue
            }
            
            //INFO: Search Through Ingredients Also
            for ingredient in recipe.extendedIngredients ?? [Ingredient]()
            {
                if ingredient.name!.contains(filter.lowercased())
                {
                    searchableRecipes.append(recipe)
                    break
                }
            }
        }
        
        searchTableView.reloadData()
        
    }
    
    //MARK: - Table View Managment
    //INFO: Anytime a search is updated do this check.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchableRecipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchTableView.dequeueReusableCell(withIdentifier: Utilities.StaticStrings.recipeTableViewCell, for: indexPath) as! RecipeTableViewCell
        
        //INFO: Get the Image For the Cell
        if let recipeImageLink = searchableRecipes[indexPath.row].image
        {
            cell.foodImage.image = nil
            
            if let cachedImage = Utilities.GlobalData.imageCache.object(forKey: NSString(string: searchableRecipes[indexPath.row].image!)) {
                cell.foodImage.image = cachedImage
            }else{
                DispatchQueue.global(qos: .background).async {
                    let url = URL(string: recipeImageLink)
                    let data = try? Data(contentsOf: url!)
                    let image = UIImage(data: data!)
                    
                    DispatchQueue.main.async {
                        Utilities.GlobalData.imageCache.setObject(image!, forKey: recipeImageLink as NSString)
                        cell.foodImage.image = image
                    }
                }
            }
        }
        else
        {
            cell.foodImage.image = UIImage(named: "logoVertical")
        }
        
        //INFO: Remove Ribbons
        //TODO: Setup Ribbons That Matter
        for ribbon in cell.ribbons
        {
            ribbon.isHidden = true
        }
        
        //INFO: Setup Ribbon For Info
        if searchableRecipes[indexPath.row].readyInMinutes! < 30
        {
            cell.ribbons[0].image = UIImage(named: "fastRibbon")
            cell.ribbons[0].isHidden = false
        }
        
        if searchableRecipes[indexPath.row].extendedIngredients!.count < 10
        {
            cell.ribbons[1].image = UIImage(named: "easyRibbon")
            cell.ribbons[1].isHidden = false
        }
        
        cell.recipeName.text = searchableRecipes[indexPath.row].title
        return cell
    }
    
    //MARK: - Did Select Row @
    var selectedRecipe = Recipe()
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRecipe = searchableRecipes[indexPath.row]
        performSegue(withIdentifier: "toRecipePage", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! RecipePage
        destination.selectedRecipe = selectedRecipe
    }
    
}
