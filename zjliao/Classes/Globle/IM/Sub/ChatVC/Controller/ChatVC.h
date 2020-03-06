//
//  ChatVC.h
//  b2c
//
//  Created by wangyuanfei on 16/5/11.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "SecondBaseVC.h"

//#import "zjlao-Swift.h"

@class XMPPJID;
@interface ChatVC : SecondBaseVC
//@interface ChatVC : VCWithNaviBar

@property (nonatomic , strong)XMPPJID *UserJid;
@end
