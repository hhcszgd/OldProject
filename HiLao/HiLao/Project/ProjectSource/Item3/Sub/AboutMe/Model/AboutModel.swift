//
//  AboutModel.swift
//  Project
//
//  Created by 张凯强 on 2017/12/15.
//  Copyright © 2017年 HHCSZGD. All rights reserved.
//

import UIKit
import HandyJSON
class AboutModel<T: HandyJSON>: GDModel {
    var commentContent: String?
    var commentID: Int?
    var createAt: String?
    var fromHeadImage: String?
    var fromMemberAchieve: [T]?
    var fromMemberID: Int?
    var fromMemberlevel: Int?
    var fromMemberNickname: String?
    var memberID: String?
    var messageType: Int?
    var replyContent: String?
    var replyID: Int?
    override func mapping(mapper: HelpingMapper) {
        mapper <<<
        self.commentContent <-- "comment_content"
        mapper <<<
        self.commentID <-- "comment_id"
        mapper <<<
        self.createAt <-- "create_at"
        mapper <<<
        self.fromHeadImage <-- "from_head_image"
        mapper <<<
        self.fromMemberAchieve <-- "from_member_achieve"
        mapper <<<
        self.fromMemberID <-- "from_member_id"
        mapper <<<
        self.fromMemberlevel <-- "from_member_level"
        mapper <<<
            self.fromMemberNickname <-- "from_member_nickname"
        mapper <<<
        self.memberID <-- "member_id"
        mapper <<<
        self.messageType <-- "message_type"
        mapper <<<
        self.replyContent <-- "reply_content"
        mapper <<<
        self.replyID <-- "reply_id"
    }
    required init() {
        super.init()
    }
}
///其他人的用户名和头像
class OtherMember: GDModel {
    var image: String?
    var name: String?
}
