//
//  RemoveAccountViewController.swift
//  Body Mindfulness
//
//  Created by Martin Christian on 21/05/19.
//  Copyright © 2019 Martin Christian. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class RemoveAccountViewController : UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    func deleteData(email: String, password: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        // DELETE USER
        let managedContext = appDelegate.persistentContainer.viewContext

        var fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "email = %@", email)

        do
        {
            let test = try managedContext.fetch(fetchRequest)
            
            if (test.count > 0)
            {
                let objectToDelete = test[0] as! NSManagedObject
                
                // check if the email and the password is the same
                if (objectToDelete.value(forKey: "password") as? String == password)
                {
                    managedContext.delete(objectToDelete)
                }
                else
                {
                    let alert = UIAlertController(title: "Account not Found", message: "The account you are trying to delete does not exist.", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(ok)
                    self.present(alert, animated: true, completion: nil)
                }
                
                do {
                    try managedContext.save()
                }
                catch
                {
                    print(error)
                }
                
                // DELETE WORKOUT HISTORY
                fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "WorkoutHistory")
                fetchRequest.predicate = NSPredicate(format: "email = %@", email)
                
                do
                {
                    let test = try managedContext.fetch(fetchRequest)
                    
                    if (test.count > 0)
                    {
                        let objectToDelete = test[0] as! NSManagedObject
                        
                        managedContext.delete(objectToDelete)
                        performSegue(withIdentifier: "RemoveAccountSegue", sender: nil)
                    }
                    
                    do {
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
            else
            {
                let alert = UIAlertController(title: "Account not Found", message: "The account you are trying to delete does not exist.", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
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
    
    @IBAction func removeButtonAction(_ sender: UIButton) {
        if (emailTextField.text == "" || passwordTextField.text == "")
        {
            let alert = UIAlertController(title: "Empty field", message: "Please fill all the required field", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
        else
        {
            deleteData(email: emailTextField.text!, password: passwordTextField.text!)
        }
    }
    
}
