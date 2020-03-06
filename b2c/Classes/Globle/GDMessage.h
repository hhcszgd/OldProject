//
//  GDMessage.h
//  b2c
//
//  Created by WY on 17/3/2.
//  Copyright © 2017年 www.16lao.com. All rights reserved.
//

//#import <XMPPFramework/XMPPFramework.h>
//#import  "XMPPMessage.h"
#import <Foundation/Foundation.h>
@interface GDMessage : NSObject
/** 0表示失败 , 1表示成功 */
@property(nonatomic,copy)NSString * isSuccess ;
/** 来自xmpp服务器的id */
@property(nonatomic,copy)NSString * serverID ;
/** 本地生成的id */
@property(nonatomic,copy)NSString * localID ;
/** 是否已读0是未读 , 1是已读 */
@property(nonatomic,copy)NSString * hasRead ;
/** 本地排序key */
@property(nonatomic,copy)NSString * sortKey ;
@property(nonatomic,copy)NSString * myAccount ;
@property(nonatomic,copy)NSString * otherAccount ;
@property(nonatomic,copy)NSString * fromAccount ;
@property(nonatomic,copy)NSString * toAccount ;
@property(nonatomic,copy)NSString * body ;
@property(nonatomic,copy)NSString* timeStamp ;
@property(nonatomic,copy)NSString* rowNumber ;//即数据表中的id
@end
