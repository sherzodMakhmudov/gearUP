//
//  CustomPinAnnotation.swift
//  gearUP
//
//  Created by Sherzod Makhmudov on 11/28/19.
//  Copyright © 2019 com.SherzodMakhmudov. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class customAnnotaion: NSObject, MKAnnotation{
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var selectedUser: User?
    
    init(annotationTitle: String, annotationSubtitle: String, annotationCoordinate: CLLocationCoordinate2D, selectedUser: User){
        self.title = annotationTitle
        self.subtitle = annotationSubtitle
        self.coordinate = annotationCoordinate
        self.selectedUser = selectedUser
    }
    
}
