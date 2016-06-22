//
//  ActivityViewController.swift
//  SmartStyle
//
//  Created by Utku Dora on 02/12/15.
//  Copyright © 2015 UDO. All rights reserved.
//

import UIKit
import CoreMotion
class ActivityViewController: UIViewController {

    @IBOutlet weak var activityState: UILabel!
    @IBOutlet weak var steps: UILabel!
    @IBOutlet weak var activityCounter: UILabel!
    @IBOutlet weak var activityName: UILabel!
    
    @IBOutlet weak var SitUpButtonName: UIButton!
    @IBOutlet weak var PullUpButtonName: UIButton!
    let manager = CMMotionManager()
    var doingSitUps = false
    var doingPullUps = false
    var days:[String] = []
    var stepsTaken:[Int] = []
    var sitUpCount = 0
    var pullUpCount = 0
    @IBOutlet weak var stateImageView: UIImageView!
    let activityManager = CMMotionActivityManager()
    let pedoMeter = CMPedometer()
    
    
    func magnitudeFromAttitude(attitude: CMAttitude) -> Double {
        return sqrt(pow(attitude.roll, 2) + pow(attitude.yaw, 2) + pow(attitude.pitch, 2))
    }
   

    @IBAction func PullUpAction(sender: AnyObject) {
        
        if self.doingPullUps{
        self.activityName.hidden = false
        self.SitUpButtonName.hidden = false
        self.doingPullUps = false
        self.PullUpButtonName.setTitle("Start PullUps", forState: UIControlState.Normal)
        self.manager.stopDeviceMotionUpdates()
            
        
        }
        
        else if !self.doingPullUps{
            
            
            self.doingPullUps = true
            self.SitUpButtonName.hidden = true
            self.PullUpButtonName.setTitle("Stop PullUps", forState: UIControlState.Normal)
            self.activityName.hidden = false
            self.activityName.text = "PullUps :"
            viewDidLoad()
            
        
        }
        
    }
    
    @IBAction func SitupsAction(sender: AnyObject) {
        
        if self.doingSitUps{
            
            //self.PullUpButtonName.hidden = false
            
            self.PullUpButtonName.hidden = false
            self.doingSitUps = false
            self.SitUpButtonName.setTitle("Start SitUps", forState: UIControlState.Normal)
        self.manager.stopDeviceMotionUpdates()
            
            self.sitUpCount = 0
        
        }
        
        
       else if !self.doingSitUps{
      
         self.doingSitUps = true
            self.PullUpButtonName.hidden = true
            self.SitUpButtonName.setTitle("Stop SitUps", forState: UIControlState.Normal)
            self.activityName.text = "SitUps :"
            viewDidLoad()
        
        
        }
    }
   
    override func viewDidLoad() {
       // self.activityName.hidden = true
       
        super.viewDidLoad()
        
        let cal = NSCalendar.currentCalendar()
       let date = NSDate()
        
        let comps = cal.components([.Year, .Month, .Day, .Hour, .Minute, .Second], fromDate: date)
        
        comps.hour = 0
        comps.minute = 0
        comps.second = 0
        
        let midnightOfToday = cal.dateFromComponents(comps)!
       
        if self.doingSitUps
        {
      
        if self.manager.deviceMotionAvailable {
            
            self.manager.startDeviceMotionUpdatesToQueue(
                NSOperationQueue.currentQueue()!, withHandler: {
                    (data, error) -> Void  in
                self.manager.deviceMotionUpdateInterval = 1.7
        
                    self.activityName.hidden = false
                    self.activityState.hidden = false
   
        var showingPrompt = false
       
        // trigger values - a gap so there isn't a flicker zone
        let upperTrigger = 2.5
        let lowerTrigger = 1.6

               // data!.attitude.multiplyByInverseOfAttitude(initialAttitude)
                // calculate magnitude of the change from our initial attitude
                let magnitude = self.magnitudeFromAttitude(data!.attitude)
                print(magnitude)
//// =sqrt(pow(attitude.roll, 2.0f) + pow(attitude.yaw, 2.0f) + pow(attitude.pitch, 2.0f));
                // show the prompt
                if !showingPrompt && (magnitude > upperTrigger) {
                    self.sitUpCount++
                    self.activityCounter.text = "\(self.sitUpCount)"
                        showingPrompt = true
                  
                }
                if showingPrompt && (magnitude < lowerTrigger) {
                    showingPrompt = false
                }
            })
        }
        
        
        }
        
        
        
        if self.doingPullUps
        {
            
            if self.manager.deviceMotionAvailable {
                
                self.manager.startDeviceMotionUpdatesToQueue(
                    NSOperationQueue.currentQueue()!, withHandler: {
                        (data, error) -> Void  in
                        self.manager.deviceMotionUpdateInterval = 1
                        
                        self.activityName.hidden = false
                        self.activityState.hidden = false
                        //self.PullUpButtonName.hidden = true
                        
                        //  self.SitUpButtonName.setTitle("Stop SitUps", forState: UIControlState.Normal)
                        
                        var showingPrompt = false
                        
                        // trigger values - a gap so there isn't a flicker zone
                        let upperTrigger = 2.5
                        let lowerTrigger = 1.6
                        
                        // data!.attitude.multiplyByInverseOfAttitude(initialAttitude)
                        // calculate magnitude of the change from our initial attitude
                        let magnitude = self.magnitudeFromAttitude(data!.attitude)
                        print(magnitude)
                        //// =sqrt(pow(attitude.roll, 2.0f) + pow(attitude.yaw, 2.0f) + pow(attitude.pitch, 2.0f));
                        // show the prompt
                        if !showingPrompt && (magnitude > upperTrigger) {
                            self.pullUpCount++
                            self.activityCounter.text = "\(self.pullUpCount)"
                            showingPrompt = true
                            
                        }
                        if showingPrompt && (magnitude < lowerTrigger) {
                            showingPrompt = false
                        }
                })
            }
            
            
        }
        
        
        if(CMMotionActivityManager.isActivityAvailable()){
        
            self.activityManager.startActivityUpdatesToQueue(NSOperationQueue.mainQueue()) { data in
                if let data = data {
                    dispatch_async(dispatch_get_main_queue()) {
                        if(data.stationary == true){
                            self.activityState.text = "Stationary"
                        } else if (data.walking == true){
                            self.activityState.text = "Walking"
                        } else if (data.running == true){
                            self.activityState.text = "Running"
                        } else if (data.automotive == true){
                            self.activityState.text = "Automotive"
                        }
                    }
                }
            }
        }
        if(CMPedometer.isStepCountingAvailable()){
            let fromDate = NSDate(timeIntervalSinceNow: -86400 * 7)
            self.pedoMeter.queryPedometerDataFromDate(fromDate, toDate: NSDate()) { (data, error) -> Void in
                print(data)
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    if(error == nil){
                        self.steps.text = "\(data!.numberOfSteps)"
                        NSUserDefaults.standardUserDefaults().setObject(data!.numberOfSteps, forKey: "stepCount")
                    }
                })
                
            }
            
            self.pedoMeter.startPedometerUpdatesFromDate(midnightOfToday) { (data: CMPedometerData?, error) -> Void in
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    if(error == nil){
                        self.steps.text = "\(data!.numberOfSteps)"
                        NSUserDefaults.standardUserDefaults().setObject(data!.numberOfSteps, forKey: "stepCount")
                    }
                })
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
}