/*********************************************************************************
 * 版权所有,2017,lisir.
 * Copyright(C),lisir, LTD.All rights reserved.
 * project:
 * Author:lisir
 * Date:  17/05/27
 * QQ/Tel/Mail:
 * Description:启动页面切换管理类
 * Others:
 * Modifier:
 * Reason:
 **********************************************************************************/

import UIKit

class PwDisplayManager: NSObject {

    static let shared = PwDisplayManager();
    
    func displayInputPassword(){
        let root = PwPasswordController();
         UIApplication.shared.keyWindow!.rootViewController = root;
    }
    
    func displayMain(){
        let root = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "root")
        UIApplication.shared.keyWindow!.rootViewController = root;
    }
    
}
