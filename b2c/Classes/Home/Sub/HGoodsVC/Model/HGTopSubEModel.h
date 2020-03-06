//
//  HGTopSubEModel.h
//  b2c
//
//  Created by 0 on 16/5/10.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "BaseModel.h"
#import "HGTopSubESubModel.h"
@interface HGTopSubEModel : BaseModel
@property (nonatomic, copy) NSString *key;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *number;
@property (nonatomic, copy) NSString *buydate;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *level;
@property (nonatomic, copy) NSString *pubdate;
@property (nonatomic, strong) NSMutableArray *spec;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, strong) HGTopSubESubModel *items;

@end
