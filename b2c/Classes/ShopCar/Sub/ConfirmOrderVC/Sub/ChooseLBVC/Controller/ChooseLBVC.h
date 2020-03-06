//
//  ChooseLBVC.h
//  b2c
//
//  Created by wangyuanfei on 16/5/17.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "SecondBaseVC.h"
@protocol ChooseLBVCDelegate <NSObject>

-(void)chooseLBCount:(NSUInteger)lbCount;

@end

@interface ChooseLBVC : SecondBaseVC
@property(nonatomic,weak)id <ChooseLBVCDelegate> ChooseLBDelegate ;
@property(nonatomic,assign)NSUInteger  lb ;
@end
