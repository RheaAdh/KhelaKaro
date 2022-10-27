//
//  LoginViewController.swift
//  Khela Karo
//
//  Created by Rhea Adhikari on 26/10/22.
//  Copyright © 2022 Rhea Adhikari. All rights reserved.
//

import UIKit

class LoginViewModel: ObservableObject{

   
    
    var email : String = "";

    var password: String = "";
    
    func login(){
        WebService().login(email:email,password:password){ result in
                   switch result {
                   case .success(let token):
                       print(token)
                   case .failure(let error):
                    print(error.localizedDescription)
               }
        }

    }
}


