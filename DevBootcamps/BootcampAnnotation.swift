//
//  BootCampAnnotation.swift
//  DevBootcamps
//
//  Created by Anthony Whitaker on 8/8/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import Foundation
import MapKit

class BootcampAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D()

    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }

}