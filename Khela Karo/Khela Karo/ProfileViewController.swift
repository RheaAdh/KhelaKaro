//
//  ProfileViewController.swift
//  Khela Karo
//
//  Created by Pragnya Deshpande on 04/11/22.
//  Copyright © 2022 Rhea Adhikari. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    
    @IBOutlet weak var logoutButton: UIBarButtonItem!
    
    @IBAction func logoutButtonPressed(_ sender: Any) {
        // Create Alert
        let dialogMessage = UIAlertController(title: "Confirm", message: "Are you sure you want to logout?", preferredStyle: .alert)

        // Create OK button with action handler
        let ok = UIAlertAction(title: "Yes", style: .default, handler: { [self] (action) -> Void in
            performSegue(withIdentifier: "LogoutSegue", sender: logoutButton)
        })

        // Create Cancel button with action handlder
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
            print("Cancel button pressed")
        }

        //Add OK and Cancel button to an Alert object
        dialogMessage.addAction(ok)
        dialogMessage.addAction(cancel)

        // Present alert message to user
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
    
    @IBOutlet weak var myBookingsTableView: UITableView!
    
    @IBOutlet weak var streakDays: UILabel!
    
    @IBOutlet weak var frequentSport: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

}
