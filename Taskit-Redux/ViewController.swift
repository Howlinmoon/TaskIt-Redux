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
        
        
        let task1 = TaskModel(task: "Study German", subTask: "Verbs", date: "01/17/2015")
        let task2 = TaskModel(task: "Watch TV", subTask: "The Daily Show", date: "05/29/2015")
        let task3 = TaskModel(task: "Eat", subTask: "A Barn Burger", date: "05/30/2015")
        
        
        println(task2.task)
        println(task2.subTask)
        println(task2.date)
        
        
        taskArray = [task1, task2, task3]
        
        // force refresh of info in the tableview
        self.tableView.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
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
        cell.dateLabel.text        = thisTask.date

        return cell
    }
    
    // Method required by UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        println("You tapped on row: \(indexPath.row)")
        performSegueWithIdentifier("showTaskDetail", sender: self)
    }

}

