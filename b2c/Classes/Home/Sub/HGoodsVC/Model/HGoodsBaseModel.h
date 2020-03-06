//
//  HGoodsBaseModel.h
//  b2c
//
//  Created by 0 on 16/5/8.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "BaseModel.h"

@interface HGoodsBaseModel : BaseModel
@property (nonatomic, copy) NSString *channel;
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, copy) NSString *key;

@end
