//
//  ChannelsBaseVC.m
//  b2c
//
//  Created by 0 on 16/4/6.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "ChannelsBaseVC.h"
#import "HNaviCompose.h"
#import "HCellComposeModel.h"
#import "LoginNavVC.h"
#import "b2c-Swift.h"
@interface ChannelsBaseVC ()
@property (nonatomic, weak) GDMsgIconView *messageButton;
@end

@implementation ChannelsBaseVC
- (UICollectionViewFlowLayout *)flowLayout{
    if (_flowLayout == nil) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [_flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    }
    return _flowLayout;
}
- (UICollectionView *)col{
    if (_col == nil) {
        _col = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.startY , screenW, screenH - self.startY ) collectionViewLayout:self.flowLayout];
        _col.backgroundColor = BackgroundGray;
        [_col setScrollEnabled: YES];
        [_col setShowsVerticalScrollIndicator:NO];
        _col.mj_header = self.refreshHeader;
        [self.view addSubview:_col];
    }
    return _col;
}
- (UIButton *)scrollToTopBtn{
    if (_scrollToTopBtn == nil) {
        
        _scrollToTopBtn = [[UIButton alloc]initWithFrame:CGRectMake(screenW - 60, screenH - 80, 40, 40)];
        _scrollToTopBtn.hidden = YES;
        [self.view addSubview:_scrollToTopBtn];
        [_scrollToTopBtn setImage:[UIImage imageNamed:@"btn_Top"] forState:UIControlStateNormal];
        [_scrollToTopBtn addTarget:self action:@selector(scrollToTop) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _scrollToTopBtn;
}
- (void)scrollToTop{
    [self.col scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

}


- (ChannelRefreshHeader *)refreshHeader{
    if (_refreshHeader == nil) {
        _refreshHeader = [ChannelRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(downRefresh)];
    }
    return _refreshHeader;
}
#pragma mark -- 下拉刷新
- (void)downRefresh{
    
}
- (ChannelRefreshFooter *)refreshFooter{
    if (_refreshFooter == nil) {
        _refreshFooter = [ChannelRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(upRefresh)];
    }
    return _refreshFooter;
}
- (void)upRefresh{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
//    [self configmentNavigation];
    self.pageNumber = 1;
    [self configmentUI];
    [self downRefresh];
    self.scrollToTopBtn.backgroundColor = [UIColor clearColor];
    // Do any additional setup after loading the view.
}
- (void)viewDidAppear:(BOOL)animated{
    if ([UserInfo shareUserInfo].isLogin) {
        //更新按钮购物车数量
        [[UserInfo shareUserInfo] gotShopCarNumberSuccess:^(ResponseObject *responseObject) {
            [self.shopCarBtn editShopCarNumber:responseObject.data];
        } failure:^(NSError *error) {
        }];
    }

}
- (ShopCar *)shopCarBtn{
    if (_shopCarBtn == nil) {
        ShopCar *car = [[ShopCar alloc] initWithFrame:CGRectMake(0, 0, 44, 44) withNum:@"0"];
        [car addTarget:self action:@selector(toShopCar) forControlEvents:UIControlEventTouchUpInside];
        _shopCarBtn = car;
    }
    return _shopCarBtn;
}
- (void)toShopCar{
    BaseModel *baseModel = [[BaseModel alloc] init];
    baseModel.judge = YES;
    baseModel.actionKey = @"ShopCarVC";
    [[SkipManager shareSkipManager] skipByVC:self withActionModel:baseModel];
}
/**设置collectionview*/
- (void)configmentUI{
    
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




- (void)search:(ActionBaseView *)searchBtn{
    
}

#pragma mark --
- (void)actionToSearch:(ActionBaseView *)searchView{
    LOG(@"%@,%d,%@",[self class], __LINE__,searchView)
}
- (void)dealloc{
    
//     [[NSNotificationCenter defaultCenter] removeObserver:self name:MESSAGECOUNTCHANGED object:nil];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"fuck , 内存警告");
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
