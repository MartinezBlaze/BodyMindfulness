//
//  RegisterViewController.swift
//  Body Mindfulness
//
//  Created by Martin Christian on 21/05/19.
//  Copyright © 2019 Martin Christian. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class RegisterViewController: UIViewController {
    
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var heightTextField: UITextField!
    
    @IBOutlet weak var weightTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var dateOfBirthDatePicker: UIDatePicker!
    
    func calculateBmi(weight: Double, height: Double) -> Double
    {
        return weight / ((height / 100) * (height / 100))
    }
    
    func createData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let userFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        userFetch.predicate = NSPredicate(format: "email = %@", emailTextField.text!)
        
        
        let userEntity = NSEntityDescription.entity(forEntityName: "User", in: managedContext)!
        
        let user = NSManagedObject(entity: userEntity, insertInto: managedContext)
        
        do {
            var userFound = false
            let result = try managedContext.fetch(userFetch)
            for data in result as! [NSManagedObject] {
                if (data.value(forKey: "email") as? String == emailTextField.text)
                {
                    userFound = true
                }
            }
            
            if userFound == false
            {
                user.setValue(nameTextField.text, forKeyPath: "name")
                user.setValue(emailTextField.text, forKey: "email")
                user.setValue(passwordTextField.text, forKey: "password")
                
                let userDateOfBirth = dateOfBirthDatePicker.date
                user.setValue(userDateOfBirth, forKey: "dateOfBirth")
                
                let userWeight = Double(weightTextField.text!)
                let userHeight = Double(heightTextField.text!)
                
                user.setValue(userWeight, forKey: "weight")
                user.setValue(userHeight, forKey: "height")
                
                // calculate the user's BMI
                let updatedBmi = calculateBmi(weight: Double(userWeight!), height: Double(userHeight!))
                user.setValue(updatedBmi, forKey: "bmi")
                
            }
            else
            {
                let alert = UIAlertController(title: "User already exists", message: "The user already exists in the database.", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
            }
        } catch {
            print("Error")
        }
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    @IBAction func registerButtonAction(_ sender: UIButton) {
        if (nameTextField.text == "" || emailTextField.text == "" || passwordTextField.text == "" || heightTextField.text == "" || weightTextField.text == "")
        {
            let alert = UIAlertController(title: "Empty field", message: "Please fill in all the required field.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
        else
        {
            createData()
            performSegue(withIdentifier: "RegisterCompletedSegue", sender: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
