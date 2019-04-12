//
//  ViewController.swift
//  FirstCoreData
//
//  Created by Bill Tanthowi Jauhari on 11/04/19.
//  Copyright © 2019 Apple Developer Academy. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func create(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let userEntity = NSEntityDescription.entity(forEntityName: "User", in: managedContext)!
        
        for i in 1...5{
            let user = NSManagedObject(entity: userEntity, insertInto: managedContext)
            user.setValue("bill\(i)", forKeyPath: "username")
            user.setValue("bill\(i)@icloud.com", forKey: "email")
            user.setValue("secret\(i)", forKey: "password")
        }
        
        do{
            try managedContext.save()
        }catch let error as NSError {
            print("Could not save \(error) \(error.userInfo)")
        }
        
        
    }
    
    func retriveData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let userEntity = NSEntityDescription.entity(forEntityName: "User", in: managedContext)!
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject]{
                print(data.value(forKey: "username") as! String)
            }
        } catch {
            print("failed")
        }
    }
    
    func deleteData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "User")
        
        fetchRequest.predicate = NSPredicate(format: "username = %@", "jauhari")
        
        do{
            let test = try managedContext.fetch(fetchRequest)
            
            let objectUpdate = test[0] as! NSManagedObject
            objectUpdate.setValue("Tanthowi", forKey: "username")
            objectUpdate.setValue("tanthowi@icloud.com", forKey: "email")
            objectUpdate.setValue("password", forKey: "tanthowi")
            
            do{
                try managedContext.save()
            }catch{
                print(error)
            }
        }catch{
            print(error)
        }
    }
    
}

