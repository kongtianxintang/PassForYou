/*********************************************************************************
 * 版权所有,2017,lisir.
 * Copyright(C),lisir, LTD.All rights reserved.
 * project:
 * Author:lisir
 * Date:  17/05/11
 * QQ/Tel/Mail:
 * Description:对NSManagedObject对象扩展
 * Others:
 * Modifier:
 * Reason:
 **********************************************************************************/
import Foundation
import UIKit
import CoreData

extension NSManagedObject:DBProtocol {
    
    //MARK:创建entity
    final class func createEntity(className name:AnyClass)->NSManagedObject?{
        guard let context = returnContext() else { assertionFailure("context 为 空");return nil};
        let entity = NSEntityDescription.insertNewObject(forEntityName: NSStringFromClass(name), into: context)
        return entity;
    }
    //MARK:删除所有这个类所有元素
    static func deleteAll(className name:AnyClass,sortKey key:String){
        guard let context = returnContext() else { assertionFailure("context 为 空");return  };
        if let list = fetchNSManagedObject(className: name, sortKey: key){
            for item in list {
                if let tObject = item as? NSManagedObject {
                    context.delete(tObject)
                }
            }
            coreDataSave();
        }
    }
    
    //MARK:删除单个
    static func delete(object:NSManagedObject){
        guard let context = returnContext() else {assertionFailure("context 为 空");return};
            context.delete(object)
            coreDataSave();
    }
    
    //MARK:查询
    static func fetchNSManagedObject(className name:AnyClass,sortKey key:String)->Array<NSFetchRequestResult>?{
        guard let context = returnContext() else { assertionFailure("context 为 空");return nil };
        let tName = NSStringFromClass(name)
        let request = NSFetchRequest<NSFetchRequestResult>.init(entityName:tName);
        let sort = NSSortDescriptor.init(key: key, ascending: true)
        request.sortDescriptors = [sort]
        let fetchController = NSFetchedResultsController.init(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        do {
            try fetchController.performFetch();
            return fetchController.fetchedObjects
        } catch {
            assertionFailure("fetch错误=\(error)")
            return nil;
        }
    }
    
    //MARK:更新
    static func update(){
        coreDataSave();
    }
    
    //MARK:保存
    static func coreDataSave(){
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            delegate.saveContext();
        }
    }
    
    //MARK:插入
    static func insert(object:NSManagedObject){
        coreDataSave();
    }
    
    private class func returnContext()->NSManagedObjectContext?{
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            let context = delegate.persistentContainer.viewContext
            return context;
        }
        return nil;
    }
    
}
