//
//  TaskDetailViewController.swift
//  Taskit-Redux
//
//  Created by Jim Veneskey on 5/30/15.
//  Copyright (c) 2015 Jim Veneskey. All rights reserved.
//

import UIKit

class TaskDetailViewController: UIViewController {

    var detailTaskModel: TaskModel!
    var mainVC: ViewController!
    
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var subtaskTextField: UITextField!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        println("From TaskDetailVC: \(self.detailTaskModel.task)")
        
        self.taskTextField.text = detailTaskModel.task
        self.subtaskTextField.text = detailTaskModel.subTask
        self.dueDatePicker.date = detailTaskModel.date
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButtonTapped(sender: UIBarButtonItem) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }

    // Return to the main view controller
    @IBAction func doneBarButtonItemPressed(sender: UIBarButtonItem) {
        
        self.navigationController?.popViewControllerAnimated(true)
        
    }

    
    
}
