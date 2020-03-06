//
//  OldSkipManager.m
//  zjlao
//
//  Created by WY on 16/11/11.
//  Copyright © 2016年 com.16lao.zjlao. All rights reserved.
//

#import "OldSkipManager.h"
#import "SecondBaseVC.h"
@implementation OldSkipManager
/** 初始化方法 */
+(instancetype)shareSkipManager{
    static id temp = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        temp = [[OldSkipManager alloc]init];
    });
    return temp;
}

/** 全局跳转方法 */
-(void)skipByVC:(UIViewController*)vc withActionModel:(OldBaseModel*)model{
    //    LOG(@"_%@_%d跳转到_%@",[self class] , __LINE__,model.title)
    NSLog(@"_%@_%d_控制器类名 :%@,控制器标题:%@ :",[self class] , __LINE__,model.actionKey,model.title);
//    if (model.judge) {
//        if ([UserInfo shareUserInfo].isLogin) {
//            [self performForHomeActionWithViewController:vc andModel:model];
//        }else{
//            LoginNavVC * loginVC  = [[LoginNavVC alloc]initLoginNavVC];
//            [[KeyVC shareKeyVC] presentViewController:loginVC animated:YES completion:nil];
//        }
//    }else{
        [self performForHomeActionWithViewController:vc andModel:model];
//    }
}
/** 抽取 */
-(void)performForHomeActionWithViewController:(UIViewController*)vc andModel:(OldBaseModel*)model
{
    
    Class class = NSClassFromString(model.actionKey);
    SecondBaseVC * destination = [[class alloc]init];
    destination.keyParamete = model.keyParamete;//控制器初始化时所需的关键参数
    destination.naviTitle = model.title;//根据这个key做相应的跳转//可改
    [vc.navigationController pushViewController:destination animated:YES];
    NSLog(@"_%@_%d_%@",[self class] , __LINE__,model.actionKey);
}






@end
