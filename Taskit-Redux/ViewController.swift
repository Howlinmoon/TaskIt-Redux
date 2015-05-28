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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //self.tableView.dataSource = self
        //self.tableView.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Method required by the UITableViewDataSource protocol we included
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        

        
        return 5
        
    }
    
    // Method required by the UITableViewDataSource protocol we included
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        println("indexPath.section = \(indexPath.section), .row = \(indexPath.row)")
        
        var cell: TaskCell = tableView.dequeueReusableCellWithIdentifier("myCell") as! TaskCell
        
        cell.taskLabel.text = "Study German - \(indexPath.row)"
        cell.descriptionLabel.text = "Verbs in past and present"
        cell.dateLabel.text = "01/17/2015"
        
        
        
        return cell
    }
    
    // Method required by UITableViewDelegate
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        
    }

}

