//
//  NewMessagesModel.swift
//  gearUP
//
//  Created by Sherzod Makhmudov on 11/5/19.
//  Copyright © 2019 com.SherzodMakhmudov. All rights reserved.
//

import UIKit
import CoreLocation

class User: NSObject{
    var username: String?
    var email: String?
    var profileImage: String?
    var id:String?
    var userLat: CLLocationDegrees?
    var userLong: CLLocationDegrees?
    var isHandyman: Bool?
    
    init(dictionary: [String:Any]){
        self.username = dictionary["username"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.profileImage = dictionary["profileImage"] as? String ?? ""
        self.id = dictionary["id"] as? String ?? ""
        self.userLat = dictionary["latitude"] as? CLLocationDegrees
        self.userLong = dictionary["longitude"] as? CLLocationDegrees
        self.isHandyman = dictionary["isHandyman"] as? Bool
    }
    
}



