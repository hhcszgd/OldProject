//
//  SpecSubItemsModel.h
//  b2c
//
//  Created by 张凯强 on 16/7/11.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "BaseModel.h"

@interface SpecSubItemsModel : BaseModel
/**规格内容*/
@property (nonatomic, strong) NSString *spec_val;
/**规格类型*/
@property (nonatomic, strong) NSString *spec_name;
@end
