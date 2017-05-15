/*********************************************************************************
 * 版权所有,2017,lisir.
 * Copyright(C),lisir, LTD.All rights reserved.
 * project:
 * Author:lisir
 * Date:  17/05/11
 * QQ/Tel/Mail:
 * Description:app的开启钥匙
 * Others:
 * Modifier:
 * Reason:
 **********************************************************************************/

import Foundation
import CoreData

extension AppKey {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AppKey> {
        return NSFetchRequest<AppKey>(entityName: "AppKey");
    }

    @NSManaged public var openid: String?

    public override func awakeFromInsert() {
        openid = "test";
    }
}
