//
//  ViewExtensions.swift
//  Khela Karo
//
//  Created by Pragnya Deshpande on 28/10/22.
//  Copyright © 2022 Rhea Adhikari. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    func hidesKeyboard(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
    }
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
}


