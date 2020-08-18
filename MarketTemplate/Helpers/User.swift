//
//  User.swift
//  MarketTemplate
//
//  Created by Drew Foster on 8/16/20.
//  Copyright © 2020 Drew Foster. All rights reserved.
//

import Foundation
import FirebaseDatabase


struct User {
    
    let uid: String?
    let email: String?
    let userName: String?
    
    
    init(authData: User) {
        uid = authData.uid
        email = authData.email!
        userName = authData.userName!
    }
    
    
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        userName = snapshotValue["userName"] as? String
        uid = snapshotValue["uid"] as? String
        email = snapshotValue["email"] as? String
    }
    
    
    
    init(uid: String, email: String, userName: String, rep: Double) {
        self.uid = uid
        self.email = email
        self.userName = userName
    }
}
