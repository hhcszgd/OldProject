//
//  UContentModel.swift
//  Project
//
//  Created by 张凯强 on 2017/12/18.
//  Copyright © 2017年 HHCSZGD. All rights reserved.
//

import UIKit
import HandyJSON
class UContentModel<T: HandyJSON>: GDModel {
    var content: T?
    var commentID: Int?
    var createAt: String?
    var memberID: String?
    var messageType: Int?
    var relationID: Int?
    var title: String?
    
    override func mapping(mapper: HelpingMapper) {
        mapper <<<
            self.createAt <-- "create_at"
       
        mapper <<<
            self.memberID <-- "member_id"
        mapper <<<
            self.messageType <-- "message_type"
        mapper <<<
            self.relationID <-- "relation_id"
        
    }
    required init() {
        super.init()
    }
}
class ContentModel<T: HandyJSON>: GDModel {
    var content: String?
    var images: [T] = []
    var members: [T] = []
    var boardDesc: String?
    override func mapping(mapper: HelpingMapper) {
        mapper <<<
            self.boardDesc <-- "board_desc"
    }
}
class ImagesModel: GDModel {
    var image: String?
    var memberID: Int?
    var headerImage: String?
    override func mapping(mapper: HelpingMapper) {
        mapper <<<
        self.memberID <-- "member_id"
        mapper <<<
        self.headerImage <-- "hand_image"
    }
}
