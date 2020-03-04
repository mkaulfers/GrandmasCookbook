//
//  Constants.swift
//  GrandmasCookbook
//
//  Created by Matthew Kaulfers on 2/16/20.
//  Copyright © 2020 Matthew Kaulfers. All rights reserved.
//

import Foundation
import UIKit

struct Utilities
{
    //MARK: - Static Strings
    struct StaticStrings
    {
        //INFO: Set static so we can grab it without defining the structure object. 
        static let profileViewController = "profileViewController"
        static let loginViewController = "loginViewController"
        static let registerViewController = "registerViewController"
        static let tabBarController = "toTabBarController"
        static let recipeTableViewCell = "recipeTableViewCell"
        
        //TODO: - Properly setup API Link
        static var get100Recipes = "https://api.spoonacular.com/recipes/random?&number=100&apiKey=36af5618ceba4d28a34d6689da3d3d89"
    }
    
    //MARK: - Global Object Access
    struct GlobalData
    {
        static var currentRecipes: Recipes = Recipes()
        static var imageCache = NSCache<NSString, UIImage>()
        static var savedRecipes = [Recipe]()
        static var savedPantryItems = [PantryItem]()
    }
    
    //MARK: - Validation Methods
    struct Validations
    {
        static func isEmailValid(_ email: String) -> Bool
        {
            let emailTest = NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
            return emailTest.evaluate(with: email)
        }
        
        static func isPasswordValid(_ password: String) -> Bool
        {
            //INFO: Check password against Regular Expression. 8 Char min, Special Char, Number
            let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
            return passwordTest.evaluate(with: password)
        }
    }
    
    //MARK: - Configuration Methods
    struct Configure
    {
        static func cleanString(_ stringToClean: String) -> String
        {
            let cleanedString = stringToClean.trimmingCharacters(in: .whitespacesAndNewlines)
            return cleanedString
        }
        
        static func getMoreData(refresh yourTableView: UITableView)
        {
            var gettingMoreData = false
            
            if gettingMoreData == false
            {
                gettingMoreData = true
                print("WARNING: Using API to get new data.")
                //INFO: Configure URL Session. The URL string is coming from Utilities.StaticStrings so that I can prevent typos. All access to static variables is stored there.
                guard let validURL = URL(string: Utilities.StaticStrings.get100Recipes) else { return }
                
                //Start a datatask. If there's an error then we will cancel. This will cause the app to stop functioning for the featured tab, but it will not cause a crash. Might consider moving this into the featured tab itself, though it does load random recipes. Adding these random recipes to the Search Page as well.
                URLSession.shared.dataTask(with: validURL, completionHandler: { (opt_data, opt_response, opt_error) in
                    
                    //Debug: Bail Out on error
                    if opt_error != nil { return }
                    
                    //Validate: Check the response, statusCode, and data
                    guard let response = opt_response as? HTTPURLResponse,
                        response.statusCode == 200,
                        let data = opt_data
                        else { return }
                    
                    let additionalData = try! JSONDecoder().decode(Recipes.self, from: data)
                    
                    Utilities.GlobalData.currentRecipes.recipes += additionalData.recipes
                    
                    DispatchQueue.main.async {
                        yourTableView.reloadData()
                    }
                    
                    gettingMoreData = false
                }).resume()
            }
            else
            {
                yourTableView.reloadData()
            }
        }
    }
}
