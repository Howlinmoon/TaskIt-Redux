//
//  TaskModel.swift
//  Taskit-Redux
//
//  Created by jim Veneskey on 6/8/15.
//  Copyright (c) 2015 Jim Veneskey. All rights reserved.
//

import Foundation
import CoreData

// create an entity bridge for Objective C
@objc(TaskModel)

class TaskModel: NSManagedObject {

    @NSManaged var completed: NSNumber
    @NSManaged var date: NSDate
    @NSManaged var subtask: String
    @NSManaged var task: String

}
