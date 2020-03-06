//
//  SkipManager.m
//  TTmall
//
//  Created by wangyuanfei on 15/12/18.
//  Copyright © 2015年 Footway tech. All rights reserved.
//

#import "SkipManager.h"
#import "LoginNavVC.h"
#import "BaseWebVC.h"

//#import "SearchFLayout.h"
//#import "SearchVC.h"
//#import "ProfileBaseVC.h"
//#import "DemoVC.h"

#import "b2c-Swift.h"

@implementation SkipManager
/** 初始化方法 */
+(instancetype)shareSkipManager{
    static id temp = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        temp = [[SkipManager alloc]init];
    });
    return temp;
}

/** 全局跳转方法 */
-(void)skipByVC:(UIViewController*)vc withActionModel:(BaseModel*)model{
    //    LOG(@"_%@_%d跳转到_%@",[self class] , __LINE__,model.title)
        LOG(@"_%@_%d_控制器类名 :%@,控制器标题:%@ :",[self class] , __LINE__,model.actionKey,model.title)
    if (model.judge) {
        if ([UserInfo shareUserInfo].isLogin) {
            [self performForHomeActionWithViewController:vc andModel:model];
        }else{
            LoginNavVC * loginVC  = [[LoginNavVC alloc]initLoginNavVC];
//            [[KeyVC shareKeyVC] presentViewController:loginVC animated:YES completion:nil];
            [[GDKeyVC share] presentViewController:loginVC animated:YES completion:nil];

        }
    }else{
        if ([model.actionKey isEqualToString:@"gotoLao"]) {
            [[GDKeyVC share] selectChildViewControllerIndexWithIndex:2];
        }else{
             [self performForHomeActionWithViewController:vc andModel:model];
        }
       
    }
}
/** 抽取 */
-(void)performForHomeActionWithViewController:(UIViewController*)vc andModel:(BaseModel*)model
{
 
    Class class = NSClassFromString(model.actionKey);
    SecondBaseVC * destination = [[class alloc]init];
    destination.keyParamete = model.keyParamete;//控制器初始化时所需的关键参数
    destination.naviTitle = model.title;//根据这个key做相应的跳转//可改
//    [vc.navigationController pushViewController:destination animated:YES];
    
    
     if ([vc isKindOfClass:[KeyVC class]] || [vc isKindOfClass:[GDKeyVC class]]){
        [(UINavigationController*)vc pushViewController:destination animated:YES];
    }else if ([vc isKindOfClass:[UIViewController class]]) {
        [vc.navigationController pushViewController:destination animated:YES];
    }
    LOG(@"_%@_%d_%@",[self class] , __LINE__,model.actionKey)
}










































































































/** 目前是给首页点击跳到web端的方法*/
//-(void)skipToWebViewByVC:(UIViewController*)vc withActionModel:(BaseModel*)model{
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,model.originURL);
//    BaseWebVC * webVC = [[BaseWebVC alloc]initWithURLStr:model.originURL];
//    
//    [vc.navigationController pushViewController:webVC animated:YES];
//}

//
//-(void)skipByVC:(UIViewController*)vc urlStr:(NSString *)urlStr title:(NSString *)titleStr action:(NSString *)action{
//    
//    
////    LOG(@"_%@_%d_%d",[self class] , __LINE__,vc.navigationController.childViewControllers.count)
//    Class class = NSClassFromString(action);
//    UIViewController * destination = [[class alloc]init];
//    
//    
//    if ([action isEqualToString:@"SearchVC"]) {
////        SearchFLayout * layout = [[SearchFLayout alloc]init];
////        destination = [[class alloc]initWithCollectionViewLayout:layout];
//        [vc.navigationController pushViewController:destination animated:NO];
//
//    }else{
//        [vc.navigationController pushViewController:destination animated:YES];
////        LOG(@"_%@_%d_%@",[self class] , __LINE__,destination.navigationController)
//    }
//
//
//}
//
//-(void)skipByVC:(UIViewController*)vc withUserInfo:(NSDictionary*)userInfo{
//    
//    
//    //    LOG(@"_%@_%d_%d",[self class] , __LINE__,vc.navigationController.childViewControllers.count)
//#pragma mark 判断是否登录,做出相应的跳转
//    NSString * action = userInfo[@"action"];
//    Class class = NSClassFromString(action);
//    UIViewController * destination = [[class alloc]init];
//    [destination setValue:userInfo forKey:@"GDuserInfo"];
//    
//    
//    if ([action isEqualToString:@"SearchVC"]) {
////        SearchFLayout * layout = [[SearchFLayout alloc]init];
////        destination = [[class alloc]initWithCollectionViewLayout:layout];
//        [vc.navigationController pushViewController:destination animated:NO];
//        
//    }else{
//        [vc.navigationController pushViewController:destination animated:YES];
////        LOG(@"_%@_%d_%@",[self class] , __LINE__,destination.navigationController)
//    }
//    
//    
//}
/*
-(void)skipByVC:(UIViewController*)vc urlStr:(NSString *)urlStr title:(NSString *)titleStr action:(NSString *)action{
    
    
    //    LOG(@"_%@_%d_%d",[self class] , __LINE__,vc.navigationController.childViewControllers.count)
    Class class = NSClassFromString(action);
    UIViewController * destination = [[class alloc]init];
    
    
    if ([action isEqualToString:@"SearchVC"]) {
        //        SearchFLayout * layout = [[SearchFLayout alloc]init];
        //        destination = [[class alloc]initWithCollectionViewLayout:layout];
        [vc.navigationController pushViewController:destination animated:NO];
        
    }else{
        [vc.navigationController pushViewController:destination animated:YES];
        //        LOG(@"_%@_%d_%@",[self class] , __LINE__,destination.navigationController)
    }
    
    
}
 */


