//
//  POrderCellComposeModel.h
//  b2c
//
//  Created by wangyuanfei on 4/8/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
/**标题行的 子控件的模型(包含全部订单 , 我的资产的子控件 和 商品,店铺收藏控件) , 类命名有点不恰当sorry*/

#import "BaseModel.h"

@interface POrderCellComposeModel : BaseModel
/** 自定义字段 */
@property(nonatomic,strong)UIImage * topImage ;
@property(nonatomic,copy)NSString * botomTitle ;
@property(nonatomic,assign)NSInteger  cornerCount ;


/** 服务器字段 */

/** 后端返回字段description和name 要转成title*/

/** 网络返回的标识数量的字段有两个  num 和number  -_-! */
@property(nonatomic,copy)NSString * number ;

//@property(nonatomic,copy)NSString * actionkey ;父类的是actionKey 转一下
@property(nonatomic,copy)NSString * url ;

-(instancetype)initWithDict:(NSDictionary*)dict;
@end
