//
//  GDCaculateManager.swift
//  zjlao
//
//  Created by WY on 17/2/24.
//  Copyright © 2017年 com.16lao.zjlao. All rights reserved.
//

import UIKit

class GDCaculateManager: NSObject {
    
    
    
    private class  func caculateItemsHeight(itemsCount:Int ,itemHeight : CGFloat , columnCount:Int ) -> CGFloat {
        if  itemsCount % columnCount == 0 {
            let rows =  itemsCount / columnCount
            return CGFloat (rows + 1) * itemHeight
        }else {
            let rows =  itemsCount / columnCount
            return CGFloat (rows) * itemHeight
        }
    }
    
    
    
    class func newCaculateRowHeight(caculateModel : CaculateModel) -> (CGFloat){
        var   result : CGFloat = 0.0
        if caculateModel.itemCount == 0  {
            result  = caculateModel.topMargin  + caculateModel.headerHeight + caculateModel.toHeaderMargin + caculateModel.toFooterMargin + caculateModel.footerHeight + caculateModel.bottomMargin
        }else if caculateModel.itemCount == 1 {
            result  = caculateModel.topMargin  + caculateModel.headerHeight + caculateModel.toHeaderMargin + caculateModel.itemHeight + caculateModel.toFooterMargin + caculateModel.footerHeight + caculateModel.bottomMargin
            
        }else if caculateModel.itemCount > 1{
            let itemsTotalHeight = self.caculateItemsHeight(itemsCount: caculateModel.itemCount, itemHeight: caculateModel.itemHeight, columnCount: caculateModel.itemColumnCount)
            result  = caculateModel.topMargin  + caculateModel.headerHeight + caculateModel.toHeaderMargin + caculateModel.toFooterMargin + caculateModel.footerHeight + caculateModel.bottomMargin + itemsTotalHeight
        }
        return  result
    }
    
}


class CaculateModel: NSObject {
    var topMargin : CGFloat = 0
    var headerHeight : CGFloat  = 0
    var toHeaderMargin : CGFloat = 0
    var itemHeight : CGFloat = 0
    var itemCount : NSInteger = 0
    var itemMargin : CGFloat = 0
    var itemColumnCount : NSInteger = 1
    var toFooterMargin : CGFloat = 0
    var footerHeight : CGFloat = 0
    var bottomMargin : CGFloat = 0
    
    
}
