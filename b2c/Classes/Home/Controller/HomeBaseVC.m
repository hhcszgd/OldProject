//
//  HomeBaseVC.m
//  b2c
//
//  Created by wangyuanfei on 3/23/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "HomeBaseVC.h"
#import "HSearchVC.h"
#import "QRCodeScannerVC.h"
#import "b2c-Swift.h"
#import "HNaviCompose.h"
#import "HCellComposeModel.h"

@interface HomeBaseVC ()<UISearchBarDelegate>
@property(nonatomic,strong)UIImage * img ;
@property(nonatomic,weak)UIButton * scrollToTopButton ;
@property(nonatomic,weak)UILabel * searchContentLabel ;
@property(nonatomic,weak)  HNaviCompose * messageButton ;

@end

@implementation HomeBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    Class class1 = NSClassFromString(@"tttt");
//    Class class2 = NSClassFromString(@"UIView");
//    Class class3 = NSClassFromString(@"HomeVC");
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,class1);
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,class2);
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,class3);
//     self.backButtonHidden=YES;
    [[NSNotificationCenter defaultCenter ] addObserver:self selector:@selector(messageCountChanged) name:MESSAGECOUNTCHANGED object:nil];
    UIButton * scrollToTopButton = [[UIButton alloc]initWithFrame:CGRectMake(screenW-60*SCALE, screenH-132, 42*SCALE, 42*SCALE)];
    self.scrollToTopButton=scrollToTopButton;
    scrollToTopButton.adjustsImageWhenHighlighted=NO;
    scrollToTopButton.hidden = YES;
    [self.scrollToTopButton setImage:[UIImage imageNamed:@"btn_Top"] forState:UIControlStateNormal];
    [self.view addSubview:self.scrollToTopButton];
    [self.scrollToTopButton addTarget:self action:@selector(scrollToTop) forControlEvents:UIControlEventTouchUpInside];
    
    [self setupNavigationBarSubview];
    self.showNavigationBarBottomLine=NO;
    


}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"准备输入搜索内容")

}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    LOG(@"_%@_%d_%@",[self class] , __LINE__,searchText)
}
-(void)messageCountChanged
{
    
   
//        if ([[NSThread currentThread] isMainThread]) {
//            NSLog(@"main");
//        } else {
//            NSLog(@"not main");
//        }
    [self.messageButton changeMessageCount];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            //do your UI
//            HCellComposeModel * messageModel = [[HCellComposeModel alloc]init ];
//            messageModel.imgForLocal = [UIImage imageNamed:@"nav_news"];
//            NSInteger messageCount =  [[[NSUserDefaults standardUserDefaults] objectForKey:MESSAGECOUNTCHANGED] integerValue];
////            messageModel.title  = @"消息";
//            messageModel.messageCountInCompose=messageCount;
//            self.messageButton.composeModel  = messageModel;
//
//        });
    
    
   }
