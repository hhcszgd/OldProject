//
//  MyTimer.m
//  b2c
//
//  Created by wangyuanfei on 16/5/6.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "MyTimer.h"

@implementation MyTimer
-(void)dealloc{
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"定时器被释放")

}
@end
