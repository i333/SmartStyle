//
//  Location.swift
//  SmartStyle
//
//  Created by Utku Dora on 02/12/15.
//  Copyright © 2015 UDO. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit
struct MyLocation {
    static var latitute:Double?
    static var longitude:Double?
}
class MyPin: NSObject, MKAnnotation {
    var title: String?
    var subtitle: String?
    var latitude: Double
    var longitude:Double
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}