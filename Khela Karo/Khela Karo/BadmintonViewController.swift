//
//  BadmintonViewController.swift
//  Khela Karo
//
//  Created by Pragnya Deshpande on 03/11/22.
//  Copyright © 2022 Rhea Adhikari. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import FirebaseAuth

class BadmintonViewController: UIViewController {

    
    @IBOutlet weak var bookNowButton: UIButton!
    @IBOutlet weak var dateTimePicker: UIDatePicker!
    let dateFormatter = DateFormatter()
    var result = ""
    
    func showErrorMsg(errorMsg: String, success: Bool){
        if success == false {
            let alert = UIAlertController(title: "Error", message: errorMsg, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true, completion: nil)
        }
        else {
            let alert = UIAlertController(title: "Message", message: errorMsg, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        dateFormatter.dateFormat = "HH:mm:ss"
        dateTimePicker.minimumDate = Date()
        dateTimePicker.datePickerMode = .dateAndTime
        dateFormatter.timeStyle = DateFormatter.Style.long
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    }
    
    @IBAction func bookNowPressed(_ sender: Any) {
        bookNowButton.isEnabled = false
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "MMM dd YYYY HH:mm:00"
        let dateInput = dateFormatter.string(from: dateTimePicker.date)
        print("\(dateInput)!!")
        dateFormatter.dateFormat = "HH"
        let timeHr = dateFormatter.string(from: dateTimePicker.date)
        print("\(timeHr)")
        let timeHrInt: Int? = Int(timeHr)
        if timeHrInt! >= 19 || timeHrInt! < 11 {
            showErrorMsg(errorMsg: "Please choose timings between 11am to 7pm", success: false)
        }
        else {
            let user = Auth.auth().currentUser
            if let user = user {
                let userEmail = user.email
                bookCourt(facilityId: "1", startDateTime: dateInput, email: userEmail!) {
                    (result) in
                    if(result != ""){
                        if result == "Booked court 1 successfully!" {
                            self.showErrorMsg(errorMsg: result, success: true) }
                        else {
                            self.showErrorMsg(errorMsg: result, success: false)
                        }}
                    self.bookNowButton.isEnabled = true
                }
            }
        }
    }
    
    func bookCourt(facilityId: String, startDateTime: String, email: String, completion: @escaping (String) -> Void){
        
        //declare parameter as a dictionary which contains string as key and value combination. considering inputs are valid
        var result = ""
        let parameters: [String: String] = ["facilityId": facilityId, "startDateTime": startDateTime, "email": email]
        AF.request("http://localhost:5000/api/booking", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { (response) in
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
    
}
