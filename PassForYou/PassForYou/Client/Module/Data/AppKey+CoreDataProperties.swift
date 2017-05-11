//
//  AppKey+CoreDataProperties.swift
//  
//
//  Created by mtkj on 2017/5/11.
//
//

import Foundation
import CoreData


extension AppKey {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AppKey> {
        return NSFetchRequest<AppKey>(entityName: "AppKey");
    }

    @NSManaged public var openid: String?

}
