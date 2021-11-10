/*
 @Description:底部导航动画
 @Date:  2021/8/30
 */

import UIKit

/// 动画的方向
enum THMenuLoaderAlignment {
    case Left,Right
}

class THMenuLoaderView: UIView {
    //MARK: 属性
    private(set) var alignment: THMenuLoaderAlignment = .Left
    private lazy var mShape = CAShapeLayer()
    
    //MARK: 生命周期
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSubviews()
    }
    /// 自定义初始化
    convenience init(_ alignment: THMenuLoaderAlignment) {
        self.init()
        self.alignment = alignment
        setupSubviews()
    }
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        drawShpae()
    }
    
}
//MAKR: 私有方法
private extension THMenuLoaderView {
    //MARK: 布局 及 控件初始化
    func setupSubviews(){
        layer.addSublayer(mShape)
        mShape.strokeColor = UIColor.blue.cgColor
        mShape.fillColor = UIColor.clear.cgColor
        mShape.strokeEnd = 1
    }
    
    /// 绘制shape
    func drawShpae() {
        let size = bounds.size
        let start: CGPoint = CGPoint.init(x: 0, y: size.height / 2)
        let end: CGPoint = CGPoint.init(x: size.width, y: size.height / 2)
        let line = UIBezierPath()
        line.move(to: start)
        line.addLine(to: end)
        mShape.path = line.cgPath
        mShape.lineWidth = size.height
        mShape.lineCap = .round
    }
    
}

//MARK: 动画
extension THMenuLoaderView {
    /// 隐藏
    func hiddenAnimation(){
        let stroke = customize(CABasicAnimation(keyPath: "strokeStart")) {
            $0.fromValue = 0
            $0.toValue = 1
            $0.duration = 0.25
            $0.fillMode = .forwards
            $0.isRemovedOnCompletion = false
        }
        let strokeEnd = customize(CABasicAnimation(keyPath: "strokeEnd")) {
            $0.fromValue = 1
            $0.toValue = 0
            $0.duration = 0.25
            $0.fillMode = .forwards
            $0.isRemovedOnCompletion = false
        }
        let ani = alignment == .Left ? stroke: strokeEnd
        mShape.add(ani, forKey: nil)
    }
    /// 显示
    func showAnimation(){
        let stroke = customize(CABasicAnimation(keyPath: "strokeStart")) {
            $0.fromValue = 1
            $0.toValue = 0
            $0.duration = 0.25
            $0.fillMode = .forwards
            $0.isRemovedOnCompletion = false
        }
        let strokeEnd = customize(CABasicAnimation(keyPath: "strokeEnd")) {
            $0.fromValue = 0
            $0.toValue = 1
            $0.duration = 0.25
            $0.fillMode = .forwards
            $0.isRemovedOnCompletion = false
        }
        let ani = alignment == .Left ? stroke: strokeEnd
        mShape.add(ani, forKey: nil)
    }
}
