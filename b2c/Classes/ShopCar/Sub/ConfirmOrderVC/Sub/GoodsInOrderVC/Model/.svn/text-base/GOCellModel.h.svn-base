//
//  GOCellModel.h
//  b2c
//
//  Created by wangyuanfei on 16/5/18.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "BaseModel.h"
#import "SpecModel.h"

@interface GOCellModel : BaseModel
/** 商品图片链接 */
@property(nonatomic,copy)NSString * img ;
/** 商品描述 */
//@property(nonatomic,copy)NSString * shor_name ;
/** 商品属性(自加字段) */
@property(nonatomic,copy)NSString * attribute ;
/** 商品属性(服务器字段) */
@property(nonatomic,strong)NSMutableArray<SpecModel*> * sub_items ;
/** 商品数量 */

@property(nonatomic,strong)NSNumber * number ;
/** 商品价格 */
@property(nonatomic,copy)NSString * shop_price ;
/** 是否显示灰线 */
@property(nonatomic,assign)BOOL  hiddenBottomLine ;
-(instancetype)initWithDict:(NSDictionary*)dict;
@end
