/*********************************************************************************
 * 版权所有,2017,lisir.
 * Copyright(C),lisir, LTD.All rights reserved.
 * project:
 * Author:lisir
 * Date:  17/06/06
 * QQ/Tel/Mail:
 * Description:账号详情和账号更新
 * Others:
 * Modifier:
 * Reason:
 **********************************************************************************/

import UIKit

class PwDetailController: PwAddController {

    var ac:Account?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configSaveButton();
        defalutData();
        title = "账号详情"
    }
    
    private func configSaveButton(){
        saveButton.setTitle("更新", for: .normal);
        mark.isHidden = true;
    }
    
    private func defalutData(){
        if let temp = ac {
            account.text = temp.id;
            password.text = temp.pw;
            company.text = temp.company;
            desc.text = temp.desc;
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    override func didClickSave(_ sender: UIButton) {
        
        if checkAccount() && checkCompany() && checkPassword() {
            let pw = password.text!
            let acstr = account.text!
            let com = company.text!
            if nil != ac {
                ac!.pw = pw;
                ac!.id = acstr
                ac!.company = com
                if let temp = desc.text , desc.text.count > 0{
                    ac!.desc = temp;
                }
                Account.coreDataSave(with: { [unowned self](isSave:Bool) in
                    if isSave {
                       let _ = self.navigationController?.popViewController(animated: true);
                    }
                })
            }
        }
    }
}
