//
//  LoginViewController.swift
//  GrandmasCookbook
//
//  Created by Matthew Kaulfers on 2/14/20.
//  Copyright © 2020 Matthew Kaulfers. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    //MARK: - Input Fields
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpElements()
    }
    
    //MARK: - Custom Methods
    
    func setUpElements()
    {
        errorLabel.alpha = 0
    }
    
    //MARK: - Button Controls
    
    @IBAction func backButton(_ sender: UIButton)
    {
        dismiss(animated: true, completion: nil)
    }
    
    
}
