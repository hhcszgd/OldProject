//
//  GDGTPShopModel.swift
//  b2c
//
//  Created by 张凯强 on 2017/2/10.
//  Copyright © 2017年 www.16lao.com. All rights reserved.
//

import UIKit

class GDGTPShopModel: GDGoodsBaseModel {
    var img: String?
    var shop_name: String?
    var shop_id: String?
    var seller_login_name: String?
    var privateDic: [String: AnyObject]?
    override init(dict: [String : AnyObject]?) {
        privateDic = dict
        super.init(dict: dict)
    }
    override func setValue(_ value: Any?, forKey key: String) {
        if key ==  "items" {
            var shopSubArr: [GDGTPShopSubModel] = [GDGTPShopSubModel]()
            if let itemsArr = privateDic?["items"] as? [[String: AnyObject]] {
                for shopSubDic in itemsArr {
                    let shopSubModel = GDGTPShopSubModel.init(dict: shopSubDic)
                    shopSubArr.append(shopSubModel)
                }
                self.items = shopSubArr
            }
            return
        }
        super.setValue(value, forKey: key)
    }
    
}

class GDGTPShopSubModel: GDGoodsBaseModel {
    var name: String?
    var num: String?
}
