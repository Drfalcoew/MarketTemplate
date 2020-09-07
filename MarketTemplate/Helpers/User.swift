//
//  User.swift
//  MarketTemplate
//
//  Created by Drew Foster on 8/16/20.
//  Copyright © 2020 Drew Foster. All rights reserved.
//

import Foundation
import FirebaseDatabase
import GoogleSignIn


struct User {
    
    let uid: String?
    let email: String?
    let userName: String?
    let loyalty : Int?
    let reward : Int?
    
    
    init(authData: User) {
        uid = authData.uid
        email = authData.email!
        userName = authData.userName!
        reward = authData.reward
        loyalty = authData.loyalty
    }
    
    
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        userName = snapshotValue["userName"] as? String
        uid = snapshotValue["uid"] as? String
        email = snapshotValue["email"] as? String
        reward = snapshotValue["reward"] as? Int
        loyalty = snapshotValue["loyalty"] as? Int
    }
    
    
    
    init(uid: String, email: String, userName: String, reward: Int, loyalty: Int) {
        self.uid = uid
        self.email = email
        self.userName = userName
        self.loyalty = loyalty
        self.reward = reward
    }
}
