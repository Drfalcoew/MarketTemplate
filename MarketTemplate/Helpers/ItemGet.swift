//
//  ItemGet.swift
//  MarketTemplate
//
//  Created by Drew Foster on 9/18/20.
//  Copyright © 2020 Drew Foster. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseFirestore

struct ItemGet {
    
    var orderDate : String?
    var orderTime : String?
    var active : Bool?
    var ref : String?
    
    init(ref : String, date : String, time : String, active : Bool) {
        self.orderDate = date
        self.orderTime = time
        self.active = active
        self.ref = ref
    }
    
    init(snapshot: QueryDocumentSnapshot) {
        let snapshotValue = snapshot.data() as [String: AnyObject]
        orderDate = snapshotValue["orderDate"] as? String
        orderTime = snapshotValue["orderTime"] as? String
        active = snapshotValue["active"] as? Bool
        ref = snapshot.documentID
    }
}
