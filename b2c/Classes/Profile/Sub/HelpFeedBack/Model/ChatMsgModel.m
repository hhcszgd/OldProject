//
//  ChatMsgModel.m
//  b2c
//
//  Created by wangyuanfei on 6/28/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "ChatMsgModel.h"

@implementation ChatMsgModel
/** @property(nonatomic,copy)NSString * userIcon ;
 @property(nonatomic,copy)NSString * chatTime ;
 @property(nonatomic,copy)NSString * chatImgStr ;
 @property(nonatomic,copy)NSString * chatTextContent ;
 @property(nonatomic,copy)NSString * chatDataMessage ;
 */
-(instancetype)init{
    if (self = [super init]) {
        self.userIcon = @"me";
        self.chatTime = @"2016-12-12 20:20";
        self.title  = @"IM在线客服";
        self.chatTextContent = @"我是最贴心的在线人工客服，您在一路捞的任何问题都可以向我咨询哦，不过人家也要休息的，您可以在每天的8:30-23:00找到我（节假日的时候我会加班加点的）";
    }

    return self;
}
@end
