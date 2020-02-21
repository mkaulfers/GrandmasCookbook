//
//  ViewController.swift
//  GrandmasCookbook
//
//  Created by Matthew Kaulfers on 2/12/20.
//  Copyright © 2020 Matthew Kaulfers. All rights reserved.
//

import UIKit

class LoadingScreen: UIViewController, URLSessionDownloadDelegate{
    
    //MARK: - Vars and Outlets
    var loadedRecipes: Recipes? = nil
    
    let animatedLayer = CAShapeLayer()
    
    var pulsatingLayer: CAShapeLayer!
    
    let progressLabel: UILabel = {
        let label = UILabel()
        label.text = "0%"
        label.textAlignment = .center
        label.font = UIFont.init(name: "GothamRounded-Medium", size: 32)
        label.textColor = UIColor(named: "primaryTextColor")
        return label
    }()
    
    //MARK: - Parent View Management
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //https://api.spoonacular.com/recipes/random?&number=5&apiKey=36af5618ceba4d28a34d6689da3d3d89
        setupProgressBar()
        startDownloading()
        setupProgressLabel()
    }
    
    //MARK: - Download Data
    func startDownloading()
    {
        let configuration = URLSessionConfiguration.default
        let operationQueue = OperationQueue()
        let urlSession = URLSession(configuration: configuration, delegate: self, delegateQueue: operationQueue)
        
        let downloadTask = urlSession.downloadTask(with: URL(string: "http://speedtest-ny.turnkeyinternet.net/100mb.bin")!)
        
        downloadTask.resume()
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
//        //INFO: Configure URL Session
//        let config = URLSessionConfiguration.default
//        let session = URLSession(configuration: config)
//
//        guard let validURL = URL(string: "https://api.spoonacular.com/recipes/random?&number=100&apiKey=36af5618ceba4d28a34d6689da3d3d89") else { return }
//
//        let semaphore = DispatchSemaphore(value: 0)
//
//        let downloadTask = session.dataTask(with: validURL, completionHandler: { (opt_data, opt_response, opt_error) in
//
//            //Debug: Bail Out on error
//            if opt_error != nil { return }
//
//            //Validate: Check the response, statusCode, and data
//            guard let response = opt_response as? HTTPURLResponse,
//                response.statusCode == 200,
//                let data = opt_data
//                else { return }
//
//            do {
//
//                let json = try JSONDecoder().decode(Recipes.self, from: data)
//                semaphore.signal()
//                self.loadedRecipes = json
//
//            } catch let err{
//                print(err.localizedDescription)
//            }
//        })
//
//
//        let observation = downloadTask.progress.observe(\.fractionCompleted) { progress, _ in
//            print(progress.fractionCompleted)
//
//            if progress.fractionCompleted == 1.0
//            {
//                DispatchQueue.main.async {
//                    self.progressBarView.progress = Float(progress.fractionCompleted)
//                    self.progressLabel.text = String(progress.fractionCompleted*100)
//                    self.performSegue(withIdentifier: Utilities.StaticStrings.tabBarController, sender: nil)
//                }
//            }
//        }
//
//        downloadTask.resume()
//        semaphore.wait()
    }
    //MARK: - Delegate Handling
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        //TODO: - Transition upon completion
        print("Finished Downloading")
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        
        let percentage = CGFloat(totalBytesWritten) / CGFloat(totalBytesExpectedToWrite)
        DispatchQueue.main.async {
            self.animatedLayer.strokeEnd = percentage
            self.progressLabel.text = "\(Int(percentage*100))%"
        }
    }
    
    //MARK: - View Setup
    func setupProgressLabel()
    {
        view.addSubview(progressLabel)
        progressLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        progressLabel.center = view.center
    }
    
    func setupProgressBar()
    {
        
        //INFO: Needed to setup the view we're adding. Will be used on the track layer as well as the animatedLayer. We also need to adjust the path depending on the view size. Currently it's set to a radius of 18% based on the width of the screen.
        let circularPath = UIBezierPath(arcCenter: .zero, radius: (18*view.bounds.width)/100, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
        
        //Pulsating Layer
        pulsatingLayer = CAShapeLayer()
        pulsatingLayer.path = circularPath.cgPath
        pulsatingLayer.fillColor = UIColor(named: "primaryDarkerBGColor")?.cgColor
        pulsatingLayer.position = view.center
        view.layer.addSublayer(pulsatingLayer)
        
        animatePulsatingLayer()

        //TrackLayer
        let trackLayer = CAShapeLayer()
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = UIColor(named: "primaryTextColor")?.cgColor
        trackLayer.lineWidth = (4.83*view.bounds.width)/100
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineCap = CAShapeLayerLineCap.round
        trackLayer.position = view.center
        view.layer.addSublayer(trackLayer)
         
        //Animated Layer
        animatedLayer.path = circularPath.cgPath
        animatedLayer.strokeColor = UIColor(named: "secondaryColor")?.cgColor
        animatedLayer.lineWidth = (4.83*view.bounds.width)/100
        animatedLayer.fillColor = UIColor.clear.cgColor
        animatedLayer.lineCap = CAShapeLayerLineCap.round
        animatedLayer.strokeEnd = 0
        animatedLayer.position = view.center
        animatedLayer.transform = CATransform3DMakeRotation(-CGFloat.pi/2, 0, 0, 1)
        view.layer.addSublayer(animatedLayer)
        
        DispatchQueue.main.async {
            self.progressLabel.layer.zPosition = 1
        }
        
    }
    
    //MARK: - Animations
    func animatePulsatingLayer(){
        let animation = CABasicAnimation(keyPath: "transform.scale")
        
        animation.toValue = (0.33*view.bounds.width)/100
        animation.duration = 0.8
        animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        animation.autoreverses = true
        animation.repeatCount = Float.infinity
        pulsatingLayer.add(animation, forKey: "pulsating")
    }
    
    @objc func animate(){
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 1
//        basicAnimation.duration = 2
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        animatedLayer.add(basicAnimation, forKey: "circleAnimation")
    }
}

