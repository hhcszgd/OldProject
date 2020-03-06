//
//  GoodsModel.h
//  b2c
//
//  Created by 0 on 16/4/12.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "BaseModel.h"

@interface GoodsModel : BaseModel
/** id */
@property(nonatomic,assign)NSInteger  ID ;
/** 图片(对应服务器数据的img字段,背景图,产品图,品牌logo全用这一个字段) */
@property(nonatomic,copy)NSString * imgStr ;
/** 标题字段1 */
@property(nonatomic,copy)NSString * full_name ;
/** 价格 */
@property(nonatomic,assign)CGFloat  price ;

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

-(instancetype)initWithDict:(NSDictionary*)dict;
@end
