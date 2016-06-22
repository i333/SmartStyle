//
//  LoginViewController.swift
//  SmartStyle
//
//  Created by Utku Dora on 14/10/15.
//  Copyright © 2015 UDO. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class LoginViewController: UIViewController {

    @IBOutlet weak var usernameInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // to close the keyboard when the background is clicked
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    //Calls this function when the tap is recognized.
        // Do any additional setup after loading the view.
    }
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func CheckLoginInfo(sender: AnyObject) {
        
        if let email = usernameInput.text,
            let password = passwordInput.text{
                
                Alamofire.request(.POST, "http://api.pisano.co/v1/login", parameters: ["email":email, "password":password] , encoding:.JSON)
                    .responseJSON { response in
                        debugPrint(response)
                }
        }
    }
   
}
