/*********************************************************************************
 * 版权所有,2017,lisir.
 * Copyright(C),lisir, LTD.All rights reserved.
 * project:
 * Author:lisir
 * Date:  17/05/10
 * QQ/Tel/Mail:
 * Description:数字cell
 * Others:
 * Modifier:
 * Reason:
 **********************************************************************************/

import UIKit

class PwNumberCell: UICollectionViewCell {

    @IBOutlet weak var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let minN = min(label.bounds.height, label.bounds.width) - 2.0;
        let midX = label.frame.width / 2.0;
        let midY = label.frame.height / 2.0;
        let point = CGPoint.init(x: midX, y: midY)
        let shape = CAShapeLayer()
        let path = UIBezierPath.init(arcCenter: point, radius: minN / 2.0, startAngle: 0, endAngle:CGFloat( 2.0 * M_PI), clockwise: false)
        shape.path = path.cgPath
        shape.fillColor = UIColor.clear.cgColor
        shape.strokeColor = UIColor.lightGray.cgColor
        shape.lineWidth = 2.0;
        shape.opacity = 0.5;
        label.layer.addSublayer(shape)
    }
    
   
}
