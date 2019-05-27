//
//  WorkoutSuccessViewController.swift
//  Body Mindfulness
//
//  Created by Martin Christian on 21/05/19.
//  Copyright © 2019 Martin Christian. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class WorkoutSuccessViewController : UIViewController {
    
    var userName : String?
    var userEmail : String?
    var userBmi : Double?
    var userHeight : Int?
    var userWeight : Int?
    
    var workoutCategoryName : String?
    
    @IBOutlet weak var workoutCategoryNameLabel: UILabel!
    
    func createData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let workoutHistoryEntity = NSEntityDescription.entity(forEntityName: "WorkoutHistory", in: managedContext)!
        
        let workoutHistory = NSManagedObject(entity: workoutHistoryEntity, insertInto: managedContext)
        workoutHistory.setValue(userEmail, forKey: "email")
        workoutHistory.setValue(workoutCategoryName, forKey: "workoutName")
        
        let currentDateTime = Date()
        workoutHistory.setValue(currentDateTime, forKey: "date")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        workoutCategoryNameLabel.text = workoutCategoryName! + " completed!"
    }
    
    @IBAction func backToPersonalAction(_ sender: UIButton) {
        createData()
        performSegue(withIdentifier: "WorkoutCompletedSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "WorkoutCompletedSegue"
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
