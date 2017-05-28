/*********************************************************************************
 * 版权所有,2017,lisir.
 * Copyright(C),lisir, LTD.All rights reserved.
 * project:
 * Author:lisir
 * Date:  17/05/09
 * QQ/Tel/Mail:
 * Description:基础UITabBarController类
 * Others:
 * Modifier:
 * Reason:
 **********************************************************************************/

import UIKit

class BaseTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        #if DEBUG
            debugPrint("deinit \(self.classForCoder)")
        #else
        #endif
    }

}
