//
//  WorkoutPausedViewController.swift
//  Body Mindfulness
//
//  Created by Martin Christian on 19/05/19.
//  Copyright © 2019 Martin Christian. All rights reserved.
//

import Foundation
import UIKit

class WorkoutPausedViewController : UIViewController {
    
    @IBOutlet weak var timeRemainingLabel: UILabel!
    
    var userName : String?
    var userEmail : String?
    var userBmi : Double?
    var userHeight : Int?
    var userWeight : Int?
    
    var workoutCategoryName = ""
    var workoutName = ["Push-up", "Wall-sit", "Sit-up", "Jumping jacks", "Wall sit"]
    var workoutDuration = [30, 30, 30, 30, 30]
    var workoutCounter = 1
    
    var remainingSeconds = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func continueButtonAction(_ sender: UIButton) {
        performSegue(withIdentifier: "WorkoutResumeSegue", sender: nil)
    }
    
    @IBAction func stopButtonAction(_ sender: UIButton) {
        performSegue(withIdentifier: "WorkoutPauseStopSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "WorkoutResumeSegue")
        {
            let destination = segue.destination as! WorkoutStartViewController
            
            destination.seconds = remainingSeconds
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
        
        else if segue.identifier == "WorkoutPauseStopSegue"
        {
            let destination = segue.destination as! WorkoutStoppedViewController
            
            destination.userName = userName
            destination.userEmail = userEmail
            destination.userBmi = userBmi
            destination.userHeight = userHeight
            destination.userWeight = userWeight
        }
    }

}
