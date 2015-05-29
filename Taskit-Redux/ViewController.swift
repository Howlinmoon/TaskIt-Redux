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
    
    
    var taskArray:[Dictionary<String, String>] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //self.tableView.dataSource = self
        //self.tableView.delegate = self
        
        let task1:Dictionary<String, String> = ["task": "Study German", "subtask": "Verbs", "date": "01/17/2015"]
        let task2:Dictionary<String, String> = ["task": "Watch TV", "subtask": "The Daily Show", "date": "05/29/2015"]
        let task3:Dictionary<String, String> = ["task": "Eat", "subtask": "A Barn Burger", "date": "05/30/2015"]
        
        
        println(task2["task"])
        println(task2["subtask"])
        println(task2["date"])
        
        
        taskArray = [task1, task2, task3]
        
        // force refresh of info in the tableview
        self.tableView.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Method required by the UITableViewDataSource protocol we included
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return taskArray.count
        
    }
    
    // Method required by the UITableViewDataSource protocol we included
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        println("indexPath.section = \(indexPath.section), .row = \(indexPath.row)")
        
        var cell: TaskCell = tableView.dequeueReusableCellWithIdentifier("myCell") as! TaskCell
        
        let taskDict = taskArray[indexPath.row]
        cell.taskLabel.text = taskDict["task"]
        cell.descriptionLabel.text = taskDict["subtask"]
        cell.dateLabel.text = taskDict["date"]
        
        
        
        return cell
    }
    
    // Method required by UITableViewDelegate
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        
    }

}

