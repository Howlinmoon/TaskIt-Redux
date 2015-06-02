//
//  AddTaskViewController.swift
//  Taskit-Redux
//
//  Created by jim Veneskey on 6/2/15.
//  Copyright (c) 2015 Jim Veneskey. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController {

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

    
    
}
