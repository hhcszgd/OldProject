//
//  HStoreBaseVC.m
//  b2c
//
//  Created by 0 on 16/3/30.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HStoreBaseVC.h"
#import "CSearchBtn.h"
#import "LoginNavVC.h"
#import "b2c-Swift.h"
@interface HStoreBaseVC ()

@end

@implementation HStoreBaseVC

- (CustomFRefresh *)fRefresh{
    if (_fRefresh == nil) {
        _fRefresh = [CustomFRefresh footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    }
    return _fRefresh;
}



- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = randomColor;
    
    [self configmentNavigation];
    [self configmentMidleView];
    // Do any additional setup after loading the view.
}
#pragma maek -- 设置导航栏
- (void)configmentNavigation{
        
    //右边消息按钮
    HNaviCompose * messageButton = [[HNaviCompose alloc]init];
    self.messageButton = messageButton;
    HCellComposeModel * messageModel = [[HCellComposeModel alloc]init ];
    messageModel.imgForLocal = [UIImage imageNamed:@"icon_news_gray"];
    //    messageModel.messageCountInCompose=[[[NSUserDefaults standardUserDefaults] objectForKey:MESSAGECOUNTCHANGED] integerValue];
    messageButton.composeModel  = messageModel;
    [messageButton addTarget:self action:@selector(message:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationBarRightActionViews = @[messageButton];
    
    
    
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
        BaseModel *baseModel = [[BaseModel alloc] init];
        XMPPJID *xm = [XMPPJID jidWithUser:self.sellerUser domain:chatDomain resource:nil];
        NSLog(@"%@, %d ,%@",[self class],__LINE__,self.sellerUser);

        if (self.sellerUser && xm) {
            baseModel.keyParamete = @{@"paramete":xm};
            baseModel.actionKey = ChatVCName;
            baseModel.judge = YES;
            [[SkipManager shareSkipManager] skipByVC:self withActionModel:baseModel];
        }
        
       
        
        
    }else{
        LoginNavVC *login = [[LoginNavVC alloc] initLoginNavVC];
        [[GDKeyVC share] presentViewController:login animated:YES  completion:nil ];

//        [[KeyVC shareKeyVC] presentViewController:login animated:YES completion:nil];
    }
    
}


- (void)configmentMidleView{
        self.navigationCustomView = self.searchBtn;
    
}
- (CSearchBtn *)searchBtn{
    if (_searchBtn == nil) {
        
        _searchBtn = [[CSearchBtn alloc] initWithFrame:CGRectMake(46,20 +6, screenW - 46 - 50, 33)];
        [_searchBtn addTarget:self action:@selector(actionToSearch:) forControlEvents:UIControlEventTouchUpInside];
        _searchBtn.titleStr = @"请输入你想要的商品";

    
    }
    return _searchBtn;
}

#pragma mark --
- (void)actionToSearch:(ActionBaseView *)searchView{
    LOG(@"%@,%d,%@",[self class], __LINE__,searchView)
}

-(void)dealloc{
     
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
