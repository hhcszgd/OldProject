//
//  MessageCenterCell.h
//  b2c
//
//  Created by wangyuanfei on 16/5/10.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "OldBaseCell.h"
@class XMPPMessageArchiving_Contact_CoreDataObject;
@class MessageCenterCellModel;
@interface MessageCenterCell : OldBaseCell
@property(nonatomic,strong)MessageCenterCellModel * cellModel ;
@property(nonatomic,strong)NSDictionary * customCellModel ;

@property(nonatomic,strong)  XMPPMessageArchiving_Contact_CoreDataObject *contact ;


@end