//
//  WorkoutDetailsViewController.swift
//  Body Mindfulness
//
//  Created by Martin Christian on 19/05/19.
//  Copyright © 2019 Martin Christian. All rights reserved.
//

import Foundation
import UIKit

class WorkoutDetailsViewController : UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var workoutCategoryLabel: UILabel!
    @IBOutlet weak var workoutDetailsTableView: UITableView!
    
    var userName : String?
    var userEmail : String?
    var userBmi : Double?
    var userHeight : Int?
    var userWeight : Int?
    
    var workoutCategoryName = ""
    var workoutName = ["Push-up", "Wall-sit", "Sit-up", "Jumping jacks", "Wall sit"]
    var workoutDuration = [30, 30, 30, 30, 30]
    var workoutCounter = 1
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workoutName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkoutDetailsCell", for: indexPath)
        cell.textLabel?.text = workoutName[indexPath.item]
        cell.detailTextLabel?.text = String(workoutDuration[indexPath.item])
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        workoutCategoryLabel.text = workoutCategoryName
        workoutDetailsTableView.delegate = self
        workoutDetailsTableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        workoutDetailsTableView.reloadData()
    }
    
    @IBAction func startButtonAction(_ sender: UIButton) {
        performSegue(withIdentifier: "WorkoutStartSegue", sender: nil)
    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        performSegue(withIdentifier: "WorkoutBackSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let workoutCategoryLabelName = workoutCategoryName
        
        if segue.identifier == "WorkoutStartSegue"
        {
            let destination = segue.destination as! WorkoutStartViewController
            destination.workoutName = workoutName
            destination.workoutDuration = workoutDuration
            destination.workoutCategoryName = workoutCategoryLabelName
            destination.workoutCounter = workoutCounter
            
            destination.userName = userName
            destination.userEmail = userEmail
            destination.userBmi = userBmi
            destination.userHeight = userHeight
            destination.userWeight = userWeight
        }
        else if segue.identifier == "WorkoutBackSegue"
        {
            let destination = segue.destination as! MainTabBarController
            destination.selectedTabBar = 1
            
            destination.userName = userName
            destination.userEmail = userEmail
            destination.userBmi = userBmi
            destination.userHeight = userHeight
            destination.userWeight = userWeight
        }
        
    }
    
}
