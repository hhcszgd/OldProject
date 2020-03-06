//
//  CouponsDetailModel.h
//  b2c
//
//  Created by wangyuanfei on 16/5/7.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "BaseModel.h"

@interface CouponsDetailModel : BaseModel
/** 图片链接 */
@property(nonatomic,copy)NSString * img ;
/** 优惠券额度 */
@property(nonatomic,copy)NSString * discount_price ;
/** 店铺名 */
@property(nonatomic,copy)NSString * shop_name ;
/** 满多少可用 */
@property(nonatomic,copy)NSString * full_price ;
/** 优惠券生效时间 */
@property(nonatomic,copy)NSString * start_time ;
/** 优惠券失效时间 */
@property(nonatomic,copy)NSString * end_time ;
/** 优惠券总数 */
@property(nonatomic,copy)NSString * number ;
/** 已领取的人数 */
@property(nonatomic,copy)NSString * number_rec ;
/** 剩余数量 */
@property(nonatomic,copy)NSString* leftCount ;
/** 优惠券使用说明 */
@property(nonatomic,strong)NSArray * discription ;
/** 是否已经被领取 */
@property(nonatomic,assign)BOOL  take ;
/** shop_id */
@property(nonatomic,copy)NSString * shopID ;
-(instancetype)initWithDict:(NSDictionary*)dict;
@end
