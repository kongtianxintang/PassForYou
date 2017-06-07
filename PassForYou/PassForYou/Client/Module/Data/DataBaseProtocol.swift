/*********************************************************************************
 * 版权所有,2017,lisir.
 * Copyright(C),lisir, LTD.All rights reserved.
 * project:
 * Author:lisir
 * Date:  17/05/11
 * QQ/Tel/Mail:
 * Description:数据库协议
 * Others:
 * Modifier:
 * Reason:
 **********************************************************************************/

import Foundation
import CoreData

protocol DBProtocol{
    static func deleteAll(className name:AnyClass,sortKey key:String);//删除这个类的所有元素
    static func fetchNSManagedObject(className name:AnyClass,sortKey key:String)->Array<NSFetchRequestResult>?;
    static func update();
    static func coreDataSave(with completeHandle:((_ isSave:Bool)->Void)?);
    static func insert(object:NSManagedObject);
    static func delete(object:NSManagedObject);//删除单个
}
