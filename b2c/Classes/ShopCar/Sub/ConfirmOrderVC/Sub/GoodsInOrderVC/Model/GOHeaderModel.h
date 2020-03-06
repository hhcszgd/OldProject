//
//  GOHeaderModel.h
//  b2c
//
//  Created by wangyuanfei on 16/5/18.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "BaseModel.h"

@interface GOHeaderModel : BaseModel
/** 店铺名字 */
@property(nonatomic,copy)NSString * name ;
/** 运费 */
@property(nonatomic,copy  )NSString * shopFreight ;
/** 商品 */
@property(nonatomic,strong)NSArray * list ;
-(instancetype)initWithDict:(NSDictionary*)dict;
@end
