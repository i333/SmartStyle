//
//  ViewDiaries.swift
//  SmartStyle
//
//  Created by Utku Dora on 12/9/15.
//  Copyright © 2015 UDO. All rights reserved.
//


import Foundation
import Parse

class ViewDiaries: UIViewController, UITableViewDelegate {
    //mode is swithcing between viewing all diaries days and to speicfic day
   var mode = 0
    //date user wants to look up
    var viewDate = ""
    
    @IBOutlet weak var FoodTable: UITableView!
    var allDays = ["",""]
    var totalFood = ["",""]
    var totalId = ["",""]
    var totalCal = [0,0]
    
    var refresher: UIRefreshControl!
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if mode == 0{
            return allDays.count
        }
        else{
            return totalFood.count
        }
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell2")
        
        if mode == 0{
        cell.textLabel?.text = allDays[indexPath.row]
        }
        else{
            cell.textLabel?.text = "\(totalFood[indexPath.row]) \(totalCal[indexPath.row])"
        }
        return cell
        
    }
    
    func reload(){
        
        let query = PFQuery(className: "Products")
        
        query.whereKey("food", equalTo:"0")
        
        
        
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if error == nil {
                
                
                counter  = objects!.count
                self.totalFood.removeAll(keepCapacity: true)
                self.totalCal.removeAll(keepCapacity: true)
                self.allDays.removeAll(keepCapacity: true)
                self.totalId.removeAll(keepCapacity: true)
                
                for object in objects! {
                    if self.mode == 0{
                        
                        var inList = 0
                        var dateUpdated = object.updatedAt! as NSDate
                        var dateFormat = NSDateFormatter()
                        dateFormat.dateFormat = "EEE, MMM d, h:mm a"
                        var date = NSString(format: "%@", dateFormat.stringFromDate(dateUpdated))
                        var dateArray = date.componentsSeparatedByString(", ")
                        date = dateArray[1]
                        for index in 0..<self.allDays.count{
                            if self.allDays[index] == date{
                                inList = 1
                            }
                        
                        }
                        if inList == 0{
                            self.allDays.append(date as! String)
                        }
                    }
                    else{
                        
                        var dateUpdated = object.updatedAt! as NSDate
                        var dateFormat = NSDateFormatter()
                        dateFormat.dateFormat = "EEE, MMM d, h:mm a"
                        var date = NSString(format: "%@", dateFormat.stringFromDate(dateUpdated))
                        var dateArray = date.componentsSeparatedByString(", ")
                        date = dateArray[1]
                        
                        if date == self.viewDate
                        {
                            
                            self.totalFood.append(object.objectForKey("name") as! String)
                            self.totalCal.append(object.objectForKey("Calories") as! Int)
                            self.totalId.append(object.objectId!)
                            
                        }

                    }
                }
                
                self.FoodTable.performSelectorOnMainThread(Selector("reload"), withObject: nil, waitUntilDone: true)
                
                self.refresher.endRefreshing()
                
            }
            else
            {
                self.refresher.endRefreshing()
            }
        }
        
        self.FoodTable.performSelectorOnMainThread(Selector("reload"), withObject: nil, waitUntilDone: true)
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        refresher = UIRefreshControl()
        
        refresher.attributedTitle = NSAttributedString(string: "Pull to refresh")
        
        refresher.addTarget(self, action: "reload", forControlEvents: UIControlEvents.ValueChanged)
        
        self.FoodTable.addSubview(refresher)
        
        reload()
      
        self.refresher.endRefreshing()
        // Do any additional setup after loading the view, typically from a nib.
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        var cell:UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        
        
        if mode == 1{
            mode = 0
            
        }
        else
        {
            
            mode = 1
            viewDate = allDays[indexPath.row]
        }
        
        
        
        viewDidLoad()
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
       
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            
            
            var query = PFQuery(className: "Products")
            
            
            query.getObjectInBackgroundWithId(totalId[indexPath.row], block: { (object: PFObject?, error: NSError? ) -> Void in
                
                if error != nil {
                    
                    print(error)
                    
                } else if let product = object {
                    
                    //print(product.objectForKey("name"))
                    product.deleteInBackground()
                
                    self.viewDidLoad()
                }
                
                
            })

            viewDidLoad()
            
            
        }
       
    }
    override func viewDidAppear(animated: Bool) {
        
         self.FoodTable.performSelectorOnMainThread(Selector("reload"), withObject: nil, waitUntilDone: true)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}