//
//  ViewInput.swift
//  SmartStyle
//
//  Created by Utku Dora on 14/10/15.
//  Copyright © 2015 UDO. All rights reserved.
//


import Foundation
import UIKit

class ViewInput: UIViewController {
 
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userAge: UITextField!
    @IBOutlet weak var userHeight: UITextField!
    @IBOutlet weak var userWeight: UITextField!
    @IBOutlet weak var userGoal: UISlider!
    @IBOutlet weak var userGender: UISwitch!
    
    
    
    @IBOutlet weak var myGoal: UILabel!
   
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @IBAction func submit(sender: AnyObject) {
        let tempName = userName.text
        let tempAge = Int(userAge.text!)
        let tempHeight = Int(userHeight.text!)
        let tempWeight = Int(userWeight.text!)
        let tempGoal = Int(userGoal.value)
        
        var BMR:Double = 0
        
        if userGender.on {
            BMR = 655
            BMR = BMR + ( 4.35 * Double(tempWeight!) )
            BMR = BMR + ( 4.7 * Double(tempHeight!) )
            BMR = BMR - (4.7 * Double(tempAge!))
            
        }
        else
        {
            BMR = 66
            BMR = BMR + ( 6.23 * Double(tempWeight!) )
            BMR = BMR + ( 12.7 * Double(tempHeight!) )
            BMR = BMR - (6.8 * Double(tempAge!))
        }

        if tempGoal == 0{
            BMR = BMR - 500
        }
        
        if tempGoal == 2{
            BMR = BMR + 500
        }
        NSUserDefaults.standardUserDefaults().setObject(BMR, forKey: "myGoal")
        NSUserDefaults.standardUserDefaults().setObject(userGender.on, forKey: "gender")
        NSUserDefaults.standardUserDefaults().setObject(tempGoal, forKey: "weightGoal")
       // NSUserDefaults.standardUserDefaults().setObject(BMR, forKey: "goal")
        NSUserDefaults.standardUserDefaults().setObject(tempWeight, forKey: "weight")
        NSUserDefaults.standardUserDefaults().setObject(tempName, forKey: "name")
        NSUserDefaults.standardUserDefaults().setObject(tempAge, forKey: "age")
        NSUserDefaults.standardUserDefaults().setObject(tempHeight, forKey: "height")
        NSUserDefaults.standardUserDefaults().setObject(nil, forKey: "remainingCalories")
        NSUserDefaults.standardUserDefaults().setObject(BMR*29, forKey: "remainingBalance")
        
        var alert = UIAlertView(title: "Infomation Saved", message: "Data is confirmed", delegate: self, cancelButtonTitle:"Ok")
        
        alert.show()
        
        viewDidLoad()
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // to close the keyboard when the background is clicked
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        if NSUserDefaults.standardUserDefaults().objectForKey("name") != nil {
            
            userName.text = NSUserDefaults.standardUserDefaults().objectForKey("name") as! String
            
        }
        if NSUserDefaults.standardUserDefaults().objectForKey("myGoal") != nil {
            
            myGoal.text = String(NSUserDefaults.standardUserDefaults().objectForKey("myGoal") as! NSNumber)
            
            
        }
        if NSUserDefaults.standardUserDefaults().objectForKey("weight") != nil {
            
            userWeight.text = String(NSUserDefaults.standardUserDefaults().objectForKey("weight") as! NSNumber)
            
        }
        if NSUserDefaults.standardUserDefaults().objectForKey("height") != nil {
            
            userHeight.text = String(NSUserDefaults.standardUserDefaults().objectForKey("height") as! NSNumber)
            
        }
        if NSUserDefaults.standardUserDefaults().objectForKey("age") != nil {
            
            userAge.text = String(NSUserDefaults.standardUserDefaults().objectForKey("age") as! NSNumber)
            
        }
        if NSUserDefaults.standardUserDefaults().objectForKey("age") != nil {
            
            userAge.text = String(NSUserDefaults.standardUserDefaults().objectForKey("age") as! NSNumber)
            
        }
        if NSUserDefaults.standardUserDefaults().objectForKey("gender") != nil {
            
            userGender.on = NSUserDefaults.standardUserDefaults().objectForKey("gender") as! Bool
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

