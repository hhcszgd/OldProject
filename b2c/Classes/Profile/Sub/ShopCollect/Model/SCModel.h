//
//  SCModel.h
//  b2c
//
//  Created by 0 on 16/4/8.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "BaseModel.h"

@interface SCModel : BaseModel
@property (nonatomic, copy) NSString *actionkey;
/**店铺全名*/
@property (nonatomic, copy) NSString *full_name;
@property (nonatomic, copy) NSString *Cell;
@property (nonatomic, assign) BOOL isShopCollectionDetailCell;
@property (nonatomic, strong) NSMutableArray *items;

//店铺标志
@property (nonatomic, copy) NSString *logo;


@end
