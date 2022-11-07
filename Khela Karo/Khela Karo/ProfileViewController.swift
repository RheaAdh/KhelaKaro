//
//  ProfileViewController.swift
//  Khela Karo
//
//  Created by Pragnya Deshpande on 04/11/22.
//  Copyright © 2022 Rhea Adhikari. All rights reserved.
//

import UIKit
import FirebaseAuth
import Alamofire
import SwiftyJSON

class ProfileViewController: UIViewController {
    
    
    @IBOutlet weak var logoutButton: UIBarButtonItem!
    @IBOutlet var userEmail: UILabel!
    @IBOutlet var userName: UILabel!
    @IBOutlet weak var myBookingsTableView: UITableView!
    @IBOutlet weak var streakDays: UILabel!
    @IBOutlet weak var frequentSport: UILabel!
    
    func showConfirmLogoutMsg(){
        let alert = UIAlertController(title: "Confirm", message: "Are you sure you want to logout?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .default){ (action) -> Void in})
        let ok = UIAlertAction(title: "Yes", style: .default, handler: { [self] (action) -> Void in
            performLogout()
        })

        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    func performLogout(){
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
            
        }
        catch let err{
           print(err)
        }
    }

    @IBAction func logoutButtonPressed(_ sender: Any) {
        showConfirmLogoutMsg()
    }
    
    func getName(email: String, completion: @escaping (String) -> Void){
        
        //declare parameter as a dictionary which contains string as key and value combination. considering inputs are valid
        var result = ""
        let parameters: [String: String] = ["email": email]
        AF.request("http://localhost:5000/api/getname", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { (response) in
//            print("Response: \(response.result)")
            if let json = response.data {
//                print("json:\(json)")
                let responseJSON = try! JSON(data: json)
                let message = responseJSON["msg"].stringValue
                if !message.isEmpty {
                        print(message)
                    result =  message
                    }
                }
            completion(result)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userEmail.text = Auth.auth().currentUser?.email!
        getName(email: self.userEmail.text!) {
            (result) in
            self.userName.text = result
        }

    }
    

}
