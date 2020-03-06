//
//  ChatMsgBackView.h
//  b2c
//
//  Created by wangyuanfei on 6/28/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ChatMsgModel.h"
@interface ChatMsgBackView : UIView
@property(nonatomic,strong)ChatMsgModel * messageModel ;
@property(nonatomic,assign)BOOL  mine ;
@property(nonatomic,copy)NSString * textContent ;
@end
