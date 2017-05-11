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

protocol DBProtocol:NSFetchRequestResult{
    static func deleteAll(className name:AnyClass,sortKey key:String);//删除这个类的所有元素
    static func fetchNSManagedObject(className name:AnyClass,sortKey key:String)->Array<DBProtocol>?;
    static func update();
    static func coreDataSave();
    static func insert(object:DBProtocol);
    static func delete(object:DBProtocol);//删除单个
}
