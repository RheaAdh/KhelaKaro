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

// Custom protocol that parses the JSON and updated the arrray
//protocol DataDelegate {
//    func updateArray(newArray: String)
//}
//
class ProfileViewController: UIViewController {
//    class ProfileViewController: UIViewController, DataDelegate {
//    func updateArray(newArray: String) {
//        do{
//            bookingsArray = try JSONDecoder().decode([Bookings].self,from: newArray.data(using: .utf8)!)
////            let responseJSON = try! JSON(data: newArray)
////            let message = responseJSON["data"].stringValue
////            if !message.isEmpty {
////                        print(message)
////                }
////            print(bookingsArray)
//        }catch let jsonErr {
//            print(jsonErr)
//        }
//        //self.tableView.reloadData()
//    }
//
    
    
    @IBOutlet weak var logoutButton: UIBarButtonItem!
    @IBOutlet var userEmail: UILabel!
    @IBOutlet var userName: UILabel!
    @IBOutlet weak var myBookingsTableView: UITableView!
    @IBOutlet weak var streakDays: UILabel!
    @IBOutlet weak var frequentSport: UILabel!
    
    var bookingsArray = [Bookings]()
    
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
        AF.request("https://khela-karo.herokuapp.com/api/getname", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { (response) in
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
//        APIMethods.functions.delegate = self
        getName(email: self.userEmail.text!) {
            (result) in
            self.userName.text = result
        }

    }
    
//    // Everytime the list of notes is shown, update the array of notes and the tableview
//    override func viewWillAppear(_ animated: Bool) {
//        APIMethods.functions.fetchData()
//        //self.tableView.reloadData()
//    }
    

}

//extension ViewController: DataDelegate {
//
//    // Get data from the API call and parse it
//    func updateArray(newArray: String) {
//        do{
//            notesArray = try JSONDecoder().decode([Notes].self,from: newArray.data(using: .utf8)!)
//        }catch let jsonErr {
//            print(jsonErr)
//        }
//        self.tableView.reloadData()
//    }
//
//}
