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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        fetchedResultsController = getFetchResultsController()
        fetchedResultsController.delegate = self
        fetchedResultsController.performFetch(nil)
        
    }

    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        

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
            
            //let thisTask = baseArray[indexPath!.section][indexPath!.row]
            
            let thisTask = fetchedResultsController.objectAtIndexPath(indexPath!) as! TaskModel
            
            println("thisTask: \(thisTask.task)")
            detailVC.detailTaskModel = thisTask
            //detailVC.mainVC = self
            
            
        } else if segue.identifier == "showTaskAdd" {
            let addTaskVC:AddTaskViewController = segue.destinationViewController as! AddTaskViewController
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

            
            thisTask.completed = true
            
        } else {

            thisTask.completed = false
        }
        
        (UIApplication.sharedApplication().delegate as! AppDelegate).saveContext()

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
        
        
        let completedDescriptor = NSSortDescriptor(key: "completed", ascending: true)
        
        fetchRequest.sortDescriptors = [completedDescriptor, sortDescriptor]

        return fetchRequest
    }
    
    func getFetchResultsController() -> NSFetchedResultsController {
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: taskFetchRequest(), managedObjectContext: managedObjectContext!, sectionNameKeyPath: "completed", cacheName: nil)

        return fetchedResultsController
    }

}

