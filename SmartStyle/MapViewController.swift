//
//  MapViewController.swift
//  SmartStyle
//
//  Created by Utku Dora on 02/12/15.
//  Copyright © 2015 UDO. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        zoomToRegion()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK:- Zoom to region
    
    @IBAction func findFriends(sender: AnyObject) {
        if (MyLocation.latitute != nil)&&(MyLocation.latitute != nil) {
        
            
            let location = CLLocationCoordinate2D(latitude: MyLocation.latitute!, longitude: MyLocation.longitude!)
            
            let region = MKCoordinateRegionMakeWithDistance(location, 5.0, 7.0)
            
            let pin = MyPin(latitude: MyLocation.latitute!, longitude: MyLocation.longitude!)
            
            
            mapView.addAnnotation(pin)// burada daha duzgun bi pin modellemesi yapilmasi lazim ileride array ile calisabilir durumda olmasi lazim ayrica
            mapView.setRegion(region, animated: true)
        }
        
        
        
    }
    func zoomToRegion() {
        
        let location = CLLocationCoordinate2D(latitude: 13.03297, longitude: 80.26518)
        
        let region = MKCoordinateRegionMakeWithDistance(location, 5000.0, 7000.0)
        
        mapView.setRegion(region, animated: true)
    }


}
