//
//  ChannelWebVC.m
//  b2c
//
//  Created by 张凯强 on 2017/1/12.
//  Copyright © 2017年 www.16lao.com. All rights reserved.
//

#import "ChannelWebVC.h"
#import "b2c-Swift.h"


@interface ChannelWebVC ()


@end

@implementation ChannelWebVC
- (ShopCar *)shopCarBtn{
    if (_shopCarBtn == nil) {
        ShopCar *car = [[ShopCar alloc] initWithFrame:CGRectMake(0, 0, 44, 44) withNum:@"0"];
        [car addTarget:self action:@selector(toShopCar) forControlEvents:UIControlEventTouchUpInside];
        
        _shopCarBtn = car;
    }
    return _shopCarBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // Do any additional setup after loading the view.
}

- (void)toShopCar{
    BaseModel *baseModel = [[BaseModel alloc] init];
    baseModel.judge = YES;
    baseModel.actionKey = @"ShopCarVC";
    [[SkipManager shareSkipManager] skipByVC:self withActionModel:baseModel];
}
-(void)AddToShopCartSuccessInWapPage
{
    //更新按钮购物车数量
    [[UserInfo shareUserInfo] gotShopCarNumberSuccess:^(ResponseObject *responseObject) {
        [self.shopCarBtn editShopCarNumber:responseObject.data];
    } failure:^(NSError *error) {
    }];
}
#pragma maek -- 设置导航栏
- (void)configmentNavigation{
    //导航栏颜色
    self.navigationBarColor = [UIColor whiteColor];
    GDMsgIconView * messageButton = [[GDMsgIconView alloc]init];
    self.messageButton = messageButton;
    [messageButton.button setImage:[UIImage imageNamed:@"icon_news_gray"] forState:UIControlStateNormal];
//    messageButton.titleLabel.text = @"消息";
    //    messageModel.messageCountInCompose=[[[NSUserDefaults standardUserDefaults] objectForKey:MESSAGECOUNTCHANGED] integerValue];
    [messageButton.button addTarget:self action:@selector(message:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationBarRightActionViews = @[messageButton];
    
    
    
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    CGRect rect = [self.shopCarBtn convertRect:self.shopCarBtn.frame toView:window];
    self.shopCarIconFrame = rect;
    NSLog(@"%@, %d ,%@",[self class],__LINE__,NSStringFromCGRect(rect));

    if ([UserInfo shareUserInfo].isLogin) {
        //更新按钮购物车数量
        [[UserInfo shareUserInfo] gotShopCarNumberSuccess:^(ResponseObject *responseObject) {
            [self.shopCarBtn editShopCarNumber:responseObject.data];
        } failure:^(NSError *error) {
        }];
    }
}

-(void)message:(UIButton*)sender
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
        [[GDKeyVC share] presentViewController:login animated:YES completion:nil ];
        //        [[KeyVC shareKeyVC] presentViewController:login animated:YES completion:nil];
    }
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
