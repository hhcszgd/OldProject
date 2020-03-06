//
//  AreaCode.swift
//  zuidilao
//
//  Created by 张凯强 on 2017/10/26.
//  Copyright © 2017年 张凯强. All rights reserved.
//

import Foundation
import HandyJSON
class AreaCodeModel: GDModel {
    var id: Int?
    var area: String?
    var name: String?

    override func mapping(mapper: HelpingMapper) {
        mapper <<<
        self.area <-- "area_name"
    }
}
