//
//  PTableCellModel.h
//  b2c
//
//  Created by wangyuanfei on 3/30/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
/**每一个标题行的模型*/

#import "BaseModel.h"
@class POrderCellComposeModel;
@interface PTableCellModel : BaseModel

/** 自定义字段 */


@property(nonatomic,assign)BOOL arrowHidden ;
@property(nonatomic,strong)UIImage * leftImage ;
@property(nonatomic,copy)NSString * leftTitle ;
@property(nonatomic,copy)NSString * rightDetailTitle ;
@property(nonatomic,strong)UIImage * rightImage ;

/** 网络返回字段 */
/** 服务器返回字段用来显示标题channel  转换成title */
//@property(nonatomic,copy)NSString * channel ;//文字标题
@property(nonatomic,copy)NSString * key ;//标识 , 标志数据的不同
@property(nonatomic,strong)NSMutableArray<POrderCellComposeModel*> * items ;//子对象数组 , 可空
@property(nonatomic,copy)NSString * url ;//wap页面链接

-(instancetype)initWithDict:(NSDictionary*)dict;
@end
