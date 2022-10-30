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

    @IBOutlet var email: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var registerButton: UIButton!
    
    func showErrorMsg(errorMsg: String){
        let alert = UIAlertController(title: "Error", message: errorMsg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        let email = email.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Signing in the user
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
            if error != nil {
                // Couldn't sign in
                self.showErrorMsg(errorMsg: error!.localizedDescription)
                return
            }
            else {
                self.performSegue(withIdentifier: "loginSuccess", sender: self.loginButton)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hidesKeyboard()
        // Do any additional setup after loading the view.
    }
    
}
