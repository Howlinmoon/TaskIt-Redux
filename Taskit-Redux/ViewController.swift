//
//  ViewController.swift
//  Taskit-Redux
//
//  Created by jim Veneskey on 5/27/15.
//  Copyright (c) 2015 Jim Veneskey. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var tableView: UITableView!
    
    
    var taskArray:[TaskModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //self.tableView.dataSource = self
        //self.tableView.delegate = self
        
        let date1 = Date.from(year: 2015, month: 1, day: 17)
        let date2 = Date.from(year: 2015, month: 5, day: 29)
        let date3 = Date.from(year: 2015, month: 5, day: 30)
        
        
        let task1 = TaskModel(task: "Study German", subTask: "Verbs", date: date1)
        let task2 = TaskModel(task: "Watch TV", subTask: "The Daily Show", date: date2)
        let task3 = TaskModel(task: "Eat", subTask: "A Barn Burger", date: date3)
        
        
        println(task2.task)
        println(task2.subTask)
        println(task2.date)
        
        
        taskArray = [task1, task2, task3]
        
        // force refresh of info in the tableview
        self.tableView.reloadData()
        
    }

    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.tableView.reloadData()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Called right before the new ViewController sends data to the screen
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // Which segue is this?
        println("segue identifier: \(segue.identifier)")
        if segue.identifier == "showTaskDetail" {
            println("showTaskDetail segue called")
            let detailVC: TaskDetailViewController = segue.destinationViewController as! TaskDetailViewController
            
            let indexPath = self.tableView.indexPathForSelectedRow()
            
            let thisTask = taskArray[indexPath!.row]
            
            println("thisTask: \(thisTask.task)")
            detailVC.detailTaskModel = thisTask
            detailVC.mainVC = self
            
            
        } else if segue.identifier == "showTaskAdd" {
            let addTaskVC:AddTaskViewController = segue.destinationViewController as! AddTaskViewController
            addTaskVC.mainVC = self
        }
        
    }
    
    // For adding a task
    @IBAction func addButtonTapped(sender: UIBarButtonItem) {
        
        self.performSegueWithIdentifier("showTaskAdd", sender: self)
        
    }
    
    
    
    // Method required by the UITableViewDataSource protocol we included
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return taskArray.count
        
    }
    
    // Method required by the UITableViewDataSource protocol we included
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        println("indexPath.section = \(indexPath.section), .row = \(indexPath.row)")
        
        var cell: TaskCell = tableView.dequeueReusableCellWithIdentifier("myCell") as! TaskCell
        
        let thisTask = taskArray[indexPath.row]
        cell.taskLabel.text        = thisTask.task
        cell.descriptionLabel.text = thisTask.subTask
        cell.dateLabel.text        = Date.toString(date: thisTask.date)

        return cell
    }
    
    // Method required by UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        println("You tapped on row: \(indexPath.row)")
        performSegueWithIdentifier("showTaskDetail", sender: self)
    }

}

