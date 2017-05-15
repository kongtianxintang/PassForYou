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
    @IBOutlet weak var secureView: PwSecureView!
    @IBOutlet weak var descLabel: UILabel!
    
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
        defaultData();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK:默认数据
    private func defaultData(){
        let keys = AppKey.fetchNSManagedObject(className: AppKey.classForCoder(), sortKey: "openid")
        if keys != nil,keys!.count > 0 {
            descLabel.text = "请输入密码"
            return;
        };
        descLabel.text = "输入4位数作为开启程序的密码"
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
        let text = "\(info)"
        cell.label.text = text;
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let info = numbers[indexPath.row]
        let str = "\(info)"
        let text = secureView.secureStr;
        if nil == text {   secureView.secureStr = str ; return; };
        let temp = text! + str;
        if temp.characters.count > secureView.limit { return; }
        secureView.secureStr = temp;
        
        if temp.characters.count == secureView.limit {
            
            //MARK:与本地的key对比是否相等
            let keys = AppKey.fetchNSManagedObject(className: AppKey.classForCoder(), sortKey: "openid")
            if nil == keys {  insertAppKey(key: temp) ;return };
            if keys!.count <= 0 {   insertAppKey(key: temp) ;return };
            let key = keys![0] as! AppKey
            if nil == key.openid { return };
            if temp == key.openid! {
                print("相等")
            }else{
                print("不相等")
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.05, execute: {[unowned self] _ in
                    self.descLabel.text = "再试一次";
                    self.secureView.shake();
                    self.secureView.reClearAll();
                })
            }
        }
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
        descLabel.isHidden = false;
        secureView.isHidden = false;
    }
    private func hidenCollectionView(){
        collectionview.isHidden = true;
        touchIcon.isHidden = false;
        descLabel.isHidden = true;
        secureView.isHidden = true;
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
    
    //MARK:插入个钥匙 key
    private func insertAppKey(key:String){
        if let entity = AppKey.createEntity(className: AppKey.classForCoder()) as? AppKey {
            entity.openid = key;
            AppKey.insert(object: entity)
        }else{
            assertionFailure("创建APPkey失败")
        }
    }
    
    
    
    
    
}
