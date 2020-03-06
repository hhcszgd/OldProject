//
//  SCCellSubModel.h
//  b2c
//
//  Created by 0 on 16/4/8.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "BaseModel.h"

@interface SCCellSubModel : BaseModel
/**图片的地址*/
@property (nonatomic, copy) NSString *img;
/**价格*/
@property (nonatomic, copy) NSString *price;
/**是否还有更多*/
@property (nonatomic, assign) BOOL more;
@property (nonatomic, copy) NSString *actionkey;
@end
