//
//  ViewController.swift
//  MyLocation
//
//  Created by Duc Tran on 3/18/15.
//  Copyright (c) 2015 Duc Tran. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.requestWhenInUseAuthorization()
        checkCoreLocationPermission()
    }
    
    @IBAction func updateLocation(sender: AnyObject)
    {
        locationManager.startUpdatingLocation()
    }
    
    // MARK: Location

    var location: CLLocation! {
        didSet(newValue) {
            print(newValue)
            latitudeLabel.text = "\(location.coordinate.latitude)"
            longitudeLabel.text = "\(location.coordinate.longitude)"
        }
    }
    
    var locationManager: CLLocationManager!
    
    func checkCoreLocationPermission()
    {
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            locationManager.startUpdatingLocation()
        } else if CLLocationManager.authorizationStatus() == .NotDetermined {
            //            locationManager.requestAlwaysAuthorization()    // always use CL, even the app is in background
            locationManager.requestWhenInUseAuthorization()     // just need to update location when in use, save battery
        } else if CLLocationManager.authorizationStatus() == .Restricted{
            // alert
            println("unauthorized to use location services")
        }
    }
    
    // MARK: - CLLocationManagerDelegate
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        location = (locations as! [CLLocation]).last
        locationManager.stopUpdatingLocation()
    }
}


























