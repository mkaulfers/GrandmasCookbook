//
//  HomePageViewController.swift
//  GrandmasCookbook
//
//  Created by Matthew Kaulfers on 2/14/20.
//  Copyright © 2020 Matthew Kaulfers. All rights reserved.
//

import UIKit
import FirebaseAuth

class HomePageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ModalTransitionListener {
    
    @IBOutlet var savedRecipeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let reusableRecipe = UINib.init(nibName: "RecipeTableViewCell", bundle: Bundle.main)
        savedRecipeTableView.register(reusableRecipe, forCellReuseIdentifier: "recipeTableViewCell")
        
        let headerView = savedRecipeTableView.dequeueReusableCell(withIdentifier: "recipeTableViewCell") as! RecipeTableViewCell
        savedRecipeTableView.rowHeight =  headerView.bounds.size.height
        
        ModalTransitionMediator.instance.setListener(listener: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        Utilities.GlobalData.savedRecipes.sort(by: {$0.dayAddedFor! < $1.dayAddedFor!})
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
        
        //INFO: Get the Image For the Cell
        if let existingImage = Utilities.GlobalData.savedRecipes[indexPath.row].image
        {
            cell.foodImage.image = nil
            
            if let cachedImage = Utilities.GlobalData.imageCache.object(forKey: NSString(string: Utilities.GlobalData.savedRecipes[indexPath.row].image!)) {
                cell.foodImage.image = cachedImage
            }else{
                DispatchQueue.global(qos: .background).async {
                    let url = URL(string: existingImage)
                    let data = try? Data(contentsOf: url!)
                    let image = UIImage(data: data!)
                    
                    DispatchQueue.main.async {
                        Utilities.GlobalData.imageCache.setObject(image!, forKey: existingImage as NSString)
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
        
        cell.ribbons[0].isHidden = false
        
        //INFO: Setup Ribbon For Info
        switch Utilities.GlobalData.savedRecipes[indexPath.row].dayAddedFor
        {
        case 0: cell.ribbons[0].image = UIImage(named: "monRibbon")
        case 1: cell.ribbons[0].image = UIImage(named: "tuesRibbon")
        case 2: cell.ribbons[0].image = UIImage(named: "wedRibbon")
        case 3: cell.ribbons[0].image = UIImage(named: "thursRibbon")
        case 4: cell.ribbons[0].image = UIImage(named: "friRibbon")
        case 5: cell.ribbons[0].image = UIImage(named: "satRibbon")
        case 6: cell.ribbons[0].image = UIImage(named: "sunRibbon")
        default:
            print("Something went wrong setting a ribbon.")
        }
        if Utilities.GlobalData.savedRecipes[indexPath.row].readyInMinutes! < 30
        {
            cell.ribbons[1].image = UIImage(named: "fastRibbon")
            cell.ribbons[1].isHidden = false
        }
        
        if Utilities.GlobalData.savedRecipes[indexPath.row].extendedIngredients!.count < 10
        {
            cell.ribbons[2].image = UIImage(named: "easyRibbon")
            cell.ribbons[2].isHidden = false
        }
        
        cell.recipeName.text = Utilities.GlobalData.savedRecipes[indexPath.row].title
        return cell
    }
    
    //MARK: - Did select row
    var selectedRecipe = Recipe()
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRecipe = Utilities.GlobalData.savedRecipes[indexPath.row]
        performSegue(withIdentifier: "toRecipePage", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! RecipePage
        destination.selectedRecipe = selectedRecipe
    }
    
    @objc func loadList(notification: NSNotification){
        //load data here
        self.savedRecipeTableView.reloadData()
    }
    
    func popoverDismissed() {
        self.navigationController?.dismiss(animated: true, completion: nil)
        DispatchQueue.main.async {
            self.savedRecipeTableView.reloadData()
        }
        //savedRecipeTableView.reloadData()
    }
}
