//
//  HCellModel.h
//  b2c
//
//  Created by wangyuanfei on 16/4/13.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HBaseModel.h"

@interface HCellModel : HBaseModel
/**一个包含多个compost模型的数组*/
@property(nonatomic,strong)NSMutableArray * items ;
/** 频道名 */
@property(nonatomic,copy)NSString * channel ;
/** 类名 */
@property(nonatomic,copy)NSString * classKey ;
/** 图片链接 */
@property(nonatomic,copy)NSString  *  imgStr ;
/**数据分析的时候判断是否需要更新本地的图片缓存*/
@property (nonatomic, assign) BOOL isRefreshImageCached;

/** actionKay 父类有了 */
/** 主题颜色 */
@property(nonatomic,copy)NSString * color ;

-(instancetype)initWithDict:(NSDictionary*)dict;
@end
