//
//  ViewController.swift
//  litterBoxTracker
//
//  Created by Stu Almeleh on 5/24/16.
//  Copyright © 2016 Stu Almeleh. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var displayTimeLabel: UILabel!
    
    var objects: [Event]!

    
    var startTime = NSTimeInterval()
    var timer = NSTimer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        objects = fetchAllEvents()
        
        imageView.image = UIImage(named: "test")
    }

    
    //MARK: Core Data
    lazy var sharedContext: NSManagedObjectContext = {
        return CoreDataStackManager.sharedInstance().managedObjectContext
    }()
    
    func fetchAllEvents() -> [Event] {
        // Create the Fetch Request
        let fetchRequest = NSFetchRequest(entityName: "Event")
        
        // Execute the Fetch Request
        do {
            return try sharedContext.executeFetchRequest(fetchRequest) as! [Event]
        } catch _ {
            return [Event]()
        }
    }
    
    func insertNewObject(sender: AnyObject) {
        objects.insert(Event(context: sharedContext), atIndex: 0)
        //let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        //self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        
        CoreDataStackManager.sharedInstance().saveContext()
    }
    
    
    
    

    @IBAction func startButtonPressed(sender: AnyObject) {
        if (!timer.valid) {
            objects.insert(Event(context: sharedContext), atIndex: 0)
            let indexPath = NSIndexPath(forRow: 0, inSection: 0)
            self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            
            CoreDataStackManager.sharedInstance().saveContext()
            
            
            let aSelector : Selector = "updateTime"
            timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: aSelector, userInfo: nil, repeats: true)
            startTime = NSDate.timeIntervalSinceReferenceDate()
        }
    }

    
    func updateTime() {
        let currentTime = NSDate.timeIntervalSinceReferenceDate()

        var elapsedTime: NSTimeInterval = currentTime - startTime
        
        //
        ///
        ////add logic for updating the imageView based on elapsed time
        ///
        //
        
        let days = UInt8(elapsedTime / 86400.0)
        elapsedTime -= (NSTimeInterval(days) * 86400.0)
        
        let hours = UInt8(elapsedTime / 3600.0)
        elapsedTime -= (NSTimeInterval(hours) * 3600)
        
        let minutes = UInt8(elapsedTime / 60.0)
        elapsedTime -= (NSTimeInterval(minutes) * 60)
        
        let seconds = UInt8(elapsedTime)
        elapsedTime -= NSTimeInterval(seconds)

        
        //add the leading zero and convert to strings
        let strDays = String(format: "%02d", days)
        let strHours = String(format: "%02d", hours)
        let strMinutes = String(format: "%02d", minutes)
        let strSeconds = String(format: "%02d", seconds)
        
        //concatenate times for the UILabel
        displayTimeLabel.text = "\(strDays):\(strHours):\(strMinutes):\(strSeconds)"

        
    }
    
    
    
    // MARK: - Table View
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let object = objects[indexPath.row] as Event
        cell.textLabel!.text = object.timeStamp.description
        return cell
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    
    
    
    
    
    //MARK: launchAlertController
    /* shows alert view with error */
    func launchAlertController(error: String) {
        let alertController = UIAlertController(title: "", message: error, preferredStyle: .Alert)
        
        let OKAction = UIAlertAction(title: "Dismiss", style: .Default) { (action) in
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        alertController.addAction(OKAction)
        
        self.presentViewController(alertController, animated: true) {
            
        }
    }
    
    
    
    
    
}

