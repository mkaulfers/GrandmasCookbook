//
//  RecipePage.swift
//  GrandmasCookbook
//
//  Created by Matthew Kaulfers on 2/29/20.
//  Copyright © 2020 Matthew Kaulfers. All rights reserved.
//

import UIKit

class RecipePage: UITableViewController {
    //MARK: - Class Vars
    var selectedRecipe = Recipe()
    var isRecipeAdded = Bool()
    
    //MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        isRecipeAdded = checkIfExists()
        
        //INFO: Load the header view.
        let headerNib = UINib.init(nibName: "RecipeSectionHeader", bundle: Bundle.main)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: "RecipeSectionHeader")
        
        let sectionHeader = UINib.init(nibName: "SectionHeader", bundle: Bundle.main)
        tableView.register(sectionHeader, forHeaderFooterViewReuseIdentifier: "SectionHeader")
        
        let reusableIngredient = UINib.init(nibName: "IngredientTableViewCell", bundle: Bundle.main)
        tableView.register(reusableIngredient, forCellReuseIdentifier: "IngredientTableViewCell")
        
        let reusableDirections = UINib.init(nibName: "DirectionsTableViewCell", bundle: Bundle.main)
        tableView.register(reusableDirections, forCellReuseIdentifier: "DirectionsTableViewCell")
        
        let reusableFooter = UINib.init(nibName: "RecipeSectionFooter", bundle: Bundle.main)
        tableView.register(reusableFooter, forHeaderFooterViewReuseIdentifier: "RecipeSectionFooter")
    }
    
    // MARK: - Number of sections
    //INFO: DO NOT modify return value for the sections. This is setup to hold the proper view.
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 1
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientTableViewCell") as! IngredientTableViewCell
            
            return cell.bounds.height
        }
        
        return UITableView.automaticDimension
    }
    
    //MARK: - Number of rows in section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section
        {
        //INFO: ALWAYS, return 0 for case 0. Not doing so will cause unexpected spacing.
        case 0:
            return 0
        case 1:
            guard let ingredients = selectedRecipe.extendedIngredients else { return 0 }
            return ingredients.count
        case 2:
            return 1
        //INFO: ALWAYS, return 0 for case 3. Not doing so will cause unexpected spacing.
        case 3:
            return 0
        //INFO: Should never reach this.
        default:
            print("Error 404")
        }
        return 0
    }
    
    //MARK: Cell for row at
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //INFO: Ingredients
        if indexPath.section == 1
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientTableViewCell", for: indexPath) as! IngredientTableViewCell
            
            guard let ingredient = selectedRecipe.extendedIngredients?[indexPath.row] else { return UITableViewCell() }
            
            cell.ingredientName.text = ingredient.name
            cell.quantityValue.text = ingredient.measures?.us?.amount?.description ?? 0.0.description
            cell.quantityDescription.text = " \(ingredient.measures?.us?.unitShort ?? "Unknown")"
            
            cell.ingredientStepper.isHidden = true
            
            return cell
        }
            
            //INFO: Directions
        else if indexPath.section == 2
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DirectionsTableViewCell", for: indexPath) as! DirectionsTableViewCell
            
            //REGEX: Removes "<xxx>" where xxx is any characters. Formats some of the recipes instructions that are being returned, otherwise no effect.
            let directions = selectedRecipe.instructions!.replacingOccurrences(of: "\\<(.*?)\\>", with: " ", options: .regularExpression)
            
            cell.directions.text = directions
            
            return cell
        }
        //Should never reach this.
        return UITableViewCell()
    }
    
    //MARK: - Height for header in section
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0
        {
            //INFO: Bring in each header piece and set their height accordingly.
            let recipeViewHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: "RecipeSectionHeader") as! RecipeSectionHeader
            return recipeViewHeader.bounds.size.height
        }
        else if section == 1
        {
            let ingredientViewHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: "SectionHeader") as! SectionHeader
            return ingredientViewHeader.bounds.size.height
        }
        else if section == 2
        {
            let directionsViewHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: "SectionHeader") as! SectionHeader
            return directionsViewHeader.bounds.size.height
        }
        else if section == 3
        {
            let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "RecipeSectionFooter") as! RecipeSectionFooter
            return footerView.bounds.size.height
        }
        return 0
    }
    
    //MARK: View for header in section
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0
        {
            let recipeViewHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: "RecipeSectionHeader") as! RecipeSectionHeader
            
            recipeViewHeader.recipeImage.image = getImage(url: selectedRecipe.image!)
            recipeViewHeader.recipeName.text = selectedRecipe.title
            recipeViewHeader.timeToCook.text = "\(selectedRecipe.readyInMinutes?.description ?? "?") minutes"
            
            return recipeViewHeader
        }
        else if section == 1
        {
            let ingredientViewHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: "SectionHeader") as! SectionHeader
            
            ingredientViewHeader.HeaderText.text = "Ingredients"
            return ingredientViewHeader
        }
        else if section == 2
        {
            let directionsViewHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: "SectionHeader") as! SectionHeader
            
            directionsViewHeader.HeaderText.text = "Directions"
            return directionsViewHeader
        }
        else if section == 3
        {
            let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "RecipeSectionFooter") as! RecipeSectionFooter
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleButtonTapped(_:)))
            footerView.addToPlanImageButton.addGestureRecognizer(tapGesture)
            
            if isRecipeAdded == false
            {
                footerView.addToPlanImageButton.image = UIImage(named: "addToPlan")
            }
            else if isRecipeAdded == true
            {
                footerView.addToPlanImageButton.image = UIImage(named: "removeFromPlan")
            }
            
            return footerView
        }
        
        return UIView()
    }
    
    //MARK: - Load Image
    func getImage(url: String) -> UIImage
    {
        var tempImage = UIImage()
        DispatchQueue.global(qos: .background).sync {
            let url = URL(string: url)
            let data = try? Data(contentsOf: url!)
            let image = UIImage(data: data!)!
            tempImage = image
        }
        return tempImage
    }
    
    //MARK: - Handle Tap
    @objc func handleButtonTapped(_ sender: UITapGestureRecognizer){
        self.dismiss(animated: true) {
            
            if Utilities.GlobalData.savedRecipes.count == 7
            {
                //TODO: - Prevent adding more than 7.
                print("You must remove something.")
            }
            else if Utilities.GlobalData.savedRecipes.count <= 7  && self.checkIfExists() == false {
                
                if Utilities.GlobalData.savedRecipes.count == 0
                {
                    self.selectedRecipe.dayAddedFor = 0
                }
                else
                {
                    for (i, recipe) in Utilities.GlobalData.savedRecipes.enumerated()
                    {
                        if i != recipe.dayAddedFor {
                            self.selectedRecipe.dayAddedFor = i
                        }
                        else
                        {
                            self.selectedRecipe.dayAddedFor = Utilities.GlobalData.savedRecipes.count
                        }
                    }
                }
                
                Utilities.GlobalData.savedRecipes.append(self.selectedRecipe)
            }
            else
            {
                for (i, recipe) in Utilities.GlobalData.savedRecipes.enumerated()
                {
                    if recipe.id == self.selectedRecipe.id {
                        Utilities.GlobalData.savedRecipes.remove(at: i)
                        print("Recipe removed from saved list.")
                    }
                }
            }
        }
    }
    
    func checkIfExists() -> Bool
    {
        if !Utilities.GlobalData.savedRecipes.contains(where: { (recipe) -> Bool in
            recipe.id == self.selectedRecipe.id
        })
        {
            return false
        }
        
        return true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        ModalTransitionMediator.instance.sendPopoverDismissed(modelChanged: true)
    }
}
