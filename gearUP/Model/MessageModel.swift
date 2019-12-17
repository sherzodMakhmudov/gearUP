//
//  MessageModel.swift
//  gearUP
//
//  Created by Sherzod Makhmudov on 11/10/19.
//  Copyright © 2019 com.SherzodMakhmudov. All rights reserved.
//

import UIKit

class Message: NSObject{
    
    var fromId: String?
    var toId: String?
    var text: String?
    var timeStamp: NSNumber? //I need to change it to Int type
    
    init(dictionary: [String:Any]) {
        self.fromId = dictionary["fromId"] as? String ?? ""
        self.toId = dictionary["toId"] as? String ?? ""
        self.text = dictionary["text"] as? String ?? ""
        self.timeStamp = dictionary["timeStamp"] as? NSNumber
        
    }
}
