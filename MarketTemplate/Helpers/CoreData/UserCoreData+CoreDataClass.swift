//
//  UserCoreData+CoreDataClass.swift
//  MarketTemplate
//
//  Created by Drew Foster on 8/20/20.
//  Copyright © 2020 Drew Foster. All rights reserved.
//

import Foundation
import CoreData

@objc(UserCoreData)
public class UserCoreData: NSManagedObject {

}


extension UserCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserCoreData> {
        return NSFetchRequest<UserCoreData>(entityName: "UserCoreData")
    }
    
    @NSManaged public var accountTotal : NSNumber?
    @NSManaged public var email: String?
    @NSManaged public var loyalty: NSNumber?
    @NSManaged public var uid: String?
    @NSManaged public var userName: String?
    @NSManaged public var reward : NSNumber?
}
