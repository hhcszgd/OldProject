//
//  RegisterModel.swift
//  Project
//
//  Created by 张凯强 on 2017/12/6.
//  Copyright © 2017年 HHCSZGD. All rights reserved.
//

import UIKit
import HandyJSON
class RegisterModel: GDModel {
    var memberId: Int?
    var mobile: String?
    var email: String?
    var sex: Int?
    var creatAt: String?
    var saltCode: String?
    var name: String?
    var countryID: String?
    var countryCode: String?
    var id: Int?
    var token: String = ""
    var nickName: String?
    
    
    override func mapping(mapper: HelpingMapper) {
        mapper <<<
        self.memberId <-- "member_id"
        mapper <<<
        self.creatAt <-- "create_at"
        mapper <<<
        self.saltCode <-- "saltcode"
        mapper <<<
        self.countryID <-- "country_id"
        mapper <<<
        self.countryCode <-- "country_code"
        mapper <<<
        self.nickName <-- "nickname"
        
    }
}
