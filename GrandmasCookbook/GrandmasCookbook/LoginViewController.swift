//
//  LoginViewController.swift
//  GrandmasCookbook
//
//  Created by Matthew Kaulfers on 2/14/20.
//  Copyright © 2020 Matthew Kaulfers. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    //MARK: - Input Fields
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpElements()
    }
    
    //MARK: - Button Controls
    
    @IBAction func logInButton(_ sender: Any)
    {
        //INFO: Do some validation
        let error = validateFields()
        
        if error != nil
        {
            showError(error!)
        }
        else
        {
            //INFO: Cleanup input fields.
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                if error != nil
                {
                    self.errorLabel.text = error!.localizedDescription
                    self.errorLabel.alpha = 1
                }
                else
                {
                    let profileViewController = self.storyboard?.instantiateViewController(identifier: Utilities.Storyboard.profileViewController) as? ProfileViewController
                    
                    //INFO: Set the root view controller, make root visible.
                    self.view.window?.rootViewController = profileViewController
                    self.view.window?.makeKeyAndVisible()
                }
            }
        }
    }
    
    @IBAction func backButton(_ sender: UIButton)
    {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Custom Methods
    
    func setUpElements()
    {
        errorLabel.alpha = 0
    }
    
    func validateFields() -> String?
    {
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        {
            return "Please fill in all fields."
        }
        
        let cleanedEmail = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if !Utilities.Validations.isEmailValid(cleanedEmail)
        {
            return "Please enter a valid email."
        }
        return nil
    }
    
    func showError(_ message: String)
    {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    
}
