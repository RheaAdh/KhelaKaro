//
//  SportList.swift
//  Khela Karo
//
//  Created by Sneha Tandri on 23/10/22.
//  Copyright © 2022 Rhea Adhikari. All rights reserved.
//

import UIKit
import Alamofire
import FirebaseAuth
import SwiftyJSON

class SportList: UIViewController {
    
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
    
    @IBOutlet var welcomemsg: UILabel!
    @IBOutlet weak var mainVerticalStack: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: false)
        var email = Auth.auth().currentUser?.email!
        getName(email: email!) {
            (result) in
            self.welcomemsg.text = "Welcome \(result)!"
        }
    }
}
