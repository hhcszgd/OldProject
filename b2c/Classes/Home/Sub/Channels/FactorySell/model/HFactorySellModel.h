//
//  HFactorySellModel.h
//  b2c
//
//  Created by 0 on 16/5/1.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HFactoryBaseModel.h"

@interface HFactorySellModel : HFactoryBaseModel
@property (nonatomic, copy) NSString *channel;
@property (nonatomic, copy) NSString *key;
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *actioney;

@end
