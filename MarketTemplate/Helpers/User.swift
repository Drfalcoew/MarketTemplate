//
//  User.swift
//  MarketTemplate
//
//  Created by Drew Foster on 8/16/20.
//  Copyright © 2020 Drew Foster. All rights reserved.
//

import Foundation
import FirebaseFirestore
import GoogleSignIn
import Stripe

struct User {
    
    let uid: String?
    let email: String?
    let userName: String?
    let loyalty : Int?
    let reward : Int?
    let recentOrder : String?
    let safeZone : String? // 4 weeks after 1st recent order
    let accountTotal : Double?

    
    init(authData: User) {
        uid = authData.uid
        email = authData.email!
        userName = authData.userName!
        reward = authData.reward
        loyalty = authData.loyalty
        recentOrder = authData.recentOrder
        safeZone = authData.safeZone
        accountTotal = authData.accountTotal
    }
    
    
    /*init(snapshot: QueryDocumentSnapshot) {
        let snapshotValue = snapshot.data() as [String: AnyObject]
        userName = snapshotValue["userName"] as? String
        uid = snapshotValue["uid"] as? String
        email = snapshotValue["email"] as? String
        reward = snapshotValue["reward"] as? Int
        loyalty = snapshotValue["loyalty"] as? Int
    }*/
    
    init(snapshot: DocumentSnapshot) {
        let snapshotValue = snapshot.data() as [String: AnyObject]?
        userName = snapshotValue?["displayName"] as? String
        uid = snapshotValue?["uid"] as? String
        email = snapshotValue?["email"] as? String
        reward = snapshotValue?["reward"] as? Int
        loyalty = snapshotValue?["loyalty"] as? Int
        recentOrder = snapshotValue?["recentOrder"] as? String
        safeZone = snapshotValue?["safeZone"] as? String
        accountTotal = snapshotValue?["accountTotal"] as? Double
    }
    
    
    
    init(uid: String, email: String, userName: String, reward: Int, loyalty: Int, recentOrder: String, safeZone: String, accountTotal: Double) {
        self.uid = uid
        self.email = email
        self.userName = userName
        self.loyalty = loyalty
        self.reward = reward
        self.recentOrder = recentOrder
        self.safeZone = safeZone
        self.accountTotal = accountTotal
    }
}


class Card : STPPaymentMethodCard {
    
    var id: String?
    var lastFour: String?
    var type: String?
    
    init(snapshot: QueryDocumentSnapshot) {
        let snapshotValue = snapshot.data() as [String: AnyObject]
        id = snapshotValue["id"] as? String
        lastFour = snapshotValue["last4"] as? String
        type = snapshotValue["brand"] as? String
    }
  
    init(id: String, lastFour: String?, type: String?) {
        self.id = id
        self.lastFour = lastFour
        self.type = type
    }
}
