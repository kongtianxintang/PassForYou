//
//  Account+CoreDataProperties.swift
//  
//
//  Created by mtkj on 2017/5/27.
//
//

import Foundation
import CoreData


extension Account {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Account> {
        return NSFetchRequest<Account>(entityName: "Account")
    }

    @NSManaged public var id: String?
    @NSManaged public var pw: String?

}
