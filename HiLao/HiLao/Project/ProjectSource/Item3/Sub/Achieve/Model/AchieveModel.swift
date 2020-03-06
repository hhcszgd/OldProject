//
//  AchieveModel.swift
//  Project
//
//  Created by 张凯强 on 2017/12/19.
//  Copyright © 2017年 HHCSZGD. All rights reserved.
//

import UIKit
import HandyJSON
class AchieveModel<T: HandyJSON>: GDModel {
    var info: [T]?
    var haveAchi: Int?
    var noHaveAchi: Int?
}
class AchieveInfoModel: GDModel {
    var aId: String?
    var aName: String?
    var aSmallImg: String?
    var aImage: String?
    var aDesc: String?
    override func mapping(mapper: HelpingMapper) {
        mapper <<<
        self.aId <-- "achieve_id"
        mapper <<<
        self.aName <-- "achieve_name"
        mapper <<<
        self.aSmallImg <-- "achieve_smallimg"
        mapper <<<
        self.aImage <-- "achieve_image"
        mapper <<<
        self.aDesc <-- "achieve_desc"
    }
    
}
