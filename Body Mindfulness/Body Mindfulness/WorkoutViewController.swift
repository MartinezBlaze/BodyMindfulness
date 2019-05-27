//
//  WorkoutViewController.swift
//  Body Mindfulness
//
//  Created by Martin Christian on 19/05/19.
//  Copyright © 2019 Martin Christian. All rights reserved.
//

import Foundation
import UIKit

class WorkoutViewController : UIViewController {
    
    var userName : String?
    var userEmail : String?
    var userBmi : Double?
    var userHeight : Int?
    var userWeight : Int?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func classicWorkoutButtonAction(_ sender: UIButton) {
        performSegue(withIdentifier: "ClassicWorkoutSegue", sender: nil)
    }
    
    @IBAction func absWorkoutButtonAction(_ sender: UIButton) {
        performSegue(withIdentifier: "AbsWorkoutSegue", sender: nil)
    }
    
    
    @IBAction func armWorkoutButtonAction(_ sender: UIButton) {
        performSegue(withIdentifier: "ArmWorkoutSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ClassicWorkoutSegue"
        {
            let destination = segue.destination as! WorkoutDetailsViewController
            destination.workoutCategoryName = "Classic workout"
            destination.workoutName = ["Push-Up", "Wall Sit", "Sit-Up", "Jumping Jacks", "Wall Sit", "Plank", "High Stepping"]
            destination.workoutDuration = [30, 30, 30, 30, 30, 30, 30]
            
            destination.userName = userName
            destination.userEmail = userEmail
            destination.userBmi = userBmi
            destination.userHeight = userHeight
            destination.userWeight = userWeight
        }
        
        else if segue.identifier == "AbsWorkoutSegue"
        {
            let destination = segue.destination as! WorkoutDetailsViewController
            destination.workoutCategoryName = "Abs workout"
            destination.workoutName = ["Jumping squats", "Reverse Crunches", "Russian Twist", "Bird Dog", "Burpees", "Plank", "Bridge"]
            destination.workoutDuration = [30, 30, 30, 30, 30, 30, 30]
            
            destination.userName = userName
            destination.userEmail = userEmail
            destination.userBmi = userBmi
            destination.userHeight = userHeight
            destination.userWeight = userWeight
        }
        
        else if segue.identifier == "ArmWorkoutSegue"
        {
            let destination = segue.destination as! WorkoutDetailsViewController
            destination.workoutCategoryName = "Arm workout"
            destination.workoutName = ["Push-Up", "Triceps Dips", "Punches", "Arm Circles", "Reverse Push-Ups", "Plank Taps", "One Leg Push-Ups"]
            destination.workoutDuration = [30, 30, 30, 30, 30, 30, 30]
            
            destination.userName = userName
            destination.userEmail = userEmail
            destination.userBmi = userBmi
            destination.userHeight = userHeight
            destination.userWeight = userWeight
        }
        
    }
    
}
