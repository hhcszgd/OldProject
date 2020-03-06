//
//  ClassifyBaseVC.m
//  b2c
//
//  Created by wangyuanfei on 3/23/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "ClassifyBaseVC.h"
#import "b2c-Swift.h"
#import "LoginNavVC.h"
@interface ClassifyBaseVC ()

@end

@implementation ClassifyBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = BackgroundGray;
    [self configmentNavagation];
    // Do any additional setup after loading the view.
}
#pragma mark -- 设置导航栏
- (void)configmentNavagation{
    //导航栏颜色
    self.navigationBarColor = [UIColor colorWithHexString:@"ffffff"];
    //CGRect statusFrame = [[UIApplication sharedApplication] statusBarFrame];
    CSearchBtn *searchView = [[CSearchBtn alloc] initWithFrame:CGRectMake(10, 20 + 6, screenW - 10 - 39, 32)];
    
    [searchView addTarget:self action:@selector(actionToSearchView:) forControlEvents:UIControlEventTouchUpInside];
    searchView.titleStr = @"请输入您想找到的商品";
    self.navigationCustomView = searchView;
    //导航栏颜色
    self.navigationBarColor = [UIColor whiteColor];
    HNaviCompose * messageButton = [[HNaviCompose alloc]init];
    self.messageButton = messageButton;
    HCellComposeModel * messageModel = [[HCellComposeModel alloc]init ];
    messageModel.imgForLocal = [UIImage imageNamed:@"icon_news_gray"];
    //    messageModel.messageCountInCompose=[[[NSUserDefaults standardUserDefaults] objectForKey:MESSAGECOUNTCHANGED] integerValue];
    messageButton.composeModel  = messageModel;
    [messageButton addTarget:self action:@selector(message:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationBarRightActionViews = @[messageButton];
    
    
}
#pragma mark -- 跳转到搜索页面
- (void)actionToSearchView:(CSearchBtn *)searchBtn{
    LOG(@"%@,%d,%@",[self class], __LINE__,@"跳转到搜索页面")
}

-(void)messageCountChanged{
    
    
    if ([[NSThread currentThread] isMainThread]) {
        NSLog(@"main");
    } else {
        NSLog(@"not main");
    }
    [self.messageButton changeMessageCount];
    dispatch_async(dispatch_get_main_queue(), ^{
        //do your UI
        HCellComposeModel * messageModel = [[HCellComposeModel alloc]init ];
        messageModel.imgForLocal = [UIImage imageNamed:@"icon_news_gray"];
        NSInteger messageCount =  [[[NSUserDefaults standardUserDefaults] objectForKey:MESSAGECOUNTCHANGED] integerValue];
        //            messageModel.title  = @"消息";
        messageModel.messageCountInCompose=messageCount;
        self.messageButton.composeModel  = messageModel;
        
    });
    
    
}

-(void)messageHasChanged{ [self.messageButton changeMessageCount];}
-(void)message:(ActionBaseView*)sender
{
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"跳转消息控制器")
    if ([UserInfo shareUserInfo].isLogin) {
        HBaseModel*messageModel = [[HBaseModel alloc]init];
        
        
        //测试webView
        //            messageModel.actionKey=@"BaseWebVC";
        //            messageModel.keyParamete = @{
        //                                                @"paramete":@"https://m.baidu.com/?from=844b&vit=fps"
        //                                                };
        
        //正式的消息控制器
        messageModel.actionKey=@"FriendListVC";
        messageModel.judge = YES;
        
        [[SkipManager shareSkipManager] skipByVC:self withActionModel:messageModel ];
    }else{
        LoginNavVC *login = [[LoginNavVC alloc] initLoginNavVC];
        [[GDKeyVC share] presentViewController:login animated:YES  completion:nil ];
//        [[KeyVC shareKeyVC] presentViewController:login animated:YES completion:nil];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"fuck , 内存警告");
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
