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
    var featuredRecipes = [Recipe]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let headerNib = UINib.init(nibName: "RecipeTableViewCell", bundle: Bundle.main)
        featuredTableView.register(headerNib, forCellReuseIdentifier: Utilities.StaticStrings.recipeTableViewCell)
        
        let headerView = featuredTableView.dequeueReusableCell(withIdentifier: Utilities.StaticStrings.recipeTableViewCell) as! RecipeTableViewCell
        featuredTableView.rowHeight =  headerView.bounds.size.height
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        featuredRecipes = Utilities.GlobalData.currentRecipes.recipes.filter {$0.veryPopular == true }
        featuredTableView.reloadData()
    }
    
    //MARK: Table View Managment
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toRecipePage", sender: nil)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return featuredRecipes.count
    }
    
    //TODO: - Fix adding more data.
//    //INFO: Get more data when there's not enough to display.
//    var gettingMoreData = false
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        if indexPath.row == featuredRecipes.count-1 && gettingMoreData == false {
//            //Utilities.Configure.getMoreData(refresh: featuredTableView)
//            featuredTableView.reloadData()
//        }
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = featuredTableView.dequeueReusableCell(withIdentifier: Utilities.StaticStrings.recipeTableViewCell, for: indexPath) as! RecipeTableViewCell
        
        //INFO: Get the Image For the Cell
        if let existingImage = featuredRecipes[indexPath.row].image
        {
            if let cachedImage = Utilities.GlobalData.imageCache.object(forKey: NSString(string: featuredRecipes[indexPath.row].image!)) {
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
        
        //INFO: Setup Ribbon For Info
        if featuredRecipes[indexPath.row].readyInMinutes! < 30
        {
            cell.ribbons[0].image = UIImage(named: "fastRibbon")
            cell.ribbons[0].isHidden = false
        }
        
        if featuredRecipes[indexPath.row].extendedIngredients!.count < 10
        {
            cell.ribbons[1].image = UIImage(named: "easyRibbon")
            cell.ribbons[1].isHidden = false 
        }
        
        cell.recipeName.text = featuredRecipes[indexPath.row].title
        return cell
    }
}
