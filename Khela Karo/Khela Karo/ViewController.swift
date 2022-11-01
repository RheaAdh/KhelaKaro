//
//  ViewController.swift
//  Khela Karo
//
//  Created by Rhea Adhikari on 08/10/22.
//  Copyright © 2022 Rhea Adhikari. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase


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
                self.getUser()
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
        func getUser() {
            guard let userID = Auth.auth().currentUser?.uid else { return }
            let db = Firestore.firestore()
            let users = db.collection("users")
            let query = users.whereField("uid", isEqualTo: userID)
            query.getDocuments(completion: {(querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        self.lastName = (document.data()["lastname"] as? String ?? nil)!
                        self.firstName = (document.data()["firstname"] as? String ?? nil)!
                        self.contactNo = (document.data()["phoneNo"] as? String ?? nil)!
                        //print("\(firstName) => \(lastName)")
                        //print("\(email)")
                    }
                }})
            let constants = Constants(uid: userID, firstname: firstName, lastname: lastName, contactno: contactNo)
            print("\(constants.uid), \(constants.firstname)")
            //>>>>>>> refs/remotes/origin/master
        }
    }
}
