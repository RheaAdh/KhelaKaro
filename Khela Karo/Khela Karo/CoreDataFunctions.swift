//
//  CoreDataFunctions.swift
//  Khela Karo
//
//  Created by Sneha Tandri on 09/11/22.
//  Copyright © 2022 Rhea Adhikari. All rights reserved.
//

import Foundation
import CoreData
import Alamofire
import FirebaseAuth

// The data structure we will parse the data into
struct Bookings: Decodable {
    var sport: String
    var date: String
    var time: String
}

class APIMethods{

//    var delegate: DataDelegate?
    static let functions = APIMethods()
    
    func fetchData() {
        let email = Auth.auth().currentUser?.email
        let parameters: [String: String] = ["email": email!]
        AF.request("https://khela-karo.herokuapp.com/api/stats/profile", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { (response) in
    
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
            print(data)
                print(utf8Text)
                // Once the data is recieved pass it using the delegat protocol
//                self.delegate?.updateArray(newArray: utf8Text)
                
            }
        }
    }
    
}
