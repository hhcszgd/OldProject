//
//  SVCGoods.h
//  TTmall
//
//  Created by wangyuanfei on 3/13/16.
//  Copyright © 2016 Footway tech. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SpecModel.h"
typedef enum : NSUInteger {
    ShopEditing ,
    AllEditing
} ShopingCellEditingStyle;

@interface SVCGoods : BaseModel<NSCopying>
/** 购物车中这个商品收藏了多少个 */
@property(nonatomic,assign)NSInteger  number ;
/** 图片链接 */
@property(nonatomic,copy)NSString * img ;
///** 正处在购物车中的商品的id , 在购物车中操作商品(删除,移除等)用的都是这个id */
@property(nonatomic,copy)NSString * ID ;
/** 单位为分的价格(服务器返回的 , 用来结算的) */
@property(nonatomic,assign)NSInteger  price ;
/** 单位为元的价格(用来本地显示的,根据price字段手动转换的) */
@property(nonatomic,copy)NSString * showPrice ;

//@property(nonatomic,copy)NSString  *  price ;
/** 购物车价格字段 */
//@property(nonatomic,assign)NSUInteger  shop_price ;
@property(nonatomic,assign)NSInteger  shop_price ;
/** 产品标题 */
//@property(nonatomic,copy)NSString * title ;//父类有
/** 当前商品的规格数组 , 数组里的键的字段spec_name  ,值得字段是spec_val */
@property(nonatomic,strong)NSArray<SpecModel*> * sub_items ;
/** 对应账号的member_ID */
@property(nonatomic,assign)NSInteger  member_id ;
/** 商品规格(颜色'尺寸) */
@property(nonatomic,copy)NSString * spec ;
/** 当前商品对应的店铺id */
@property(nonatomic,assign)NSInteger  shop_id ;
/** 商品id */
@property(nonatomic,assign)NSInteger  goods_id ;
/** gid商品id */
@property(nonatomic,copy)NSString * gid ;

/** 商品收藏列表中商品的id  (区别于goods_id) 取消商品收藏时给字段goods_id传的是这个值 */
@property(nonatomic,assign)NSInteger  goodsid ;
/** 创建时间(类型暂定为字符串) */
@property(nonatomic,copy)NSString * create_at ;
/** 赠品goodsID (预留接口,自留 , 方便以后扩展) */
@property(nonatomic,assign)NSUInteger  giftGoodsID ;
/** 规格id */
@property(nonatomic,copy)NSString * sub_id ;
/** 库存1 */
@property(nonatomic,copy)NSString * stock ;
/** 库存2 */
@property(nonatomic,copy)NSString * sub_stock ;
-(instancetype)initWithDict:(NSDictionary *)dict;

/////////////////////////////////////////

@property(nonatomic,copy)NSString * productSizeOrColor ;
@property(nonatomic,strong)NSIndexPath * currentGoodsIndexPath ;
@property(nonatomic,assign)BOOL  goodsSelect ;
@property(nonatomic,assign)BOOL  showTicket ;
@property(nonatomic,assign)BOOL  goodsEditing ;//预留


@property(nonatomic,strong)NSArray * colors ;
@property(nonatomic,strong)UIColor * chooseColor ;
@property(nonatomic,strong)NSArray * sizes ;
@property(nonatomic,assign)CGFloat  chooseSize ;
@property(nonatomic,assign)NSInteger  storeCount ;
@property(nonatomic,strong)NSArray * productProperties ;
@property(nonatomic,assign) ShopingCellEditingStyle  shopingCellEditingStyle;
@end
