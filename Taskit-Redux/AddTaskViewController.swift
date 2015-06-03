//
//  AddTaskViewController.swift
//  Taskit-Redux
//
//  Created by jim Veneskey on 6/2/15.
//  Copyright (c) 2015 Jim Veneskey. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController {

    var mainVC: ViewController!
    
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
        
        var task = TaskModel(task: taskTextField.text, subTask: subtaskTextField.text, date: dueDatePicker.date)
        
        // Add the new task to our array
        mainVC.taskArray.append(task)
        // dump this view controller - return to the main one
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    
    
}
