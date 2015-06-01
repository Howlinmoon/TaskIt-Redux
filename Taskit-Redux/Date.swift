//
//  Date.swift
//  Taskit-Redux
//
//  Created by jim Veneskey on 6/1/15.
//  Copyright (c) 2015 Jim Veneskey. All rights reserved.
//

import Foundation

class Date {
    
    class func from (#year:Int, month:Int, day: Int) -> NSDate {
        
        var components = NSDateComponents()
        components.year = year
        components.month = month
        components.day = day
        
        //var gregorianCalendar = NSCalendarIdentifierGregorian
        
        var gregorianCalendar = NSCalendar(identifier: NSCalendarIdentifierGregorian)
        
        var date = gregorianCalendar!.dateFromComponents(components)
        
        return date!
    }
    
    
}