//
//  RegisterViewController.swift
//  Khela Karo
//
//  Created by Sneha Tandri on 23/10/22.
//  Copyright © 2022 Rhea Adhikari. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet var firstName: UITextField!
    @IBOutlet var lastName: UITextField!
    @IBOutlet var email: UITextField!
    @IBOutlet var contactNumber: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var rePassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func register(firstName: String,lastName:String,email:String, password:String, contactNumber:String, rePassword:String){
        //register new user
        }
    
    @IBAction func registerPressed(_ sender: Any) {
        if rePassword.text != password.text{
            let alert = UIAlertController(title: "Error", message: "Password mismatch!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true, completion: nil)
            password.text = ""
            rePassword.text = ""
            return
        }
        else{
            
            register(firstName: firstName.text!, lastName: lastName.text!, email: email.text!, password: password.text!, contactNumber: contactNumber.text!, rePassword: rePassword.text!)
            
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