//-(void)skipByVC:(UIViewController*)vc urlStr:(NSString *)urlStr title:(NSString *)titleStr action:(NSString *)action{
//    
//    
//    //    LOG(@"_%@_%d_%d",[self class] , __LINE__,vc.navigationController.childViewControllers.count)
//    Class class = NSClassFromString(action);
//    UIViewController * destination = [[class alloc]init];
//    
//    
//    if ([action isEqualToString:@"SearchVC"]) {
//        //        SearchFLayout * layout = [[SearchFLayout alloc]init];
//        //        destination = [[class alloc]initWithCollectionViewLayout:layout];
//        [[KeyVC shareKeyVC] pushViewController:destination animated:NO];
//        
//    }else{
//        [[KeyVC shareKeyVC] pushViewController:destination animated:YES];
//        //        LOG(@"_%@_%d_%@",[self class] , __LINE__,destination.navigationController)
//    }
//    
//    
//}
/*
-(void)skipByVC:(UIViewController*)vc withUserInfo:(NSDictionary*)userInfo{
    
    
    //    LOG(@"_%@_%d_%d",[self class] , __LINE__,vc.navigationController.childViewControllers.count)
#pragma mark 判断是否登录,做出相应的跳转TODO
    NSString * action = userInfo[@"action"];
    Class class = NSClassFromString(action);
    UIViewController * destination = [[class alloc]init];
//    [destination setValue:userInfo forKey:@"GDuserInfo"];
    
    
    if ([action isEqualToString:@"SearchVC"]) {
        //        SearchFLayout * layout = [[SearchFLayout alloc]init];
        //        destination = [[class alloc]initWithCollectionViewLayout:layout];
        [vc.navigationController pushViewController:destination animated:NO];
        
    }else{
        [vc.navigationController pushViewController:destination animated:YES];
        //        LOG(@"_%@_%d_%@",[self class] , __LINE__,destination.navigationController)
    }
    
    
}
*/
//////////////////////////
/** 目前是给本地跳转定制的跳转方法(actionKey是自己手动写的) */
//-(void)skipForLocalByVC:(UIViewController*)vc withActionModel:(BaseModel*)model{
//
//    if (model.judge) {
//        if ([UserInfo shareUserInfo].isLogin) {
//            [self performForHomeActionWithViewController:vc andModel:model];
//        }else{
//            LoginNavVC * loginVC  = [[LoginNavVC alloc]initLoginNavVC];
//            [[KeyVC shareKeyVC] presentViewController:loginVC animated:YES completion:nil];
//        }
//    }else{
//        [self performForHomeActionWithViewController:vc andModel:model];
//    }
//
//
//
//}
/////////////////////////
/** 目前是给首页跳转定制的跳转方法(actionKey是用的网络端的) */
//-(void)skipForHomeByVC:(UIViewController*)vc withActionModel:(BaseModel*)model{
//    if (model.judge) {
//        if ([UserInfo shareUserInfo].isLogin) {
//            [self performForHomeActionWithViewController:vc andModel:model];
//        }else{
//            LoginNavVC * loginVC  = [[LoginNavVC alloc]initLoginNavVC];
//            [[KeyVC shareKeyVC] presentViewController:loginVC animated:YES completion:nil];
//        }
//    }else{
//        [self performForHomeActionWithViewController:vc andModel:model];
//    }
//
//}

//-(void)performActionWithViewController:(UIViewController*)vc andModel:(BaseModel*)model
//{
////    NSString * temp = model.actionKey;
////    NSString * action = nil ;
////    NSString * subAction = [temp substringFromIndex:6];
////     action = [subAction stringByAppendingString:@"VC"];
//    Class class = NSClassFromString(model.actionKey);
//    SecondBaseVC * destination = [[class alloc]init];
//    //        destination.naviTitle = action;//根据这个key做相应的跳转
//    destination.naviTitle = model.title;//根据这个key做相应的跳转
//     [vc.navigationController pushViewController:destination animated:YES];
////    LOG(@"_%@_%d_%@",[self class] , __LINE__,action)
//}
///////首页网页跳转专用////////////


@end
