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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        
        var arr = ["mohsin":"Muhammad Mohsin"]
        ref.updateChildValues(arr)
        
        geoFire.setLocation(CLLocation(latitude: 37.7853889, longitude: -122.4056973), forKey: "firebase-hq") { (error) in
            if (error != nil) {
                println("An error occured: \(error)")
            } else {
                println("Saved location successfully!")
            }
        }
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

