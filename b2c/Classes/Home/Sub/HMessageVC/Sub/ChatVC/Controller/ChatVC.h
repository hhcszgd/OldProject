//
//  ChatVC.h
//  b2c
//
//  Created by wangyuanfei on 16/5/11.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "SecondBaseVC.h"
@class XMPPJID;
@interface ChatVC : SecondBaseVC

@property (nonatomic , strong)XMPPJID *UserJid;
@end
