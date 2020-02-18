//
//  RegisterViewController.swift
//  GrandmasCookbook
//
//  Created by Matthew Kaulfers on 2/14/20.
//  Copyright © 2020 Matthew Kaulfers. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth

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
    
    //MARK: - Button Actions
    
    @IBAction func backButton(_ sender: UIButton)
    {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func registerButtonSelected(_ sender: Any)
    {
        //Validate the fields
        let error = validateFields()
        
        if error != nil
        {
            //INFO: Show error.
            showError(error!)
        }
        else
        {
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            //Create the user
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                
                //INFO: Check for errors
                if err != nil {
                    //INFO: There was an error.
                    self.showError("Error creating user")
                }
                else{
                    //INFO: User was created successfully.
                    //TODO: - STOPPED HERE ADDING FIRESTORE (USER)
                    let db = Firestore.firestore()
                    
                    db.collection("users").addDocument(data: ["firstName": firstName, "lastName": lastName, "uid": result!.user.uid]) {(error) in
                        
                        if error != nil
                        {
                            self.showError("Error saving user data to database.")
                        }
                    }
                    
                    //Transition to profile page
                    self.transitionToProfile()
                }
            }
            
            
        }
    }
    
    //MARK: - Custom Methods
    
    func transitionToProfile()
    {
        let profileViewController = storyboard?.instantiateViewController(identifier: Utilities.StaticStrings.profileViewController) as? ProfileViewController
        
        //INFO: Set the root view controller, make root visible.
        view.window?.rootViewController = profileViewController
        view.window?.makeKeyAndVisible()
    }
    
    func showError(_ message: String)
    {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func setUpElements()
    {
        //INFO: Hide the error text field, no errors yet.
        errorLabel.alpha = 0
        
    }
    
    //MARK: Field Validations
    //Checks the fields to ensure that the data is correct. If it is then return nil, otherwise return error message.
    func validateFields() -> String?
    {
        //INFO: Ensure that the fields are not blank.
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            confirmPasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        {
            return "Please fill in all fields."
        }
        
        let cleanedEmail = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        //INFO: Make sure that the email is valid.
        if !Utilities.Validations.isEmailValid(cleanedEmail)
        {
            return "Please enter a valid email."
        }
        
        //INFO: Make sure passwords match
        if passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines) != confirmPasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        {
            return "Your passwords don't match."
        }
        
        
        //INFO: Make sure that the passwords are secure.
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if !Utilities.Validations.isPasswordValid(cleanedPassword)
        {
            return "Please make sure your password is at least 8 characters, contains a special character and a number."
        }
        
        return nil
    }
    
    func isEmailValid(_ email: String) -> Bool
    {
        let emailTest = NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
        return emailTest.evaluate(with: email)
    }
    
    func isPasswordValid(_ password: String) -> Bool
    {
        //INFO: Check password against Regular Expression. 8 Char min, Special Char, Number
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    
}
