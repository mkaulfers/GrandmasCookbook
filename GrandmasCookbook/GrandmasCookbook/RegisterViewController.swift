//
//  RegisterViewController.swift
//  GrandmasCookbook
//
//  Created by Matthew Kaulfers on 2/14/20.
//  Copyright © 2020 Matthew Kaulfers. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    //MARK: - InputFields
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpElements()
    }
    
    //MARK: - Custom Methods
    
    func setUpElements()
    {
        //INFO: Hide the error text field, no errors yet.
        errorLabel.alpha = 0
        
    }
    
    //MARK: - Button Actions
    
    @IBAction func backButton(_ sender: UIButton)
    {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func registerButtonSelected(_ sender: Any)
    {
        
    }
}
