/*********************************************************************************
 * 版权所有,2017,lisir.
 * Copyright(C),lisir, LTD.All rights reserved.
 * project:
 * Author:lisir
 * Date:  17/05/27
 * QQ/Tel/Mail:
 * Description:程序提示
 * Others:
 * Modifier:
 * Reason:
 **********************************************************************************/

import UIKit
import Toaster

class PwToast: NSObject {
    
    class func showToast(text:String?){
        let t = Toast.init(text:text , delay: 0, duration: 2);
        t.show();
    }

}
