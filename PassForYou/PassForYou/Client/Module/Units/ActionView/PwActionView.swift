/*********************************************************************************
 * 版权所有,2017,lisir.
 * Copyright(C),lisir, LTD.All rights reserved.
 * project:
 * Author:lisir
 * Date:  17/05/27
 * QQ/Tel/Mail:
 * Description:添加 按钮 页面
 * Others:
 * Modifier:
 * Reason:
 **********************************************************************************/

import UIKit

//MARK:点击事件类型
@objc enum PwActionType:Int8 {
    case Email,Add,Account
}
//MARK:代理协议
@objc protocol PwActionDelegate:NSObjectProtocol{
    func pwActionDidClickType(_ type:PwActionType);
}

class PwActionView: UIView {
 
    weak var delegate:PwActionDelegate?
    
    private lazy var email:UIButton = UIButton();
    private lazy var add:UIButton = UIButton();
    private lazy var account:UIButton = UIButton();
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        configCustom();
        setUpSubviews();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:配置普通属性
    private func configCustom(){
        backgroundColor = UIColor.clear;
    }
    //MARK:创建子视图
    private func setUpSubviews(){
    
        
        addSubview(add);
        add.setImage(UIImage.init(named: "add"), for: .normal);
        add.snp.makeConstraints { (make) in
            make.width.height.equalTo(44);
            make.bottom.equalToSuperview();
            make.right.equalToSuperview();
        }
        add.addTarget(self, action: #selector(addAction(_:)), for: .touchDown);
        
        email.setImage(UIImage.init(named: "email"), for: .normal);
        addSubview(email);
        email.snp.makeConstraints { (make) in
            make.width.height.equalTo(44);
            make.bottom.equalToSuperview();
            make.right.equalToSuperview();
        }
//        email.isHidden = true;
        email.addTarget(self, action: #selector(emailAction(_:)), for: .touchDown);
        
        account.setImage(UIImage.init(named: "account"), for: .normal);
        addSubview(account);
        account.snp.makeConstraints { (make) in
            make.width.height.equalTo(44);
            make.bottom.equalToSuperview();
            make.right.equalToSuperview();
        }
        account.isHidden = true;
        
    }
    
    @objc private func addAction(_ button:UIButton){
        print("添加");
        let anim = CABasicAnimation();
        anim.keyPath = "transform.rotation";
        anim.duration = 0.25;
        anim.fromValue = 0;
        anim.toValue =  Double.pi;
        button.layer.add(anim, forKey: nil);
        
        spreadAnimation();
    }
    
    @objc private func emailAction(_ button:UIButton){
        print("邮箱");
        if nil != delegate {
            delegate!.pwActionDidClickType(.Email);
        }
    }
    
    @objc private func accountAction(_ button:UIButton){
        print("账户");
        if nil != delegate {
            delegate!.pwActionDidClickType(.Account);
        }
    }
    
    //MARK:展开动画
    private func spreadAnimation(){
        email.isHidden = false;
        let startPoint = add.center;
        
        let p1 = createPoint(0);
        let p2 = createPoint(Double.pi / 6 * 2);
        let p3 = createPoint(Double.pi / 2);
        
        let ani = CABasicAnimation();
        ani.keyPath = "transform.translation"
        ani.fromValue = startPoint;
        ani.toValue = p1;
        ani.duration = 1.0;
        email.layer.add(ani, forKey: nil);
    }
    
    //MARK:回收动画
    private func recycleAnimation(){
        
    }
    
    private func createPoint(_ value:Double)->CGPoint{
        let width:Double =  Double( bounds.width - 44);
        let x = Double(bounds.maxX) - cos(value) * width
        let y = Double(bounds.maxY) - sin(value) * width
        return CGPoint.init(x: x, y: y);
    }
    
    
    
    
    
    
}
