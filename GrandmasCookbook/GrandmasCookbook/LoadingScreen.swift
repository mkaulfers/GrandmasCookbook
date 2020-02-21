//
//  ViewController.swift
//  GrandmasCookbook
//
//  Created by Matthew Kaulfers on 2/12/20.
//  Copyright © 2020 Matthew Kaulfers. All rights reserved.
//

import UIKit

class LoadingScreen: UIViewController, URLSessionDelegate{
    
    //MARK: - Vars and Outlets
    var loadedRecipes: Recipes? = nil
    var pulsatingLayer: CAShapeLayer!
    @IBOutlet var logoView: UIImageView!
    
    //MARK: - Parent View Management
    override func viewDidLoad() {
        super.viewDidLoad()
        animatePulsatingLayer()
        startDownloading()
    }
    
    //MARK: - Download Data
    func startDownloading()
    {
        //INFO: Configure URL Session
        guard let validURL = URL(string: Utilities.StaticStrings.spoonacularAPILink) else { return }
        URLSession.shared.dataTask(with: validURL, completionHandler: { (opt_data, opt_response, opt_error) in
            
            //Debug: Bail Out on error
            if opt_error != nil { return }
            
            //Validate: Check the response, statusCode, and data
            guard let response = opt_response as? HTTPURLResponse,
                response.statusCode == 200,
                let data = opt_data
                else { return }
            
            do{
                
                
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]
                {
                    guard let data = json["recipes"] as? [[String: Any]] else { return }
                    
                    for recipe in data
                    {
                        let tempRecipe = Recipe()
                        
                        let vegetarian = recipe["vegetarian"] as? Bool
                        let veryHealthy = recipe["veryHealthy"] as? Bool
                        let veryPopular = recipe["veryPopular"] as? Bool
                        let id = recipe["id"] as? Int
                        let readyInMinutes = recipe["readyInMinutes"] as? Int
                        let title = recipe["title"] as? String
                        let image = recipe["image"] as? String
                        let instructions = recipe["instructions"] as? String
                        
                        guard let extendedIngredients = recipe["extendedIngredients"] as? [[String: Any]] else { continue }
                        
                        for ingredient in extendedIngredients
                        {
                            let id = ingredient["id"] as? Int
                            let name = ingredient["name"] as? String
                            
                            print(name )
                            
                            //BUG: - Cannot get past this value.
                            //INFO: - May be able to use [String: [String: Any]] to fix the issue. 
                            guard let measurements = ingredient["measures"] as? [[String: Any]] else { continue }
                            
                            for measure in measurements
                            {
                                var usMeasurement = Measurement()
                                var metricMeasurement = Measurement()
                                
                                guard let us = measure["us"] as? [[String: Any]] else { continue }
                                for value in us
                                {
                                    let amount = value["amount"] as? Double
                                    let unitShort = value["unitShort"] as? String
                                    let unitLong = value["unitLong"] as? String
                                    
                                    usMeasurement = Measurement(amount: amount ?? 0, unitShort: unitShort ?? "NotSpec", unitLong: unitLong ?? "Not Specified")
                                }
                                
                                guard let metric = measure["metric"] as? [[String: Any]] else { continue }
                                for value in metric
                                {
                                    let amount = value["amount"] as? Double
                                    let unitShort = value["unitShort"] as? String
                                    let unitLong = value["unitLong"] as? String
                                    
                                    metricMeasurement = Measurement(amount: amount ?? 0, unitShort: unitShort ?? "NotSpec", unitLong: unitLong ?? "Not Specified")
                                }
                                
                                tempRecipe.vegetarian = vegetarian
                                tempRecipe.veryHealthy = veryHealthy
                                tempRecipe.veryPopular = veryPopular
                                tempRecipe.id = id
                                tempRecipe.readyInMinutes = readyInMinutes
                                tempRecipe.title = title
                                tempRecipe.image = image
                                tempRecipe.instructions = instructions
                                
                                
                                print(tempRecipe)
                            }
                        }
                    }
                }
            }catch let error
            {
                print(error.localizedDescription)
            }
            
            
        }).resume()
    }
    
    //MARK: - Animations
    func animatePulsatingLayer(){
        let animation = CABasicAnimation(keyPath: "transform.scale")
        
        animation.toValue = (0.28*view.bounds.width)/100
        animation.duration = 0.9
        animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        animation.autoreverses = true
        animation.repeatCount = Float.infinity
        logoView.layer.add(animation, forKey: "logoAnimation")
    }
}

