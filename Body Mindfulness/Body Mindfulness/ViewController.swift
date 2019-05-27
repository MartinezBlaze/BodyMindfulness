//
//  ViewController.swift
//  Body Mindfulness
//
//  Created by Martin Christian on 18/05/19.
//  Copyright © 2019 Martin Christian. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    // determine the data to be passed through the Segue
    var userName : String?
    var userEmail : String?
    var userBmi : Double?
    var userHeight : Int?
    var userWeight : Int?
    
    
    func login(email: String, password: String) {
        // FETCHING DATA
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let userFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        
        userFetch.predicate = NSPredicate(format: "email = %@", email)
        
        do {
            let userFound = false
            let result = try managedContext.fetch(userFetch)
            for data in result as! [NSManagedObject] {
                if (data.value(forKey: "password") as? String == password)
                {
                    retrieveData(email: email, password: password)
                    performSegue(withIdentifier: "SignInSegue", sender: nil)
                    return
                }
            }
            if userFound == false
            {
                let alert = UIAlertController(title: "Cannot Log In", message: "Invalid username / password.", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
            }
        } catch {
            print("Error")
        }
    }
    
    func retrieveData(email: String, password: String) {
        // FETCHING DATA
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let userFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        
        userFetch.predicate = NSPredicate(format: "email = %@", email)
        
        do {
            let result = try managedContext.fetch(userFetch)
            for data in result as! [NSManagedObject] {
                if (data.value(forKey: "password") as? String == password)
                {
                    userName = data.value(forKey: "name") as? String
                    userEmail = data.value(forKey: "email")  as? String
                    userBmi = data.value(forKey: "bmi") as? Double
                    userHeight = data.value(forKey: "height") as? Int
                    userWeight = data.value(forKey: "weight") as? Int
                    return
                }
            }
        } catch {
            print("Error")
        }
    }
    
    func deleteData(email: String) {
        // DELETING DATA
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let userFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        userFetch.predicate = NSPredicate(format: "email = %@", email)
        
        do
        {
            let test = try managedContext.fetch(userFetch)
            
            let objectToDelete = test[0] as! NSManagedObject
            managedContext.delete(objectToDelete)
            
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
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func signInButtonAction(_ sender: UIButton) {
        let emailValue = emailTextField.text
        let passwordValue = passwordTextField.text
        
        if (emailValue == "" || passwordValue == "")
        {
            let alert = UIAlertController(title: "Empty field", message: "Please fill in all the required field.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
        else
        {
            login(email: emailValue!, password: passwordValue!)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SignInSegue"
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

