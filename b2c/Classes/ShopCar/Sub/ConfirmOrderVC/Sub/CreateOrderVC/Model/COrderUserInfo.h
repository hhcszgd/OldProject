//
//  COrderUserInfo.h
//  b2c
//
//  Created by 0 on 16/5/24.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "BaseModel.h"

@interface COrderUserInfo : BaseModel
@property (nonatomic, copy) NSString *key;
/**用户名*/
@property (nonatomic, copy) NSString *name;
/**电话*/
@property (nonatomic, copy) NSString *phone;
/**地址*/
@property (nonatomic, copy) NSString *address;
/**身份证号码*/
@property (nonatomic, copy) NSString *id_number;
@property (nonatomic, copy) NSString *is_display;
@end
