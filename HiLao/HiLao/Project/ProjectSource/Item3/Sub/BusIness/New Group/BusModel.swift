//
//  BusModel.swift
//  Project
//
//  Created by 张凯强 on 2017/12/20.
//  Copyright © 2017年 HHCSZGD. All rights reserved.
//

import UIKit
import HandyJSON

class BusModel: GDModel {
    var createAt: String?
    var image: String?
    var id: Int?
    var shopClassName: String?
    var shopName: String?
    var status: Int?
    
    override func mapping(mapper: HelpingMapper) {
        
       
        mapper <<<
            self.createAt <-- "create_at"
        mapper <<<
            self.image <-- "front_image"
        mapper <<<
            self.shopClassName <-- "shop_classify_name"
        mapper <<<
            self.shopName <-- "shop_name"
        
    }
    required init() {
        super.init()
    }
    
}
