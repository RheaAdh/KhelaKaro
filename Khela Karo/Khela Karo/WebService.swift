//
//  WebService.swift
//  Khela Karo
//
//  Created by Rhea Adhikari on 26/10/22.
//  Copyright © 2022 Rhea Adhikari. All rights reserved.
//

import Foundation

enum AuthenticationError:Error{
    case invalidCredentials
    case custom(errorMessage:String)
}

struct LoginRequestBody: Codable{
    let email : String
    let password : String
}

class WebService{
    func login(email: String , password: String, completion : @escaping ( Result<String,AuthenticationError> ) -> Void ){
           guard let url = URL(string:"http://localhost:5000/api/auth") else {
               completion(.failure(.custom(errorMessage:"URL is not correct")))
               return
           }
           let body = LoginRequestBody(email: email, password: password)
           var request = URLRequest(url :url)
           request.httpMethod = "POST"
           request.addValue("application/json", forHTTPHeaderField:"Content-Type")
           request.httpBody= try? JSONEncoder().encode(body)
           URLSession.shared.dataTask(with: request){
               (data , response, error) in
               guard let data = data, error == nil else {
                   completion(.failure(.custom(errorMessage:"No data")))
                   return
               }
               guard let loginResponse = try? JSONDecoder.decode(LoginResponse.self,from:data) else {
                   completion(.failure(.invalidCredentials))
                   return
               }
               guard let token = loginResponse.token else {
                   completion(.failure(.invalidCredentials))
                   return
               }
           }.resume()
       }
}
