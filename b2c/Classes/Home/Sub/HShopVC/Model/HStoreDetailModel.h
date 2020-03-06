//
//  HStoreDetailModel.h
//  b2c
//
//  Created by 0 on 16/3/30.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HShopModel.h"
#import "BaseModel.h"
@interface HStoreDetailModel : BaseModel

/**标题*/
@property (nonatomic, copy) NSString *channel;
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, copy) NSString *key;
@property (nonatomic, copy) NSString *img;
/**卖家用户名*/
@property (nonatomic, copy) NSString *seller_login_name;
/**店铺内的信息*/
@property (nonatomic, strong)HShopModel *shop;


@end
