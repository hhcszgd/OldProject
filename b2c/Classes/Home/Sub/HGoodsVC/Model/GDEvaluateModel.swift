//
//  GDEvaluateModel.swift
//  b2c
//
//  Created by 张凯强 on 2017/2/9.
//  Copyright © 2017年 www.16lao.com. All rights reserved.
//

import UIKit

class GDEvaluateModel: GDGoodsBaseModel {
    var channel: String?
    var num: NSNumber?
    var privateDic: [String: AnyObject]?
    override init(dict: [String : AnyObject]?) {
        privateDic = dict
        super.init(dict: dict)
    }
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "items" {
            if let itemsArr = privateDic?["items"] as? [AnyObject] {
                var arr = [ZkqEvaluateModel]()
                for object in itemsArr {
                    if let objectDict = object as? [String: AnyObject] {
                        let evaluateModel = ZkqEvaluateModel.init(dict: objectDict)
                        arr.append(evaluateModel)
                    }
                    
                }
                self.items = arr
            }
            return
        }
        super.setValue(value, forKey: key)
    }
    
}


class ZkqEvaluateModel: GDGoodsBaseModel {
    var content: String?
    var img: String?
    var nick: String?
}