-(void)setupNavigationBarSubview
{
    HNaviCompose * messageButton = [[HNaviCompose alloc]init];
    self.messageButton = messageButton;
    HCellComposeModel * messageModel = [[HCellComposeModel alloc]init ];
    messageModel.imgForLocal = [UIImage imageNamed:@"icon_news_home"];
    messageModel.title  = @"消息";
//    messageModel.messageCountInCompose=[[[NSUserDefaults standardUserDefaults] objectForKey:MESSAGECOUNTCHANGED] integerValue];
    messageButton.composeModel  = messageModel;
    [messageButton addTarget:self action:@selector(messageClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
     /*HNaviCompose * saoCode = [[HNaviCompose alloc]init];
    [saoCode addTarget:self action:@selector(saoCode:) forControlEvents:UIControlEventTouchUpInside];
    HCellComposeModel * saoCodeModel = [[HCellComposeModel alloc]init ];
    saoCodeModel.imgForLocal = [UIImage imageNamed:@"icon_menu"];
    //saoCodeModel.title  = @"分类";
    saoCode.composeModel  = saoCodeModel;
    */
    UIButton *saoCode = [[UIButton alloc ] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [saoCode addTarget:self action:@selector(saoCode:) forControlEvents:UIControlEventTouchUpInside];
    [saoCode setImage:[UIImage imageNamed:@"icon_menu"] forState:UIControlStateNormal];
//    saoCode.imageEdgeInsets = UIEdgeInsetsMake((38 - 16.5)/2.0, 5, (38 - 16.5)/2.0, 44 - 19.5 - 5);
    
    
    ActionBaseView * searchBar = [[ActionBaseView alloc]init];
    self.navigationBarRightActionViews = @[messageButton];
    self.navigationBarLeftActionViews = @[saoCode];
    [searchBar addTarget:self action:@selector(skipToSearchVC:) forControlEvents:UIControlEventTouchUpInside];
    searchBar.contentMode = UIViewContentModeCenter;
//    [searchBar addTarget:self andSel:@selector(skipToSearchVC)];
    self.searchView =searchBar;
    //设置完searchBar再布局里面的子控件
    UIImageView * img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, searchBar.bounds.size.height, searchBar.bounds.size.height)];//放大镜
    img.image = [UIImage imageNamed:@"icon_searchhome"];
    img.contentMode = UIViewContentModeCenter;
    [searchBar addSubview:img];
    UILabel * text = [[UILabel alloc]initWithFrame:CGRectMake(img.bounds.size.width, 0, searchBar.bounds.size.width-img.bounds.size.width, img.bounds.size.height)];
    self.searchContentLabel=text;
    text.textColor = [UIColor lightGrayColor];
//    self.searchContentText=@"当季流行";
//    NSString * udid = [UIDevice currentDevice].identifierForVendor.UUIDString;
    self.searchContentText=@"请输入您想要的商品";
//    text.backgroundColor=randomColor;
    [searchBar addSubview:text];
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"test")
}
-(void)saoCode:(UIButton*)sender
{
//    [[KeyVC shareKeyVC] skipToTabbarItemWithIndex:1];
    [[GDKeyVC share] selectChildViewControllerIndexWithIndex:1];
//    QRCodeScannerVC * scannerVC = [[QRCodeScannerVC alloc] init ];
//    [self.navigationController pushViewController:scannerVC animated:YES];
//    [self.navigationController presentViewController:scannerVC animated:YES completion:^{
    
//    }];
//    [[SkipManager shareSkipManager] skipByVC:self urlStr:nil title:nil action:@"HomeBaseVC"];
}

-(void)messageClick:(ActionBaseView*)sender
{
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"跳转消息控制器")
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
}
-(void)skipToSearchVC:(ActionBaseView*)sender
{
    HBaseModel*searchModel = [[HBaseModel alloc]init];
    searchModel.actionKey = @"HSearchVC";
    [[SkipManager shareSkipManager] skipByVC:self withActionModel:searchModel ];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"fuck , 内存警告");
    // Dispose of any resources that can be recreated.
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

    [self.messageButton switchBackGroundColorAndTitleColorWithSomeValue:self.tableView.contentOffset.y/100];
    if (self.tableView.contentOffset.y<0) {
        
        [UIView animateWithDuration:0.25 animations:^{
            [self changenavigationBarAlphaWithScale:0];
        }];
        
    }else if(self.tableView.contentOffset.y<100){
        [UIView animateWithDuration:0.25 animations:^{
            [self changenavigationBarAlphaWithScale:1];
        }];
         [self changenavigationBarBackGroundAlphaWithScale:self.tableView.contentOffset.y*0.01];
        
        
    }else if (self.tableView.contentOffset.y<screenH*2){
         [self changenavigationBarBackGroundAlphaWithScale:1];
        self.scrollToTopButton.hidden=YES;
    }else{
        self.scrollToTopButton.hidden=NO;
        if (!self.scrollToTopButton.hidden)
        [self.view bringSubviewToFront:self.scrollToTopButton];
        [self changenavigationBarBackGroundAlphaWithScale:1];
    }
    
}
-(void)scrollToTop
{
    if (self.tableView ) {
         [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    CGSize size =  self.tableView.contentSize;
//    size.height += 10 ;
    self.tableView.contentSize = size;
}
-(void)setSearchContentText:(NSString *)searchContentText{
    _searchContentText=searchContentText;
    self.searchContentLabel.text = searchContentText;
}


@end
