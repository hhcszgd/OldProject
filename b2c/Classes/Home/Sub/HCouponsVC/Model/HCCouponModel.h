//
//  HCCouponModel.h
//  b2c
//
//  Created by wangyuanfei on 16/5/4.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//
#import "BaseModel.h"
#import "HCellComposeModel.h"
//@class HCellComposeModel;
@interface HCCouponModel : HCellComposeModel
/** 是否已经领取 字段要根据服务器的字段来定 默认不选中*/
@property(nonatomic,assign)BOOL  take ;
/** 优惠券类型 ,  1：全站通用 2：指定商品 */
@property(nonatomic,copy)NSString * type ;
/**优惠券的名字*/
@property(nonatomic, copy) NSString *coupons_title;

///** 满多少可用此优惠券 */
//@property(nonatomic,copy)NSString * full_price ;
///** 优惠金额 */
//@property(nonatomic,copy)NSString * discount_price ;
///** title父类已有 */
//
///** 图片链接 */
//@property(nonatomic,copy)NSString  *  imgStr ;
///** actionKay 父类有了 */
//
//-(instancetype)initWithDict:(NSDictionary*)dict;
@end
