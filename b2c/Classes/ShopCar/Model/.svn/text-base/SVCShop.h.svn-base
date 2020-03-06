//
//  SVCShop.h
//  TTmall
//
//  Created by wangyuanfei on 3/13/16.
//  Copyright © 2016 Footway tech. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SVCGoods;
@interface SVCShop : BaseModel
/** 店铺id */
@property(nonatomic,copy)NSString  *   shop_id ;
/** 店铺名称 */
@property(nonatomic,copy)NSString * name ;
/** 购物车中收藏的当前店铺的商品的集合 */
@property(nonatomic,strong)NSMutableArray * list ;
/** 优惠券 */
@property(nonatomic,strong)NSMutableArray * coupons ;//如果count大于0 , 店铺上的优惠券就显示, 否则隐藏
/** 是否有满减活动(自预留,方便扩展) */
@property(nonatomic,assign)BOOL  isManJian ;

-(instancetype)initWithDict:(NSDictionary *)dict;





//////////////////////////////////////////////

//@property(nonatomic,assign)BOOL  shopTicket ;
@property(nonatomic,assign)BOOL  shopSelect ;
@property(nonatomic,assign)BOOL  shopEditing ;//预留
//@property(nonatomic,assign)BOOL  shopEditButtonHidden ;

@end
