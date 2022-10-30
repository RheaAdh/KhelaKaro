//
//  RegisterViewController.swift
//  Khela Karo
//
//  Created by Sneha Tandri on 23/10/22.
//  Copyright © 2022 Rhea Adhikari. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase


class RegisterViewController: UIViewController {

    @IBOutlet var firstName: UITextField!
    @IBOutlet var lastName: UITextField!
    @IBOutlet var email: UITextField!
    @IBOutlet var contactNumber: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var rePassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hidesKeyboard()
        // Do any additional setup after loading the view.
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    // check the fields and validate that the data is correct. If correct return nil else return error message as a string
    func validateFields() -> String?{
        //check that all fields are filled in
        if email.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            firstName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            password.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || rePassword.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            contactNumber.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            return "Please fill in all fields"
        }
        else if isValidEmail(email.text!) == false{
            return "Please enter valid email"
        }
        else if password.text != rePassword.text {
            return "Passwords do not match"
        }
        else if password.text!.count < 6 {
            return "Password must be atleast 6 characters long"
        }
        else if contactNumber.text!.count != 10 {
            return "Enter 10 digit contact number"
        }
        return nil
    }
    
    func showErrorMsg(errorMsg: String){
        let alert = UIAlertController(title: "Error", message: errorMsg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
    }

    
    @IBAction func registerPressed(_ sender: Any) {
        //validate the fields
        let error = validateFields()
        if error != nil {
            //show error message
            showErrorMsg(errorMsg: error!)
        }
        //create the user
        else {
            
            // Create cleaned versions of the data
            let firstName = firstName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = email.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let phoneNo = contactNumber.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().createUser(withEmail: email, password: password) {(result, err) in
                // Check for errors
                if err != nil {
                    
                    // There was an error creating the user
                    self.showErrorMsg(errorMsg: "Error creating user")
                }
                else {
                    
                    // User was created successfully, now store the first name and last name
                    let db = Firestore.firestore()
                    
                    db.collection("users").addDocument(data: ["firstname":firstName, "lastname":lastName, "uid": result!.user.uid, "phoneNo": phoneNo]) { (error) in
                        
                        if error != nil {
                            // Show error message
                            self.showErrorMsg(errorMsg: "Error saving user data")
                        }
                    }
                    
                    // Transition to the login screen
                    self.navigationController?.popToRootViewController(animated: true)
                }
            }
        }
        
    }

}
