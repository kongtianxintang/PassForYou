/*********************************************************************************
 * 版权所有,2017,lisir.
 * Copyright(C),lisir, LTD.All rights reserved.
 * project:
 * Author:lisir
 * Date:  17/05/27
 * QQ/Tel/Mail:
 * Description:添加账号密码
 * Others:
 * Modifier:
 * Reason:
 **********************************************************************************/

import UIKit
import CoreData

class PwAddController: BaseViewController,UITextViewDelegate{

    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var account: UITextField!
    @IBOutlet weak var company: UITextField!
    @IBOutlet weak var desc: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var mark: UILabel!
    
    var addBlock:((_ ac:Account)->Void)?
    
    convenience init() {
        self.init(nibName:"PwAddController",bundle:Bundle.main)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configDesc();
        title = "添加账号"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    private func configDesc(){
        desc.layer.cornerRadius = 3;
        desc.layer.borderColor = UIColor.groupTableViewBackground.cgColor;
        desc.layer.borderWidth = 1;
    }
    
    @IBAction func didClickSave(_ sender: UIButton) {
        
        if checkAccount() && checkPassword() && checkCompany() {

            let pw = password.text!
            let ac = account.text!
            let com = company.text!
            guard let context = Account.returnContext() else {
                return;
            }
            if let entity = NSEntityDescription.insertNewObject(forEntityName: "Account", into: context) as? Account{
                entity.id = ac;
                entity.pw = pw;
                entity.company = com;
                if let  descStr = desc.text , desc.text.count > 0 {
                    entity.desc = descStr;
                }
                Account.coreDataSave(with: {[unowned self](isSave:Bool) in
                    if isSave {
                        PwToast.showToast(text: "保存成功")
                        if self.addBlock != nil {
                            self.addBlock!(entity);
                        }
                        let _ = self.navigationController?.popViewController(animated: true);
                    }else{
                        PwToast.showToast(text: "保存失败")
                    }
                })
            }else{
                assertionFailure("错误不能创建实体")
            }
        }
    }
    
    func checkPassword()->Bool{
        if let text = password.text {
            if text.count > 0 {
                return true;
            }
        }
        PwToast.showToast(text: "输入的密码为空")
        return false;
    }

    func checkAccount()->Bool{
        if let text = account.text {
            if text.count > 0 {
                return true;
            }
        }
        PwToast.showToast(text: "输入的账号为空")
        return false;
    }
    
    func checkCompany()->Bool{
        if let text = company.text {
            if text.count > 0 {
                return true;
            }
        }
        PwToast.showToast(text: "输入的账号类型为空")
        return false;
    }
    
    
    
    //MARK:UITextViewDelegate
    func textViewDidBeginEditing(_ textView: UITextView) {
        mark.isHidden = true;
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if let text = textView.text{
            if text.count > 0 {
                mark.isHidden = true;
            }else{
                mark.isHidden = false;
            }
        }
    }
    
}
