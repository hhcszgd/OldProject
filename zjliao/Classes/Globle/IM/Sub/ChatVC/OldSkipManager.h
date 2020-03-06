//
//  OldSkipManager.h
//  zjlao
//
//  Created by WY on 16/11/11.
//  Copyright © 2016年 com.16lao.zjlao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "OldBaseModel.h"
@interface OldSkipManager : NSObject
+(instancetype)shareSkipManager;
/** 全局跳转方法 */
-(void)skipByVC:(UIViewController*)vc withActionModel:(OldBaseModel*)model;




@end
