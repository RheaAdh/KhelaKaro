//
//  ViewController.swift
//  Khela Karo
//
//  Created by Rhea Adhikari on 08/10/22.
//  Copyright © 2022 Rhea Adhikari. All rights reserved.
//

import UIKit
import FirebaseAuth


class ViewController: UIViewController {
    @IBOutlet weak var loginScrollView: UIScrollView!
    
    @IBOutlet var email: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var registerButton: UIButton!
    
    var firstName = ""
    var lastName = ""
    var contactNo = ""
    
    func showErrorMsg(errorMsg: String){
        let alert = UIAlertController(title: "Error", message: errorMsg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        //disabling button
        loginButton.isEnabled = false
        loginButton.borderColor = UIColor.gray
        
        let email = email.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Signing in the user
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
            if error != nil {
                // Couldn't sign in
                self.loginButton.isEnabled = true
                self.loginButton.borderColor = UIColor(red: 0.741, green: 0.518, blue: 1.0, alpha: 1.0)
                self.showErrorMsg(errorMsg: error!.localizedDescription)
                return
            }
            else {
                self.email.text = ""
                self.password.text = ""
                self.loginButton.isEnabled = true
                self.loginButton.borderColor = UIColor(red: 0.741, green: 0.518, blue: 1.0, alpha: 1.0)
                self.performSegue(withIdentifier: "loginSuccess", sender: self.loginButton)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hidesKeyboard()
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //<<<<<<< HEAD
    
    var isExpand : Bool = false
    @objc func keyboardWillShow(){
        if !isExpand{
            self.loginScrollView.contentSize = CGSize(width: self.view.frame.width, height: loginScrollView.frame.height+300)
            isExpand = true
        }
    }
    
    @objc func keyboardWillHide(){
        self.loginScrollView.contentSize = CGSize(width: self.view.frame.width, height: loginScrollView.frame.height-300)
        isExpand = false
        //=======
    }
    }
