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
    var currentParsedObject: Recipes? = nil
    
    //MARK: - Parent View Management
    override func viewDidLoad() {
        super.viewDidLoad()
        animatePulsatingLayer()
        startDownloading()
    }
    
    //MARK: - Download Data
    func startDownloading()
    {
        if true{
            print("WARNING: Using TestJSONFile")
            if let path = Bundle.main.path(forResource: "TestJsonObject", ofType: "json")
            {
                let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                Utilities.GlobalData.currentRecipes = try! JSONDecoder().decode(Recipes.self, from: data!)
            }
            
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "toTabBarController", sender: nil)
            }
        }
        else
        {
            print("WARNING: Using API to get new data.")
            //INFO: Configure URL Session
            guard let validURL = URL(string: Utilities.StaticStrings.get100Recipes) else { return }
            URLSession.shared.dataTask(with: validURL, completionHandler: { (opt_data, opt_response, opt_error) in
                
                //Debug: Bail Out on error
                if opt_error != nil { return }
                
                //Validate: Check the response, statusCode, and data
                guard let response = opt_response as? HTTPURLResponse,
                    response.statusCode == 200,
                    let data = opt_data
                    else { return }
                
                Utilities.GlobalData.currentRecipes = try! JSONDecoder().decode(Recipes.self, from: data)
            
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "toTabBarController", sender: nil)
                }
            }).resume()
        }
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

