//
//  HCellComposeModel.h
//  b2c
//
//  Created by wangyuanfei on 4/12/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "HBaseModel.h"

@interface HCellComposeModel : HBaseModel
/** id */
@property(nonatomic,copy)NSString *   ID ;
/** 店铺id  6月1号加 */
@property(nonatomic,copy)NSString * shop_id ;
/** 商品id 6月1号加*/
@property(nonatomic,copy)NSString * goods_id ;
/** 图片(对应服务器数据的img字段,背景图,产品图,品牌logo全用这一个字段) */
@property(nonatomic,copy)NSString * imgStr ;
/** 要跳转到得链接页面(个别页面有)(在首页的轮播图还充当店铺/商品id的角色) */
@property(nonatomic,copy)NSString * link ;
/** fuck还有的是url */
@property(nonatomic,copy)NSString * url ;
/** 标题字段1 */
@property(nonatomic,copy)NSString * full_name ;
/** 标题字段2 */
@property(nonatomic,copy)NSString * short_name ;

/** 单位为分的价格(服务器返回的 , 用来结算的) */
@property(nonatomic,copy)NSString * price ;
/** 单位为元的价格(用来本地显示的,根据price字段手动转换的) */
@property(nonatomic,copy)NSString * showPrice ;
/** 店铺价 6月加(基本不用) */
@property(nonatomic,copy)NSString * shop_price ;
/** 字体或主题颜色 */
@property(nonatomic,strong)UIColor * theamColor ;
/** 主题文字 (如包邮, 热卖) */
@property(nonatomic,copy)NSString * theamtit ;
/** actionKay 父类有了 */
/** 八个导航模块儿的标题 */
//@property(nonatomic,copy)NSString * title ;
/** 子标题*/
@property(nonatomic,copy)NSString * subtitle ;
/** 分类名 */
@property(nonatomic,copy)NSString * classify_name ;
/** 优惠券金额 */
@property(nonatomic,copy)NSString * discount_price ;
/** 优惠券id */
@property(nonatomic,copy)NSString *  coupons_id   ;
/** 优惠券满多少可用 */
@property(nonatomic,copy)NSString * full_price ;
/** 优惠券结束时间 */
@property(nonatomic,copy)NSString * end_time ;
/** 优惠券开始时间 */
@property(nonatomic,copy)NSString * start_time ;
/** 消息数量(含聊天,发货, 待收货, 待评价,等等) */
@property(nonatomic,assign)NSUInteger messageCountInCompose ;
/** 图片(自定义,用于扫一扫和消息) */
@property(nonatomic,strong)UIImage * imgForLocal ;
/**数据分析的时候判断是否需要更新本地的图片缓存*/
@property (nonatomic, assign) BOOL isRefreshImageCached;

/** 销量() */
@property(nonatomic,copy)NSString * sales_month ;
/**跳转的关键参数*/
@property (nonatomic, copy) NSString *value;

-(instancetype)initWithDict:(NSDictionary*)dict;
@end
