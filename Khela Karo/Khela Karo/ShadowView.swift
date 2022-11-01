//
//  ShadowView.swift
//  Khela Karo
//
//  Created by Pragnya Deshpande on 30/10/22.
//  Copyright © 2022 Rhea Adhikari. All rights reserved.
//
import Foundation
import UIKit

@IBDesignable
class ShadowView: UIStackView {
    //Shadow
    @IBInspectable var shadowColor: UIColor = UIColor.black {
        didSet {
            self.updateView()
        }
    }
    @IBInspectable var shadowOpacity: Float = 0.5 {
        didSet {
            self.updateView()
        }
    }
    @IBInspectable var shadowOffset: CGSize = CGSize(width: 3, height: 3) {
        didSet {
            self.updateView()
        }
    }
    @IBInspectable var shadowRadius: CGFloat = 15.0 {
        didSet {
            self.updateView()
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 15.0{
        didSet{
            self.updateView()
        }
    }
    
    //Apply params
    func updateView() {
        self.layer.shadowColor = self.shadowColor.cgColor
        self.layer.shadowOpacity = self.shadowOpacity
        self.layer.shadowOffset = self.shadowOffset
        self.layer.shadowRadius = self.shadowRadius
        self.layer.borderWidth = self.borderWidth
    }
}

