//
//  ProfileViewController.swift
//  Body Mindfulness
//
//  Created by Martin Christian on 18/05/19.
//  Copyright © 2019 Martin Christian. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ProfileViewController : UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workoutNameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkoutHistoryCell", for: indexPath)
        cell.textLabel?.text = workoutNameArray[indexPath.item]
        cell.detailTextLabel?.text = workoutDateArray[indexPath.item]
        return cell
    }

    func retrieveData(email: String) {
        // FETCHING DATA
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let workoutHistoryFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "WorkoutHistory")
        
        workoutHistoryFetch.predicate = NSPredicate(format: "email = %@", email)
        workoutHistoryFetch.sortDescriptors = [NSSortDescriptor.init(key: "date", ascending: false)]
        
        do {
            let result = try managedContext.fetch(workoutHistoryFetch)
            for data in result as! [NSManagedObject] {
                
                let workoutDate = data.value(forKey: "date")
                let workoutName = data.value(forKey: "workoutName")
                
                let formatter = DateFormatter()
                formatter.dateFormat = "dd/MM/yyyy hh:mm"
                let dateString = formatter.string(from: workoutDate as! Date)
                
                workoutDateArray.append(dateString)
                workoutNameArray.append(workoutName as! String)
            }
        } catch {
            print("Error")
        }
    }
    
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var userBmiLabel: UILabel!
    
    @IBOutlet weak var userHeightLabel: UILabel!
    
    @IBOutlet weak var userWeightLabel: UILabel!
    
    @IBOutlet weak var workoutHistoryTableView: UITableView!
    
    var userName : String?
    var userEmail : String?
    var userBmi : Double?
    var userHeight : Int?
    var userWeight : Int?
    
    var workoutDateArray = [String]()
    var workoutNameArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        retrieveData(email: userEmail!)
        
        workoutHistoryTableView.delegate = self
        workoutHistoryTableView.dataSource = self
        
        userNameLabel.text = userName
        userBmiLabel.text = String(format: "%.1f", userBmi!)
        userHeightLabel.text = "\(userHeight ?? 0)"
        userWeightLabel.text = "\(userWeight ?? 0)"
        
    }
    
    
    @IBAction func signOutAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func calculateButtonAction(_ sender: UIButton) {
        performSegue(withIdentifier: "CalculateSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "CalculateSegue"
        {
            let destination = segue.destination as! CalculateViewController
            
            destination.userName = userName
            destination.userEmail = userEmail
            destination.userBmi = userBmi
            destination.userHeight = userHeight
            destination.userWeight = userWeight
        }
    }
    
}
