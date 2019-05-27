//
//  MainTabBarController.swift
//  Body Mindfulness
//
//  Created by Martin Christian on 18/05/19.
//  Copyright © 2019 Martin Christian. All rights reserved.
//

import Foundation
import UIKit

class MainTabBarController: UITabBarController {
    
    var userName : String?
    var userEmail : String?
    var userBmi : Double?
    var userHeight : Int?
    var userWeight : Int?
    
    var selectedTabBar = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // select the right tab bar based on last visited section
        self.selectedIndex = selectedTabBar
        
        guard let viewControllers = viewControllers else {
            return
        }
        
        for viewController in viewControllers {
        
            if let profileNavigationController = viewController as? ProfileNavigationController {
        
                if let profileViewController = profileNavigationController.viewControllers.first as? ProfileViewController {
                        profileViewController.userName = userName
                        profileViewController.userEmail = userEmail
                        profileViewController.userBmi = userBmi
                        profileViewController.userHeight = userHeight
                        profileViewController.userWeight = userWeight
                }
        
            }
            
            else if let workoutNavigationController = viewController as? WorkoutNavigationController {
                
                if let workoutViewController = workoutNavigationController.viewControllers.first as? WorkoutViewController {
                        workoutViewController.userName = userName
                        workoutViewController.userEmail = userEmail
                        workoutViewController.userBmi = userBmi
                        workoutViewController.userHeight = userHeight
                        workoutViewController.userWeight = userWeight
                }
                
            }
        
        }
    }
}
