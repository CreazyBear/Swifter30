//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by 熊伟 on 2017/7/8.
//  Copyright © 2017年 Bear. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    var people: [NSManagedObject] = []
    
    lazy var tableView : UITableView = {
        let tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "id")
        tableView.backgroundColor = UIColor.white
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = UIColor.white
        title = "CoreDataDemo"
        
        navigationItem.leftBarButtonItem = editButtonItem
        let addButton = UIBarButtonItem.init(title: "Add", style: .plain, target: self, action: #selector(self.addName(_:)))
        navigationItem.rightBarButtonItem = addButton
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        self.fetchCoreData(managedContext)
        view.addSubview(tableView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func fetchCoreData(_ managedContext: NSManagedObjectContext) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        
        do {
            let results = try managedContext.fetch(fetchRequest)
            people = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
    }
    
    func addName(_ sender: AnyObject) {
        let alert = UIAlertController(title: "New Name", message: "Add a new name", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: {(action: UIAlertAction) -> Void in
            let textField = alert.textFields!.first
            self.saveName(textField!.text!)
            self.tableView.reloadData()
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: {(action: UIAlertAction) -> Void in
        })
        
        alert.addTextField {
            (textField: UITextField) -> Void in
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func saveName(_ name: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let entity =  NSEntityDescription.entity(forEntityName: "Person",
                                                 in:managedContext)
        let person = NSManagedObject(entity: entity!,
                                     insertInto: managedContext)
        
        person.setValue(name, forKey: "name")
        
        do {
            try managedContext.save()
            people.append(person)
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
}

extension ViewController : UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier: String = "id"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        
        let person = people[indexPath.row]
        cell.textLabel!.text = person.value(forKey: "name") as? String
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            // remove the deleted item from the model
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let managedContext = appDelegate.managedObjectContext
            managedContext.delete(people[indexPath.row] as NSManagedObject)
            do {
                try managedContext.save()
                people.remove(at: indexPath.row)
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            }
            
            //tableView.reloadData()
            // remove the deleted item from the `UITableView`
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        default:
            return
            
        }
    }
}
