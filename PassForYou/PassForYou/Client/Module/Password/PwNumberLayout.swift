/*********************************************************************************
 * 版权所有,2017,lisir.
 * Copyright(C),lisir, LTD.All rights reserved.
 * project:
 * Author:lisir
 * Date:  17/05/10
 * QQ/Tel/Mail:
 * Description:数据布局~ 0 到 9 展示
 * Others:
 * Modifier:
 * Reason:
 **********************************************************************************/

import UIKit

class PwNumberLayout: UICollectionViewFlowLayout {
    private var itemY:CGFloat = 0;
    private var itemX:CGFloat = 0;
    private var maxW:CGFloat = 0.0;
    private var list:Array<UICollectionViewLayoutAttributes>?
    private var itemWidth:CGFloat = 0.0;
    private var itemHeight:CGFloat = 0.0;
    private var last:Bool = false;
    override func prepare() {
        super.prepare()
        guard let collectionview = self.collectionView else {   return  };
        itemX = 0;
        itemY = 0;
        last = false;
        itemWidth = collectionview.bounds.width / 3.0;
        itemHeight = collectionview.bounds.height / 4.0;
        maxW = collectionview.bounds.maxX
        let sections = collectionview.numberOfSections
        var tList = Array<UICollectionViewLayoutAttributes>()
        for i in 0 ..< sections {
            let rows = collectionview.numberOfItems(inSection: i)
            for j in 0 ..< rows {
                let indexpath = IndexPath.init(row: j, section: i)
                if j == rows - 1 {
                    last = true;
                }
                let att = layoutAttributesForItem(at: indexpath)
                if nil != att {
                    tList.append(att!)
                }
            }
        }
        self.list = tList
    }
    
    //MARK:每个cell的坐标和大小
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {

        let att = UICollectionViewLayoutAttributes.init(forCellWith: indexPath)
        att.size = CGSize.init(width: itemWidth, height: itemHeight)
        
        let tempX = itemX + itemWidth ;
        if tempX > maxW {
            itemY += itemHeight;
            itemX = 0;
        }
        var origin:CGPoint!
        if last {
            let midy = itemY + itemHeight / 2.0;
            let midx = maxW / 2.0;
            let itemCenter = CGPoint.init(x: midx, y: midy)
            att.center = itemCenter;
        }else{
            origin = CGPoint.init(x: itemX, y: itemY)
            att.frame.origin = origin
        }
        itemX += itemWidth;
        return att
    }
    //MARK:所有cell的坐标和大小
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return list
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize.init(width: 0, height: itemY + 64.0)
    }


}
