//
//  WorkoutRestPausedViewController.swift
//  Body Mindfulness
//
//  Created by Martin Christian on 21/05/19.
//  Copyright © 2019 Martin Christian. All rights reserved.
//

import Foundation
import UIKit

class WorkoutRestPausedViewController : UIViewController {
    
    var userName : String?
    var userEmail : String?
    var userBmi : Double?
    var userHeight : Int?
    var userWeight : Int?
    
    var workoutCategoryName = ""
    var workoutName = ["Push-up", "Wall-sit", "Sit-up", "Jumping jacks", "Wall sit"]
    var workoutDuration = [30, 30, 30, 30, 30]
    var workoutCounter = 1
    
    var remainingSeconds : Int?
    
    @IBAction func continueButtonAction(_ sender: UIButton) {
        performSegue(withIdentifier: "WorkoutRestPauseContinueSegue", sender: nil)
    }
    
    
    @IBAction func stopButtonAction(_ sender: UIButton) {
        performSegue(withIdentifier: "WorkoutRestStopSegue", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let newRemainingSeconds = remainingSeconds
        
        if segue.identifier == "WorkoutRestPauseContinueSegue"
        {
            let destination = segue.destination as! WorkoutRestViewController
            destination.seconds = newRemainingSeconds!
            destination.workoutName = workoutName
            destination.workoutDuration = workoutDuration
            destination.workoutCategoryName = workoutCategoryName
            destination.workoutCounter = workoutCounter
            
            destination.userName = userName
            destination.userEmail = userEmail
            destination.userBmi = userBmi
            destination.userHeight = userHeight
            destination.userWeight = userWeight
        }
            
        else if segue.identifier == "WorkoutRestStopSegue"
        {
            let destination = segue.destination as! WorkoutStoppedViewController
            
            destination.userName = userName
            destination.userEmail = userEmail
            destination.userBmi = userBmi
            destination.userHeight = userHeight
            destination.userWeight = userWeight
        }
            
        else if segue.identifier == "WorkoutRestPauseSegue"
        {
            let destination = segue.destination as! WorkoutStartViewController
            destination.workoutName = workoutName
            destination.workoutDuration = workoutDuration
            destination.workoutCategoryName = workoutCategoryName
            destination.workoutCounter = workoutCounter
            
            destination.userName = userName
            destination.userEmail = userEmail
            destination.userBmi = userBmi
            destination.userHeight = userHeight
            destination.userWeight = userWeight
        }
        
    }
    
}
