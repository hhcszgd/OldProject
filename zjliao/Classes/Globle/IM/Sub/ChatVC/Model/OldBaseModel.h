//
//  OldBaseModel.h
//  zjlao
//
//  Created by WY on 16/11/12.
//  Copyright © 2016年 com.16lao.zjlao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OldBaseModel : NSObject
//@property(nonatomic,assign)ActionType  actionType ;
@property(nonatomic,copy)NSString * actionKey ;
@property(nonatomic,copy)NSString * title ;
@property(nonatomic,copy)NSString * originURL ;
/** 控制器初始化时所需要的字典类型的参数 , 字典里就一个键值对 其中键是paramete 与控制器相对应*/
@property(nonatomic,strong)NSDictionary * keyParamete ;
/** 是否需要判断是否登录 默认是NO */
@property(nonatomic,assign)BOOL  judge ;
-(instancetype)initWithDict:(NSDictionary*)dict ;
@end
