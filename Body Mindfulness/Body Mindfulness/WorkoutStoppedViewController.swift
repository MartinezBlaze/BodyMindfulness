//
//  WorkoutStoppedViewController.swift
//  Body Mindfulness
//
//  Created by Martin Christian on 19/05/19.
//  Copyright © 2019 Martin Christian. All rights reserved.
//

import Foundation
import UIKit

class WorkoutStoppedViewController : UIViewController {
    
    var userId : String?
    var userName : String?
    var userEmail : String?
    var userBmi : Double?
    var userHeight : Int?
    var userWeight : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "WorkoutStoppedSegue")
        {
            let destination = segue.destination as! MainTabBarController
            
            destination.userName = userName
            destination.userEmail = userEmail
            destination.userBmi = userBmi
            destination.userHeight = userHeight
            destination.userWeight = userWeight
        }
    }
    
}
