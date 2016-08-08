//
//  SecondViewController.swift
//  DevBootcamps
//
//  Created by Anthony Whitaker on 8/8/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import UIKit
import MapKit

class LocationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var map: MKMapView!
    
    let locationManager = CLLocationManager()
    let regionRadius: CLLocationDistance = 1000
    
    /// Temporary variable
    let addresses = [
        "20433 Vía San Marino Cupertino, CA 95014",
        "20650 Homestead Rd, Cupertino, CA 95014",
        "11010 N De Anza Blvd, Cupertino, CA 95014"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        map.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        for address in getAddresses() {
            addAnnotationForAddress(address)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        locationAuthStatus()
    }
    
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            map.showsUserLocation = true
        }
        else {
            locationManager.requestWhenInUseAuthorization()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        return NSIndexPath()
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2, regionRadius * 2)
        map.setRegion(coordinateRegion, animated: true)
    }
    
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        if let loc = userLocation.location {
            centerMapOnLocation(loc)
        }
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation.isKindOfClass(BootcampAnnotation) {
            let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "Default")
            annotationView.pinTintColor = UIColor.cyanColor()
            annotationView.animatesDrop = true
            return annotationView
        }
        
        return nil
    }
    
    //TODO: Download addresses from sever/database
    func getAddresses() -> [String] {
        return addresses
    }
    
    func addAnnotationForLocation(location: CLLocation) {
        let bootcamp = BootcampAnnotation(coordinate: location.coordinate)
        map.addAnnotation(bootcamp)
    }
    
    func addAnnotationForAddress(address: String) {
        CLGeocoder().geocodeAddressString(address) { (placemarks: [CLPlacemark]?, error: NSError?) in
            if let marks = placemarks where !marks.isEmpty{
                if let loc = marks[0].location {
                    self.addAnnotationForLocation(loc)
                }
            }
        }
    }
    
}

