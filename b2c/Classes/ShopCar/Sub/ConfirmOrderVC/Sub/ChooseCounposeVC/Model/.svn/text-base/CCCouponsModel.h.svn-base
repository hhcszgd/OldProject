//
//  CCCouponsModel.h
//  b2c
//
//  Created by wangyuanfei on 16/5/18.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "BaseModel.h"

@interface CCCouponsModel : BaseModel
/** 优惠券id */
@property(nonatomic,copy)NSString * cid ;

/** 优惠券是否可以被选中 */
@property(nonatomic,assign)BOOL  chooseEnable ;
/** 满多少 */
@property(nonatomic,copy)NSString * full_price ;
/** 减多少 */
@property(nonatomic,copy)NSString * discount_price ;
/** 所属店铺名字 */
@property(nonatomic,copy)NSString * shopName ;
/** 使用期限 */
@property(nonatomic,copy)NSString * start_time ;
@property(nonatomic,copy)NSString * end_time ;
@property(nonatomic,copy)NSString * timeLimit ;
/** 当前选中状态 */
@property(nonatomic,assign)BOOL  isSelect ;
/** 图片链接 */
@property(nonatomic,copy)NSString * img ;
-(instancetype)initWithDict:(NSDictionary*)dict;

@end
