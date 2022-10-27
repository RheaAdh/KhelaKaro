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
        self.hidesKeyboard()
        // Do any additional setup after loading the view.
    }

    func register(firstName: String,lastName:String,email:String, password:String, contactNumber:String){
       guard let url =  URL(string:"http://localhost:5000/api/auth/register")
       else{
           return
        }
       let body: [String: Any] = [
        "firstName": firstName,
        "lastName": lastName,
        "password":password,
        "contactNumber":contactNumber,
        "email":email
        ]
       let finalBody = try? JSONSerialization.data(withJSONObject: body)
       var request = URLRequest(url: url)
       request.httpMethod = "POST"
       request.httpBody = finalBody
       
       request.setValue("application/json", forHTTPHeaderField: "Content-Type")
       URLSession.shared.dataTask(with: request){
           (data, response, error) in
           print(response as Any)
           if let error = error {
               print(error)
               return
           }
           guard let data = data else{
               return
           }
           print(data, String(data: data, encoding: .utf8) ?? "*unknown encoding*")
           
       }.resume()
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
            
            register(firstName: firstName.text!, lastName: lastName.text!, email: email.text!, password: password.text!, contactNumber: contactNumber.text!)
            
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
