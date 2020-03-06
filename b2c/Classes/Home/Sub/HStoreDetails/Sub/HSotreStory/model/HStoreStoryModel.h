//
//  HStoreStoryModel.h
//  b2c
//
//  Created by 0 on 16/4/1.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "BaseModel.h"

@interface HStoreStoryModel : BaseModel
/**故事名字*/
@property (nonatomic, copy) NSString *title;
/**查看次数*/
@property (nonatomic, copy) NSString *count;
/**时间*/
@property (nonatomic, copy) NSString *time;
@end
