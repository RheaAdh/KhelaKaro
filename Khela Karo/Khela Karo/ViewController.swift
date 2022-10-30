//
//  ViewController.swift
//  Khela Karo
//
//  Created by Rhea Adhikari on 08/10/22.
//  Copyright © 2022 Rhea Adhikari. All rights reserved.
//

import UIKit



class ViewController: UIViewController {

    @IBOutlet var email: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hidesKeyboard()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let sender = sender as? UIButton else {return}
        if sender == loginButton {
            //login button pressed -> verify username and password
//            guard let registerButton = segue.destination as? SportList else { return }
        } else {
            //register button pressed call the register page
            
        }
    }
}
