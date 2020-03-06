//
//  PerformChatTool.h
//  b2c
//
//  Created by wangyuanfei on 16/5/12.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PerformChatTool;
@class ChatModel;
@protocol PerformChatToolDelegate <NSObject>

-(void)messageFromOthers:(ChatModel*)chatModel inChatTool:(PerformChatTool*)chatTool;

@end

@interface PerformChatTool : NSObject
@property(nonatomic,weak)id  <PerformChatToolDelegate> AcceptMessateDelegate ;
-(void) sendMessage:(NSString *)content usersId:(NSString *)usersId messageType:(int)messageType;
@end
