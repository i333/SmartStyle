//
//  FoodViewController.swift
//  SmartStyle
//
//  Created by Utku Dora on 22/10/15.
//  Copyright © 2015 UDO. All rights reserved.
//

import UIKit
import Parse


var counter = 2
var counterin = 0
var index = -1
class FoodViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var FoodTable: UITableView!
  
    var totalFood = ["Apple","Bagel","Banana","Beer","Bread","Butter","Carrots","Cheddar Cheese","Chicken Breast","Chili with Beans","Chocolate Chip Cookie","Coffie","Cola","Corn","Egg","Graham Cracker","Granola Bar","Green Beans","Ground Beef Patty","Hot Dog","Ice Cream","Jelly Doughnut","Ketchup","Milk","Mixed Nuts","Mustard","Oatmeal","Orange Juice","Peanut Butter","Pizza","Pork Chop","Potato","Potato Chips","Pretzels","Raisins","Ranch Salad Dressing","Red Wine","Rice","Salsa","Shrimp","Spaghetti","Spaghetti Sauce","Tuna","White Wine","Yellow Cake"]
    var totalCal = [72,289,105,153,66,102,52,113,142,287,59,2,136,180,102,59,193,40,193,137,145,289,15,122,168,6,147,112,180,298,221,161,155,108,130,146,123,205,35,84,221,92,100,121,243]
    var todayCalories = 0
    var refresher: UIRefreshControl!
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       
        return totalFood.count
        
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        
        cell.textLabel?.text = "\(totalFood[indexPath.row])  /  \(totalCal[indexPath.row])"
        
        return cell
        
    }

//    func reload(){
//        
//        let query = PFQuery(className: "Products")
//        
//        query.whereKey("food", equalTo:"1")
//        
//        
//        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
//            if error == nil {
//               self.totalFood.removeAll(keepCapacity: true)
//                self.totalCal.removeAll(keepCapacity: true)
//                
//                counter  = objects!.count
//                for object in objects! {
//                    
//                    self.totalFood.append(object.objectForKey("name") as! String)
//                    self.totalCal.append(object.objectForKey("Calories") as! Int)
//                    var goal = Int(NSUserDefaults.standardUserDefaults().objectForKey("myGoal") as! NSNumber)
//                    NSUserDefaults.standardUserDefaults().setObject(goal, forKey: "caloriesRemaing")
//                    
//                }
//                
//                self.FoodTable.performSelectorOnMainThread(Selector("reloadData"), withObject: nil, waitUntilDone: true)
//               
//                self.refresher.endRefreshing()
//            }
//        }
//        
//        self.FoodTable.performSelectorOnMainThread(Selector("reloadData"), withObject: nil, waitUntilDone: true)
//        
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        refresher = UIRefreshControl()
//        
//        refresher.attributedTitle = NSAttributedString(string: "Pull to refresh")
//        
//     //   refresher.addTarget(self, action: "reload", forControlEvents: UIControlEvents.ValueChanged)
//        
//        self.FoodTable.addSubview(refresher)
//        
        
      //  reload()
        
        /*var query = PFQuery(className: "Products")
        query.whereKey("food", equalTo:"1")
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if error == nil {
                print("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                if let objects = objects {
                    for object in objects {
                        print(object.objectId)
                    }
                }
            }
        }*/
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    func showAlert(){
        
        var calRemain = NSUserDefaults.standardUserDefaults().objectForKey("remainingCalories") as! Int
        var num =   calRemain -  self.todayCalories
        var alert = UIAlertView(title: "This has too many calories", message: "You only have \(num) remaining", delegate: self, cancelButtonTitle:"Maybe Later")
        alert.addButtonWithTitle("Yes")
        alert.addButtonWithTitle("No")
        alert.show()
    }
    
    func alertView(View: UIAlertView!, clickedButtonAtIndex buttonIndex: Int){
        switch buttonIndex{
        case 1: addFood(index)
        case 2: print("No")
        default: print("Is this part even possible?")
        }
    }
    func addFood(Index: Int)
    {
        //var cell:UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        //print(totalFood[Index])
//        var query = PFObject(className: "Products")
//        
//        query["name"] = totalFood[Index]
//        
//        query["Calories"] = totalCal[Index]
//        
//        query["food"] = "0"
        
       // var caloriesLeft = self.todayCalories + totalCal[Index]
        var calRemain = NSUserDefaults.standardUserDefaults().objectForKey("remainingCalories") as! Int
        var balRemain = NSUserDefaults.standardUserDefaults().objectForKey("remainingBalance") as! Int
        var num = calRemain - totalCal[Index]
        
        NSUserDefaults.standardUserDefaults().setObject(num, forKey: "remainingCalories")
       // query.saveInBackgroundWithBlock { (success, error) -> Void in
        var   num2 = balRemain - totalCal[Index]
        NSUserDefaults.standardUserDefaults().setObject(num2, forKey: "remainingBalance")
          //  if success == true {
                
                //print("Object saved with ID \(query.objectId)")
                var alert = UIAlertView(title: "Food Added", message: "You have \(num) left!", delegate: self, cancelButtonTitle:"Ok")
                alert.show()
                
           // } else {
                
//                //print("Failed")
//                var alert = UIAlertView(title: "Error", message: "Try again!", delegate: self, cancelButtonTitle:"Ok")
//                alert.show()
//                print(error)
//                
          //  }
            
        //}
    }
    func calculateCal(){
        do{
        var goal:Int = Int(NSUserDefaults.standardUserDefaults().objectForKey("myGoal") as! NSNumber)
        var date = NSDate()
        let unitFlags: NSCalendarUnit = [.Hour, .Day, .Month, .Year]
        let components = NSCalendar.currentCalendar().components(unitFlags, fromDate: date)
        let today = "May " + String(components.day )
        let query2 = PFQuery(className: "Products")
        
        query2.whereKey("food", equalTo:"0")
        
        
        query2.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if error == nil {
                //print(objects!.count)
                self.todayCalories = 0
                counter  = objects!.count
                for object in objects! {
                    
                    var dateUpdated = object.updatedAt! as NSDate
                    var dateFormat = NSDateFormatter()
                    dateFormat.dateFormat = "EEE, MMM d, h:mm a"
                    var date = NSString(format: "%@", dateFormat.stringFromDate(dateUpdated))
                    var dateArray = date.componentsSeparatedByString(", ")
                    date = dateArray[1]
                    
                    if today == date{
                        
                        self.todayCalories = self.todayCalories + Int(object.valueForKey("Calories")! as! NSNumber)
                        var cal = NSUserDefaults.standardUserDefaults().objectForKey("myGoal") as! Int - self.todayCalories
                        NSUserDefaults.standardUserDefaults().setObject(cal, forKey: "remainingCalories")
                        
                        
                    }
                }
                
                
            }
            }}
        catch{
            
            let alert = UIAlertController(title: "SmartStyle", message: " Please Set Track Before Adding Items", preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)

        
        
        }
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        calculateCal()
        print(NSUserDefaults.standardUserDefaults().objectForKey("remainingCalories"))
        var calRemain = 0
        if NSUserDefaults.standardUserDefaults().objectForKey("remainingCalories") != nil{
             calRemain = NSUserDefaults.standardUserDefaults().objectForKey("remainingCalories") as! Int
            
        }
        else
        {
            calRemain = 0
        }
        
        if totalCal[indexPath.row] > calRemain {
            showAlert()
            index = indexPath.row
            
        }
        else{
            addFood(indexPath.row)
            
        }
        viewDidLoad()
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
