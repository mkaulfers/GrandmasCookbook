//
//  ViewController.swift
//  GrandmasCookbook
//
//  Created by Matthew Kaulfers on 2/12/20.
//  Copyright © 2020 Matthew Kaulfers. All rights reserved.
//

import UIKit

class LoadingScreen: UIViewController{
    //MARK: - Vars and Outlets
    var loadedRecipes: Recipes? = nil
    @IBOutlet var progressBarView: UIProgressView!
    @IBOutlet var progressLabel: UILabel!
    
    //MARK: - Parent View Management
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //https://api.spoonacular.com/recipes/random?&number=5&apiKey=36af5618ceba4d28a34d6689da3d3d89
    }
    
    override func viewDidAppear(_ animated: Bool) {
        startDownloading()
    }
    
    func startDownloading()
    {
        //INFO: Configure URL Session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        guard let validURL = URL(string: "https://api.spoonacular.com/recipes/random?&number=100&apiKey=36af5618ceba4d28a34d6689da3d3d89") else { return }
        
        let semaphore = DispatchSemaphore(value: 0)
        
        let downloadTask = session.dataTask(with: validURL, completionHandler: { (opt_data, opt_response, opt_error) in
            
            //Debug: Bail Out on error
            if opt_error != nil { return }
            
            //Validate: Check the response, statusCode, and data
            guard let response = opt_response as? HTTPURLResponse,
                response.statusCode == 200,
                let data = opt_data
                else { return }
            
            do {
                
                let json = try JSONDecoder().decode(Recipes.self, from: data)
                semaphore.signal()
                self.loadedRecipes = json
                
            } catch let err{
                print(err.localizedDescription)
            }
        })
        
        
        let observation = downloadTask.progress.observe(\.fractionCompleted) { progress, _ in
            print(progress.fractionCompleted)
            
            if progress.fractionCompleted == 1.0
            {
                DispatchQueue.main.async {
                    self.progressBarView.progress = Float(progress.fractionCompleted)
                    self.progressLabel.text = String(progress.fractionCompleted*100)
                    self.performSegue(withIdentifier: Utilities.StaticStrings.tabBarController, sender: nil)
                }
            }
        }
        
        downloadTask.resume()
        semaphore.wait()
    }
}

