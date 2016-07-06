//
//  Event.swift
//  litterBoxTracker
//
//  Created by Stu Almeleh on 7/6/16.
//  Copyright © 2016 Stu Almeleh. All rights reserved.
//

import Foundation
import CoreData

class Event : NSManagedObject {
    
    @NSManaged var timeStamp: NSDate
    
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    
    init(context: NSManagedObjectContext) {
        let entity = NSEntityDescription.entityForName("Event", inManagedObjectContext: context)!
        super.init(entity: entity, insertIntoManagedObjectContext: context)
        
        timeStamp = NSDate()
    }
}