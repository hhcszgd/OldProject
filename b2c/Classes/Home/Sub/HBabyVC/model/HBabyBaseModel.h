//
//  HBabyBaseModel.h
//  b2c
//
//  Created by 0 on 16/5/2.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "BaseModel.h"

@interface HBabyBaseModel : BaseModel
@property (nonatomic, copy) NSString *channel;

@property (nonatomic, copy) NSString *key;
@property (nonatomic, strong) NSMutableArray *items;
@end
