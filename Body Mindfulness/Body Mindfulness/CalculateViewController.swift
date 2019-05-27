//
//  CalculateViewController.swift
//  Body Mindfulness
//
//  Created by Martin Christian on 21/05/19.
//  Copyright © 2019 Martin Christian. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CalculateViewController : UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var userName : String?
    var userEmail : String?
    var userBmi : Double?
    var userHeight : Int?
    var userWeight : Int?
    
    @IBOutlet weak var heightTextField: UITextField!
    
    @IBOutlet weak var weightTextField: UITextField!
    
    @IBOutlet weak var bmiLabel: UILabel!
    
    @IBOutlet weak var bmiScaleTableView: UITableView!
    
    var bmiScaleName = ["Underweight", "Normal", "Overweight", "Obese", "Extremely Obese"]
    var bmiScaleNumber = ["< 18.5", "18.5 - 24.9", "25 - 29.9", "30 - 34.9", "35 <"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bmiScaleName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BmiScaleCell", for: indexPath)
        cell.textLabel?.text = bmiScaleName[indexPath.item]
        cell.detailTextLabel?.text = bmiScaleNumber[indexPath.item]
        return cell
    }
    
    func calculateBmi(weight: Double, height: Double) -> Double
    {
        return weight / ((height / 100) * (height / 100))
    }
    
    func updateData(email: String, weight: Int, height: Int, bmi: Double) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "email = %@", email)
        
        do
        {
            let test = try managedContext.fetch(fetchRequest)
            
            let objectUpdate = test[0] as! NSManagedObject
            
            objectUpdate.setValue(height, forKey: "height")
            objectUpdate.setValue(weight, forKey: "weight")
            objectUpdate.setValue(bmi, forKey: "bmi")
            
            do
            {
                try managedContext.save()
            }
            catch
            {
                print(error)
            }
        }
        catch
        {
            print(error)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bmiLabel.text = String(format: "%.1f", userBmi!)
        
        bmiScaleTableView.dataSource = self
        bmiScaleTableView.delegate = self
    }
    
    @IBAction func updateButtonAction(_ sender: UIButton) {
        
        if (heightTextField.text == "" || weightTextField.text == "")
        {
            let alert = UIAlertController(title: "Empty field", message: "Please fill in all the required field.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
        else
        {
            let updatedHeight = Double(heightTextField.text!)
            let updatedWeight = Double(weightTextField.text!)
            let updatedBmi = calculateBmi(weight: Double(updatedWeight!), height: Double(updatedHeight!))
            
            let updatedUserBmi = Double(updatedBmi)
            let updatedUserHeight = Int(updatedHeight!)
            let updatedUserWeight = Int(updatedWeight!)
            
            updateData(email: userEmail!, weight: updatedUserWeight, height: updatedUserHeight, bmi: updatedUserBmi)
            
            performSegue(withIdentifier: "UpdateInformationSegue", sender: nil)
        }
    }
    
    @IBAction func cancelButtonAction(_ sender: UIButton) {
        performSegue(withIdentifier: "UpdateCancelSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "UpdateInformationSegue"
        {
            let destination = segue.destination as! MainTabBarController
            
            let updatedUserWeight = Int(weightTextField.text!)
            let updatedUserHeight = Int(heightTextField.text!)
            let updatedUserBmi = calculateBmi(weight: Double(updatedUserWeight!), height: Double(updatedUserHeight!))
            
            destination.userName = userName
            destination.userEmail = userEmail
            destination.userBmi = updatedUserBmi
            destination.userHeight = updatedUserHeight
            destination.userWeight = updatedUserWeight
        }
        
        else if segue.identifier == "UpdateCancelSegue"
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
