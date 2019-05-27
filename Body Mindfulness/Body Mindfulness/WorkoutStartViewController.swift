//
//  WorkoutStartViewController.swift
//  Body Mindfulness
//
//  Created by Martin Christian on 19/05/19.
//  Copyright © 2019 Martin Christian. All rights reserved.
//

import Foundation
import UIKit

class WorkoutStartViewController : UIViewController {
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var workoutCategoryLabel: UILabel!
    @IBOutlet weak var workoutNumberLabel: UILabel!
    @IBOutlet weak var workoutNameLabel: UILabel!
    
    var userName : String?
    var userEmail : String?
    var userBmi : Double?
    var userHeight : Int?
    var userWeight : Int?
    
    var workoutCategoryName = ""
    var workoutName = ["Push-up", "Wall-sit", "Sit-up", "Jumping jacks", "Wall sit"]
    var workoutDuration = [30, 30, 30, 30, 30]
    var workoutCounter = 1
    
    var seconds = 30
    var timer : Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        workoutCategoryLabel.text = workoutCategoryName
        workoutNumberLabel.text = "Workout " + String(workoutCounter) + " of " + String(workoutName.count)
        workoutNameLabel.text = String(workoutName[workoutCounter - 1])
        
        timerLabel.text = "\(seconds)"
        // start the timer
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector:#selector(self.counter), userInfo: nil, repeats: true)
    }
    
    @objc func counter() {
        seconds -= 1
        timerLabel.text = "\(seconds)"
        if seconds == 0 {
            if timer != nil
            {
                timer?.invalidate()
                timer = nil
                
                // if counter is same as the number of workout, end workout
                if (workoutCounter == workoutName.count)
                {
                    performSegue(withIdentifier: "WorkoutSuccessSegue", sender: nil)
                }
                // increase the counter
                else
                {
                    workoutCounter = workoutCounter + 1
                    performSegue(withIdentifier: "WorkoutRestSegue", sender: nil)
                }
            }
        }
    }
    
    @IBAction func pauseButtonAction(_ sender: UIButton) {
        timer?.invalidate()
        performSegue(withIdentifier: "WorkoutPauseSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let newRemainingSeconds = seconds
        
        if segue.identifier == "WorkoutPauseSegue"
        {
            let destination = segue.destination as! WorkoutPausedViewController
            destination.remainingSeconds = newRemainingSeconds
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
        else if segue.identifier == "WorkoutRestSegue" {
            let destination = segue.destination as! WorkoutRestViewController
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
        else if segue.identifier == "WorkoutSuccessSegue" {
            let destination = segue.destination as! WorkoutSuccessViewController
            destination.workoutCategoryName = workoutCategoryName
            
            destination.userName = userName
            destination.userEmail = userEmail
            destination.userBmi = userBmi
            destination.userHeight = userHeight
            destination.userWeight = userWeight
        }
        
    }

}
