//
//  PushViewController.swift
//  SmartStyle
//
//  Created by Utku Dora on 11/11/15.
//  Copyright © 2015 UDO. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Bolts
import Parse
import CoreLocation

class PushViewController: UIViewController ,CLLocationManagerDelegate{

    @IBOutlet weak var monthlyGoalLabel: UILabel!
    @IBOutlet weak var remainingCaloriesLabel: UILabel!
    @IBOutlet weak var myGoalLabel: UILabel!
    
    @IBAction func SendNotificationToAll(sender: AnyObject) {
        
        let push = PFPush()
        
        let locationManager = CLLocationManager()
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()

        MyLocation.latitute = locationManager.location?.coordinate.latitude
        MyLocation.longitude = locationManager.location?.coordinate.longitude
   
//        func sendPosition(userOfPosition: User) {
//            
//            let takePosition = PFObject(className: "Position")
//            
//            takePosition.setObject(myParseId!, forKey: "who") //who
//            takePosition.setObject(myGeoPoint, forKey: "where")
//            takePosition.saveInBackgroundWithBlock(nil)
//            
//        }
//        
//        
//       sendPosition(currentUser()!)
        
        
        PFGeoPoint.geoPointForCurrentLocationInBackground {
            (geoPoint: PFGeoPoint?, error: NSError?) -> Void in
            print("inside")
            if error == nil {
                print("working")
                // do something with the new geoPoint
                print(geoPoint)
            
            }
        }
        
        
        
        
        push.setMessage("Alice: I am not feeling secure please come help!")
        push.sendPushInBackground()
    }
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let locationManager = CLLocationManager()
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        MyLocation.latitute = locationManager.location?.coordinate.latitude
        MyLocation.longitude = locationManager.location?.coordinate.longitude

        if NSUserDefaults.standardUserDefaults().objectForKey("remainingBalance") != nil {
            
            
            
            monthlyGoalLabel.text = String(NSUserDefaults.standardUserDefaults().objectForKey("remainingBalance") as! NSNumber)
            
            
        }

        
        if NSUserDefaults.standardUserDefaults().objectForKey("myGoal") != nil {
            var mygoal = NSUserDefaults.standardUserDefaults().objectForKey("myGoal") as! NSNumber
            myGoalLabel.text = String(NSUserDefaults.standardUserDefaults().objectForKey("myGoal") as! NSNumber)
            
            
            if NSUserDefaults.standardUserDefaults().objectForKey("remainingCalories") != nil {
                
                remainingCaloriesLabel.text = String(NSUserDefaults.standardUserDefaults().objectForKey("remainingCalories") as! NSNumber)
                
                
            }
            else{
                
                if NSUserDefaults.standardUserDefaults().objectForKey("weight") != nil {
                    var stepcount = 0;
                    if NSUserDefaults.standardUserDefaults().objectForKey("stepCount") != nil {
                        
                      //  remainingCaloriesLabel.text = String(NSUserDefaults.standardUserDefaults().objectForKey("stepCount") as! NSNumber)
                        stepcount = Int(NSUserDefaults.standardUserDefaults().objectForKey("stepCount") as! NSNumber)
                        
                    }
                    var weight = NSUserDefaults.standardUserDefaults().objectForKey("weight") as! NSNumber
                    var remaining = (Int)(mygoal) + (Int)((Int)(weight)/3500)*stepcount
                    
                    if NSUserDefaults.standardUserDefaults().objectForKey("remainingBalance") != nil {
                        
                       var balance = NSUserDefaults.standardUserDefaults().objectForKey("remainingBalance") as! NSNumber
                        //balance = balance + (Int)((Int)(weight)/3500)
                        monthlyGoalLabel.text = String(NSUserDefaults.standardUserDefaults().objectForKey("remainingBalance") as! NSNumber)
                        
                        
                    }
                     remainingCaloriesLabel.text = (String)(remaining)
                    NSUserDefaults.standardUserDefaults().setObject(remaining, forKey: "remainingCalories")
                }
                else{
                remainingCaloriesLabel.text = String(NSUserDefaults.standardUserDefaults().objectForKey("myGoal") as! NSNumber)
                }
            
            }
            
        }
        
        
            // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }

    


}
