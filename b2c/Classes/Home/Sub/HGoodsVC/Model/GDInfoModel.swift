//
//  GDInfoModel.swift
//  b2c
//
//  Created by 张凯强 on 2017/2/9.
//  Copyright © 2017年 www.16lao.com. All rights reserved.
//

import UIKit

class GDInfoModel: GDGoodsBaseModel {
    var privateDict: [String: AnyObject]?
    var now_time: String?
    var shelves_at: String?
    var short_name: String?
    var url: String?
    var freight: String?
    var price: String?
    var area: String?
    var sales_month: String?
    var goods_status: NSNumber?
    var security_range:[SecurityModel]?
    override init(dict: [String : AnyObject]?) {
        privateDict = dict
        super.init(dict: dict)
    }
    override func setValue(_ value: Any?, forKey key: String) {
        
        if key == "security_range" {
            if let security = privateDict?["security_range"] as? [AnyObject] {
                var securityArr = [SecurityModel]()
                for object in security {
                    if let dict =  object as? [String: AnyObject] {
                        let model = SecurityModel.init(dict: dict)
                        securityArr.append(model)
                    }
                    
                }
                security_range = securityArr
            }
            return
        }
        if key == "freight" {
            if let str = value as? String {
                self.freight = str
            }
            if let str = value as? NSNumber {
                self.freight = "\(str)"
            }
            return
        }
        super.setValue(value, forKey: key)
    }
}





class SecurityModel: GDGoodsBaseModel {
    var title: String?
    var icon: String?
    
    
}
