//
//  Capital.swift
//  Project19
//
//  Created by Victor Cordero on 2016-12-06.
//  Copyright © 2016 Victor Cordero Utrilla. All rights reserved.
//
import MapKit
import UIKit

class Capital: NSObject, MKAnnotation {

    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String
    
    init(title: String, coordinate: CLLocationCoordinate2D, info: String) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
    }
}
