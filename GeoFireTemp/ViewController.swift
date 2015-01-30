//
//  ViewController.swift
//  GeoFireTemp
//
//  Created by Mohsin on 28/01/2015.
//  Copyright (c) 2015 PanaCloud. All rights reserved.
//

import UIKit

let ref = Firebase(url: "https://geofiretemp.firebaseio.com/")
let geoFire = GeoFire(firebaseRef: ref)


class ViewController: UIViewController {

    @IBOutlet weak var lblMsg: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        
        var arr = ["mohsin":"Muhammad Mohsin"]
        ref.updateChildValues(arr)
        
        // set the location
        geoFire.setLocation(CLLocation(latitude: 37.7853889, longitude: -122.4056973), forKey: "firebase-hq") { (error) in
            if (error != nil) {
                println("An error occured: \(error)")
            } else {
                println("Saved location successfully!")
            }
        }
        
        // remove the location
        //geoFire.removeKey("firebase-hq")

        
        // get the location
        geoFire.getLocationForKey("firebase-hq", withCallback: { (location, error) in
            if (error != nil) {
                println("An error occurred getting the location for \"firebase-hq\": \(error.localizedDescription)")
            } else if (location != nil) {
                println("Location for \"firebase-hq\" is [\(location.coordinate.latitude), \(location.coordinate.longitude)]")
            } else {
                println("GeoFire does not contain a location for \"firebase-hq\"")
            }
        })
        
        
        
        // geo fire query 
        
        let center = CLLocation(latitude: 37.7832889, longitude: -122.4056973)
        // Query locations at [37.7832889, -122.4056973] with a radius of 600 meters
        var circleQuery = geoFire.queryAtLocation(center, withRadius: 0.6)
        
        
        
        // Query location by region
        let span = MKCoordinateSpanMake(0.001, 0.001)
        let region = MKCoordinateRegionMake(center.coordinate, span)
        var regionQuery = geoFire.queryWithRegion(region)
        
        
        var queryHandle1 = circleQuery.observeEventType(GFEventTypeKeyEntered, withBlock: { (key: String!, location: CLLocation!) in
            let msg = "Key '\(key)' entered in the search area and is at location: '\(location)'"
            println(msg)
            self.updateLabel(msg)
        })
        
        var queryHandle2 = circleQuery.observeEventType(GFEventTypeKeyExited, withBlock: { (key: String!, location: CLLocation!) in
            let msg = "Key '\(key)'\n exacted in the search area and is at location: '\(location)'"
            println(msg)
            self.updateLabel(msg)

        })
        
//        var queryHandle3 = circleQuery.observeEventType(GFEventTypeKeyExited, withBlock: { (key: String!, location: CLLocation!) in
//            let msg = "Key '\(key)'\n move in the search area and is at location: '\(location)'"
//            println(msg)
//            self.updateLabel(msg)
//
//        })
        

    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func updateLabel (text: String) {
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.lblMsg.text = text
        })

        


    }

}

