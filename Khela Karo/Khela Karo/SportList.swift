//
//  SportList.swift
//  Khela Karo
//
//  Created by Sneha Tandri on 23/10/22.
//  Copyright © 2022 Rhea Adhikari. All rights reserved.
//

import UIKit

class SportList: UIViewController {
    
    @IBOutlet weak var mainVerticalStack: UIStackView!
    
    @IBOutlet weak var badmintonStack: UIStackView!
    @IBOutlet weak var footballStackView: UIStackView!
    @IBOutlet weak var tennisStackView: UIStackView!
    @IBOutlet weak var ttStackView: UIStackView!
    
    
    
    @IBOutlet weak var badmintonAvailability: UILabel!
    @IBOutlet weak var badmintonOccupancy: UILabel!
    
    
    @IBOutlet weak var footballAvailability: UILabel!
    @IBOutlet weak var footballOccupancy: UILabel!
    
    
    @IBOutlet weak var tennisAvailability: UILabel!
    @IBOutlet weak var tennisOccupancy: UILabel!
    
    
    @IBOutlet weak var ttAvailability: UILabel!
    
    @IBOutlet weak var ttOccupancy: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: false)
        addBottomBorders(respectiveStackView: badmintonStack)
        addBottomBorders(respectiveStackView: footballStackView)
        addBottomBorders(respectiveStackView: tennisStackView)
        addBottomBorders(respectiveStackView: ttStackView)
    }
    
    func addBottomBorders(respectiveStackView:UIStackView) {
       let bottomBorder = CALayer()
        bottomBorder.frame = CGRect(x:0, y: respectiveStackView.frame.size.height - 1.0, width: respectiveStackView.frame.size.width - 30, height:1.0)
        bottomBorder.backgroundColor = UIColor.gray.cgColor
        bottomBorder.opacity = 0.5
        
        respectiveStackView.layer.addSublayer(bottomBorder)
    }
    
    func styleVerticalStack(){
        mainVerticalStack.layer.cornerRadius = 20
        mainVerticalStack.layer.shadowColor = UIColor.gray.cgColor
        mainVerticalStack.layer.shadowOpacity = 1
        mainVerticalStack.layer.shadowOffset = .zero
        mainVerticalStack.layer.shadowRadius = 10
        mainVerticalStack.layer.borderWidth = 1
        mainVerticalStack.layer.borderColor = UIColor.gray.cgColor
    }

}
