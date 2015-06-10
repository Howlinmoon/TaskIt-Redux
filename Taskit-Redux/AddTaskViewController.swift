//
//  AddTaskViewController.swift
//  Taskit-Redux
//
//  Created by jim Veneskey on 6/2/15.
//  Copyright (c) 2015 Jim Veneskey. All rights reserved.
//

import UIKit
import CoreData

class AddTaskViewController: UIViewController {

    
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var subtaskTextField: UITextField!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // This view controller is brought into action modally...
    @IBAction func cancelButtonTapped(sender: UIButton) {
        
        // We have to tell this view controller to dismiss itself
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }

    // Adding a task via the add task button
    @IBAction func addTaskButtonTapped(sender: UIButton) {
        

        // UIApplication represents the ENTIRE application with a property named sharedApplication
        let appDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        
        let managedObjectContext = appDelegate.managedObjectContext
        
        let entityDescription = NSEntityDescription.entityForName("TaskModel", inManagedObjectContext: managedObjectContext!)
        
        
        let task = TaskModel(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext!)
        
        task.task = taskTextField.text
        task.subtask = subtaskTextField.text
        task.date = dueDatePicker.date
        task.completed = false
        

        appDelegate.saveContext()
        
        var request = NSFetchRequest(entityName: "TaskModel")
        var error:NSError? = nil
        
        var results:NSArray = managedObjectContext!.executeFetchRequest(request, error: &error)!
        
        for res in results {
            println(res)
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    
    
}
