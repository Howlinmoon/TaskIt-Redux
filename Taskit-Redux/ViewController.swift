//
//  ViewController.swift
//  Taskit-Redux
//
//  Created by jim Veneskey on 5/27/15.
//  Copyright (c) 2015 Jim Veneskey. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {

    
    @IBOutlet weak var tableView: UITableView!
    
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var fetchedResultsController:NSFetchedResultsController = NSFetchedResultsController()
    
    //var baseArray: [[TaskModel]] = []
    
    //var taskArray:[TaskModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        fetchedResultsController = getFetchResultsController()
        fetchedResultsController.delegate = self
        fetchedResultsController.performFetch(nil)
        
        /* Pre-Core Data Refactoring
        
        //self.tableView.dataSource = self
        //self.tableView.delegate = self
        
        let date1 = Date.from(year: 2015, month: 1, day: 17)
        let date2 = Date.from(year: 2015, month: 5, day: 29)
        let date3 = Date.from(year: 2015, month: 5, day: 30)
        
        
        let task1 = TaskModel(task: "Study German", subTask: "Verbs", date: date1, completed: false)
        let task2 = TaskModel(task: "Watch TV", subTask: "The Daily Show", date: date2, completed: false)
        let task3 = TaskModel(task: "Eat", subTask: "A Barn Burger", date: date3, completed: false)
        
        
        println(task2.task)
        println(task2.subTask)
        println(task2.date)
        
        
        let taskArray = [task1, task2, task3]
        
        var completedArray = [TaskModel(task: "Code", subTask: "Task Project", date: date2, completed: true)]
        
        baseArray = [taskArray, completedArray]
        
        
        // force refresh of info in the tableview
        self.tableView.reloadData()

    */
        
        
        
    }

    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
/*
        // Traditional style using an embedded function
        // Returns True if taskOne is before taskTwo
        func sortByDate(taskOne: TaskModel, taskTwo: TaskModel) -> Bool {
            // which date comes first?
            return taskOne.date.timeIntervalSince1970 < taskTwo.date.timeIntervalSince1970
        }

        taskArray = taskArray.sorted(sortByDate)
*/
        
        // Same type of sorting using an enclosure
        // only sorting the first array - the incomplete tasks one
        baseArray[0] = baseArray[0].sorted {
            (taskOne:TaskModel, taskTwo:TaskModel) -> Bool in
            // comparison logic from above
            return taskOne.date.timeIntervalSince1970 < taskTwo.date.timeIntervalSince1970
        }
        
        
        
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
            
            let thisTask = baseArray[indexPath!.section][indexPath!.row]
            
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
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        // return baseArray.count
        return fetchedResultsController.sections!.count
    }
    
    
    // Method required by the UITableViewDataSource protocol we included
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        //return baseArray[section].count
        return fetchedResultsController.sections![section].numberOfObjects
        
    }
    
    // Method required by the UITableViewDataSource protocol we included
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        println("indexPath.section = \(indexPath.section), .row = \(indexPath.row)")
        
        var cell: TaskCell = tableView.dequeueReusableCellWithIdentifier("myCell") as! TaskCell
        
        //let thisTask = baseArray[indexPath.section][indexPath.row]
        let thisTask = fetchedResultsController.objectAtIndexPath(indexPath) as! TaskModel
        cell.taskLabel.text        = thisTask.task
        cell.descriptionLabel.text = thisTask.subtask
        cell.dateLabel.text        = Date.toString(date: thisTask.date)

        return cell
    }
    
    // Method required by UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        println("You tapped on row: \(indexPath.row)")
        performSegueWithIdentifier("showTaskDetail", sender: self)
    }
    
    
    
    // Helper functions
    // Section headers, size and title
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 {
            return "To Do"
        } else {
            return "Completed"
        }
        
    }
    
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        //let thisTask = baseArray[indexPath.section][indexPath.row]
        let thisTask = fetchedResultsController.objectAtIndexPath(indexPath) as! TaskModel
        
        if indexPath.section == 0 {
            
            // swiped from section 0 - add to section 1 - completed
            /*
            var newTask = TaskModel(task: thisTask.task, subTask: thisTask.subtask, date: thisTask.date, completed: true)
            baseArray[1].append(newTask)
            */
            
            thisTask.completed = true
            
        } else {
            // swiped from section 1 - add to section 0 - uncompleted
            /*
            var newTask = TaskModel(task: thisTask.task, subTask: thisTask.subtask, date: thisTask.date, completed: false)
            baseArray[0].append(newTask)
            */
            
            thisTask.completed = false
        }
        
        (UIApplication.sharedApplication().delegate as! AppDelegate).saveContext()
        
        /*
        baseArray[indexPath.section].removeAtIndex(indexPath.row)
        tableView.reloadData()
        */
    }
    
    // NSFetchedResultsControllerDelegate
    // automatically called if the data has changed
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.reloadData()
    }
    
    
    // Helper
    
    func taskFetchRequest() -> NSFetchRequest {
        let fetchRequest = NSFetchRequest(entityName: "TaskModel")
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]

        return fetchRequest
    }
    
    func getFetchResultsController() -> NSFetchedResultsController {
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: taskFetchRequest(), managedObjectContext: managedObjectContext!, sectionNameKeyPath: nil, cacheName: nil)

        return fetchedResultsController
    }

}

