/*********************************************************************************
 * 版权所有,2017,lisir.
 * Copyright(C),lisir, LTD.All rights reserved.
 * project:
 * Author:lisir
 * Date:  17/05/27
 * QQ/Tel/Mail:
 * Description:保存在app中的账号密码
 * Others:
 * Modifier:
 * Reason:
 **********************************************************************************/

import Foundation
import CoreData


extension Account {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Account> {
        return NSFetchRequest<Account>(entityName: "Account")
    }

    @NSManaged public var id: String?//账号名称
    @NSManaged public var pw: String?//密码
    
    public override func awakeFromInsert() {
        id = "test"
        pw = "test"
    }

}
