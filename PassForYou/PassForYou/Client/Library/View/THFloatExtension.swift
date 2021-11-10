/*
 @Description: float的扩展函数
 @Date:  2021/8/24
 */

// MARK: extension
extension Float {
    var radians: Float {
        return self * (Float(180) / Float.pi)
    }

    var degrees: Float {
        return self * Float.pi / 180.0
    }
}


