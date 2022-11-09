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

struct Bookings: Codable {
    var sport: String
    var date: String
    var time: String
}
class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookingsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "prototype", for: indexPath) as? TableViewCell else {return UITableViewCell()}
        cell.titleLabel.text = bookingsArray[indexPath.row].sport
        cell.noteLabel.text = bookingsArray[indexPath.row].date
        return cell
    }
    
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
        myBookingsTableView.delegate = self
        myBookingsTableView.dataSource = self
        
        self.userEmail.text = Auth.auth().currentUser?.email!
        getName(email: self.userEmail.text!) {
            (result) in
            self.userName.text = result
        }
        fetchData(){
            (result) in
            print(self.bookingsArray)
            self.myBookingsTableView.reloadData()
            self.frequentSport.text = result
        }
        
    }
    
    private func fetchData(completion: @escaping (String) -> Void){
        let email = Auth.auth().currentUser?.email
        let parameters: [String: String] = ["email": email!]
        AF.request("https://khela-karo.herokuapp.com/api/stats/profile", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { (response) in
            var maxPlayed = ""
            if let data = response.data {
                let newArray = data
                do{
                    let responseJSON = try! JSON(data: newArray)
                    let message = responseJSON["data"]
                    if !message.isEmpty {
                        print(message)
                        let badminton = message["s1"]
                        let tennis = message["s2"]
                        let tableTennis = message["s3"]
                        let football = message["s4"]
                        if(badminton.count >= tennis.count && badminton.count >= tableTennis.count && badminton.count >= football.count){
                            maxPlayed = "Badminton"
                        }
                        else if(tennis.count >= badminton.count && tennis.count >= tableTennis.count && tennis.count >= football.count){
                            maxPlayed = "Tennis"
                        }
                        else if(tableTennis.count >= badminton.count && tableTennis.count >= tennis.count && tableTennis.count >= football.count){
                            maxPlayed = "Table Tennis"
                        }
                        else if(football.count >= badminton.count && football.count >= tableTennis.count && football.count >= tennis.count){
                            maxPlayed = "Football"
                        }
                        for dateTime in badminton {
                            let dateFormatter = DateFormatter()
                            dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
                            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000Z"
                            var test = dateTime.1.rawValue as! String
                            let dateInput = dateFormatter.date(from: test)
                            //print("\(dateInput)!!")
                            dateFormatter.dateFormat = "dd/MM/YYYY"
                            let dateBooking = dateFormatter.string(from: dateInput!)
                            dateFormatter.dateFormat = "HH:mm"
                            let timeBooking = dateFormatter.string(from: dateInput!)
                            let thisBooking = Bookings(sport: "Badminton", date: dateBooking, time: timeBooking)
                            self.bookingsArray.append(thisBooking)
                        }
                        for dateTime in tennis {
                            let dateFormatter = DateFormatter()
                            dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
                            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000Z"
                            var test = dateTime.1.rawValue as! String
                            let dateInput = dateFormatter.date(from: test)
                            //print("\(dateInput)!!")
                            dateFormatter.dateFormat = "dd/MM/YYYY"
                            let dateBooking = dateFormatter.string(from: dateInput!)
                            dateFormatter.dateFormat = "HH:mm"
                            let timeBooking = dateFormatter.string(from: dateInput!)
                            let thisBooking = Bookings(sport: "Tennis", date: dateBooking, time: timeBooking)
                            self.bookingsArray.append(thisBooking)
                        }
                        for dateTime in tableTennis {
                            let dateFormatter = DateFormatter()
                            dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
                            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000Z"
                            var test = dateTime.1.rawValue as! String
                            let dateInput = dateFormatter.date(from: test)
                            //print("\(dateInput)!!")
                            dateFormatter.dateFormat = "dd/MM/YYYY"
                            let dateBooking = dateFormatter.string(from: dateInput!)
                            dateFormatter.dateFormat = "HH:mm"
                            let timeBooking = dateFormatter.string(from: dateInput!)
                            let thisBooking = Bookings(sport: "Table Tennis", date: dateBooking, time: timeBooking)
                            self.bookingsArray.append(thisBooking)
                        }
                        
                        for dateTime in football {
                            let dateFormatter = DateFormatter()
                            dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
                            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000Z"
                            var test = dateTime.1.rawValue as! String
                            let dateInput = dateFormatter.date(from: test)
                            //print("\(dateInput)!!")
                            dateFormatter.dateFormat = "dd/MM/YYYY"
                            let dateBooking = dateFormatter.string(from: dateInput!)
                            dateFormatter.dateFormat = "HH:mm"
                            let timeBooking = dateFormatter.string(from: dateInput!)
                            let thisBooking = Bookings(sport: "Football", date: dateBooking, time: timeBooking)
                            self.bookingsArray.append(thisBooking)
                        }
                        print(self.bookingsArray)
                        self.myBookingsTableView.reloadData()
                        
                    }
                }catch let jsonErr {
                    print(jsonErr)
                }
                completion(maxPlayed)
            }
            
        }
        
    }
}
