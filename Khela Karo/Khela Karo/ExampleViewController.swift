//
//  ExampleViewController.swift
//  Khela Karo
//
//  Created by Pragnya Deshpande on 03/11/22.
//  Copyright © 2022 Rhea Adhikari. All rights reserved.
//

import UIKit

class ExampleViewController: UIViewController {

    @IBOutlet weak var MainStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    func styling(){
        MainStackView.layer.cornerRadius = 20
    }

}
