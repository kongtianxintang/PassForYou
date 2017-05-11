/*********************************************************************************
 * 版权所有,2017,lisir.
 * Copyright(C),lisir, LTD.All rights reserved.
 * project:
 * Author:lisir
 * Date:  17/05/09
 * QQ/Tel/Mail:
 * Description:进入程序的密码
 * Others:
 * Modifier:
 * Reason:
 **********************************************************************************/
import UIKit
import LocalAuthentication

class PwPasswordController: BaseViewController ,UICollectionViewDelegate,UICollectionViewDataSource{

    @IBOutlet weak var collectionview: UICollectionView!
    @IBOutlet weak var touchIcon: UIImageView!
    @IBOutlet weak var segmented: UISegmentedControl!
    
    
    //MARK:随机摆放 0-9 数据量太大不能用次方法
    private lazy var numbers : [Int] = {
        var list:[Int] = []
        while (list.count < 10){
            let t = Int(arc4random() % 10);
            if  !list.contains(t){
                list.append(t)
            }
        }
        return list;
    }();
    convenience init() {
        self.init(nibName: "PwPasswordController", bundle: nil)
    }
    private let reuseId = "number"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configCollectionview();
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK:collectionview相关
    private func configCollectionview(){
        collectionview.register(UINib.init(nibName: "PwNumberCell", bundle: nil), forCellWithReuseIdentifier: reuseId)
    }
    private func collectionviewAnimation(){
        let animation = CABasicAnimation.init(keyPath: "opacity")
        animation.toValue = 0.0;
        animation.fromValue = 1;
        animation.duration = 1.0;
        animation.isCumulative = true;
        collectionview.layer.add(animation, forKey: nil)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numbers.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseId, for: indexPath) as! PwNumberCell;
        let info = numbers[indexPath.row]
        cell.label.text = "\(info)";
        return cell;
    }
    
    
    //MARK:UISegmentedControl相关
    @IBAction func didClickSegmentedControl(_ sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex;
        switch index {
        case 0:
                hidenTouchIcon()
        default:
                hidenCollectionView()
            break;
        }
    }
    private func hidenTouchIcon(){
        touchIcon.isHidden = true;
        collectionview.isHidden = false;
    }
    private func hidenCollectionView(){
        collectionview.isHidden = true;
        touchIcon.isHidden = false;
        requestLocalAuthentication();
    }
    
    //MARK:TouchId 相关
    private func touchIconAanimation(){
        
    }
    
    private func requestLocalAuthentication(){
        //TODO:对用户取消/TouchID失败做处理
        let context = LAContext()
        let desc = "还可以通过TouchID进入哦"
        var error:NSError?
        let isCan = context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)
        if isCan {
            context.evaluatePolicy(LAPolicy.deviceOwnerAuthentication, localizedReason: desc, reply: { (success:Bool, err:Error?) in
                if success {
                    //TODO:验证成功
                    print("验证成功")
                }else{
                    if let laError = err as? LAError {
                        let errorCode = laError.code
                        switch errorCode {
                        case .authenticationFailed:
                            print("验证失败")
                        case .userCancel:
                            print("用户取消")
                        default:
                            break;
                        }
                    }
                }
            })
        }else{
            if let  tError = error as? LAError {
                switch tError.code {
                case .touchIDLockout:
                    print("touch被锁了,请稍等");
                case .passcodeNotSet:
                    print("没有录入指纹");
                default:
                    print("不支持");
                    break;
                }
            }
        }
    }
    
    
    
    
}
