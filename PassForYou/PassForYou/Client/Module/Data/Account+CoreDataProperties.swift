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
import UIKit

extension Account {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Account> {
        return NSFetchRequest<Account>(entityName: "Account")
    }

    @NSManaged public var id: String?//账号名称
    @NSManaged public var pw: String?//密码
    @NSManaged public var company:String?//所注册的网站
    @NSManaged public var desc:String?//备注
    
    public override func awakeFromInsert() {
        id = "Unkonw"
        pw = "Unkonw"
        company = "Unkonw"
        desc = "Unkonw"
    }
    public override func awakeFromFetch() {
        if nil == id {
            id = "Unkonw"
        }
        if nil == pw {
            pw = "Unkonw"
        }
        if nil == company {
            company = "Unkonw"
        }
        if nil == desc {
            desc = "Unkonw";
        }
    }

    //MARK:获取富文本
    func getComAttributed()->NSAttributedString{
    
        let normal: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 17, weight: .regular),.foregroundColor: UIColor.darkGray]
        let min: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 12, weight: .regular),.foregroundColor: UIColor.gray]
        let com = NSMutableAttributedString.init(string: company!, attributes: normal);
        let name = NSAttributedString.init(string: "\n" + id!, attributes: min);
        com.append(name)
        return com;
    }
}
