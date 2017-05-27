/*********************************************************************************
 * 版权所有,2017,lisir.
 * Copyright(C),lisir, LTD.All rights reserved.
 * project:
 * Author:lisir
 * Date:  17/05/12
 * QQ/Tel/Mail:
 * Description:类似于iphone手机密码输入
 * Others:
 * Modifier:
 * Reason:
 **********************************************************************************/

import UIKit
import SnapKit

class PwSecureView: UIView {

    private var stack:UIStackView!
    private lazy var shapes = Array<CAShapeLayer>();
    let limit = 4;//限制有多少个
    var secureStr:String?{
        didSet{
            guard let temp = secureStr else { return };
            let count = temp.characters.count;
            let index = count - 1;
            resetFillColor(index: index, clearOrSet: false)
        }
    }
    private var delete:UIButton!//删除按钮
    
    override func awakeFromNib() {
        setUpSubviews();
    }

    private func setUpSubviews(){
        let tBlock:(()->UIView) = {
            let t = UIView();
            t.backgroundColor = UIColor.clear;
            return t;
        }
        
        var list:[UIView] = [];
        for _ in 0 ..< limit {
            let temp = tBlock();
            list.append(temp)
        }
        
        stack = UIStackView.init(arrangedSubviews: list)
        stack.spacing = 1;
        stack.distribution = .fillEqually;
        addSubview(stack)
        stack.snp.makeConstraints { (make) in
            make.edges.equalToSuperview();
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let list = stack.arrangedSubviews;
        
        let _ = shapes.map { (tem:CAShapeLayer)  in
            tem.removeFromSuperlayer();
        }
        shapes.removeAll();
        
        for item in list {
            let width = item.bounds.width;
            let height = item.bounds.height;
            let point = CGPoint.init(x: width / 2.0, y: height / 2.0)
            let path = UIBezierPath.init(arcCenter: point, radius: 5.0, startAngle: 0, endAngle: CGFloat(2.0 * .pi), clockwise: true)
            let shape = CAShapeLayer();
            shape.path = path.cgPath;
            shape.fillColor = UIColor.clear.cgColor;
            shape.strokeColor = UIColor.lightGray.cgColor;
            shape.opacity = 0.5;
            shape.lineWidth = 2.0;
            item.layer.addSublayer(shape)
            shapes.append(shape);
        }
    }
    /// 设置某个位置的fillcolor
    /// - Parameters:
    /// - index: shape的位置
    /// - clearOrSet: clearOrSet  true:清除颜色 false:设置颜色;
    func resetFillColor(index:Int,clearOrSet:Bool){
        if index < shapes.count {
            let temp = shapes[index];
            if clearOrSet {
                temp.fillColor = UIColor.clear.cgColor;
            }else{
                temp.fillColor = UIColor.lightGray.cgColor;
            }
        }else{
            assertionFailure("数组越界")
        }
    }
    //MARK:清除fillcolor的颜色
    func reClearAll(){
        let _ = shapes.map { (temp:CAShapeLayer)  in
            temp.fillColor = UIColor.clear.cgColor;
        }
        secureStr = nil;
    }
    //MARK:抖动
    func shake(){
        let animation = CAKeyframeAnimation()
        animation.keyPath = "transform.translation.x";
        animation.duration = 0.1;
        let delta = -10;
        animation.values = [0,delta,abs(delta),0]
        animation.repeatCount = 4;
        layer.add(animation, forKey: nil)
    }
    
}
