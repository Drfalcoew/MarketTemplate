//
//  Address.swift
//  MarketTemplate
//
//  Created by Drew Foster on 8/12/20.
//  Copyright © 2020 Drew Foster. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseFirestore

struct Address {
    
    var nickName : String?
    var streetAddress : String
    var city : String
    var state : String
    var zipCode : String
    var aptSuite : String?
    var roomNum : String?
    var instructions : String?
    var ref : String?
    
    init(ref : String, nn : String, add : String, city : String, st : String, zip : String, apt : String, room : String, inst : String) {
        self.streetAddress = add
        self.city = city
        self.state = st
        self.zipCode = zip
        self.aptSuite = apt
        self.roomNum = room
        self.instructions = inst
        self.nickName = nn
        self.ref = ref
    }
    
    init(snapshot: QueryDocumentSnapshot) {
        let snapshotValue = snapshot.data() as [String: AnyObject]
        nickName = snapshotValue["nickname"] as? String
        streetAddress = snapshotValue["streetaddress"] as! String
        city = snapshotValue["city"] as! String
        state = snapshotValue["state"] as! String
        zipCode = snapshotValue["zipcode"] as! String
        aptSuite = snapshotValue["aptsuite"] as? String
        roomNum = snapshotValue["room"] as? String
        instructions = snapshotValue["instructions"] as? String
        //ref = snapshot.reference
    }
}
