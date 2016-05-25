//
//  ViewController.swift
//  litterBoxTracker
//
//  Created by Stu Almeleh on 5/24/16.
//  Copyright © 2016 Stu Almeleh. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var displayTimeLabel: UILabel!
    
    var startTime = NSTimeInterval()
    var timer = NSTimer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image = UIImage(named: "test")
    }


    @IBAction func startButtonPressed(sender: AnyObject) {
        if (!timer.valid) {
            let aSelector : Selector = "updateTime"
            timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: aSelector, userInfo: nil, repeats: true)
            startTime = NSDate.timeIntervalSinceReferenceDate()
        }
    }

    
    func updateTime() {
        let currentTime = NSDate.timeIntervalSinceReferenceDate()

        var elapsedTime: NSTimeInterval = currentTime - startTime
        
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
        
        if (seconds == 10) {
            launchAlertController("10 seconds")
        }
        
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

