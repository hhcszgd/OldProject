//
//  TabBarLaoVC.m
//  b2c
//
//  Created by wangyuanfei on 16/4/18.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "TabBarLaoVC.h"


#import "ShopCarEmptyVC.h"

#import "ShopCarFullVC.h"

#import "LaoCheapVC.h"
#import "LaoStoryVC.h"
@interface TabBarLaoVC ()
@property(nonatomic,weak)GDScrollMenuView * menuView ;
@property(nonatomic,strong)NSArray * arr ;
@property(nonatomic,strong)NSArray * vcs ;
@end

@implementation TabBarLaoVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    
//    [self addShopCarWithGoods];
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cellComposeClick:) name:@"LCellComposeViewClick" object:nil];
//    self.naviTitle=@"捞";
    
    
//    ActionBaseView * rightMessage = [[ActionBaseView alloc]init];
//    rightMessage.img=[UIImage imageNamed:@"icon_news"];
//    self.navigationBarRightActionViews = @[rightMessage];
    
    
    CGFloat menuViewW = 200 ;
    CGFloat menuViewH = 44 ;
    CGFloat menuViewX = (self.view.bounds.size.width-menuViewW)/2 ;
    CGFloat menuViewY = 20 ;
    
    GDScrollMenuView * menuView = [[GDScrollMenuView alloc]initWithFrame:CGRectMake(menuViewX,menuViewY,menuViewW,menuViewH)];
    menuView.composeW = menuViewW/2;
    menuView.textColor = [UIColor redColor];
    menuView.GDaDtaSource=self;
//    [self.view addSubview:menuView];
    self.navigationCustomView = menuView;
    self.menuView=menuView;
    //    self.backButtonHidden=YES;
    // Do any additional setup after loading the view.
}
//-(void)cellComposeClick:(NSNotification*)notifi
//{
//    HCellComposeModel * model =  ( HCellComposeModel * )notifi.userInfo[@"LCellComposeViewModel"];
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,model.actionKey)
//    [[SkipManager shareSkipManager] skipForHomeByVC:self withActionModel:model];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"fuck , 内存警告");
    // Dispose of any resources that can be recreated.
}

/** 获取菜单选项的个数 */
-(NSInteger)numberOfComposeInScrollMenuView:(UIView *)menuView{
    return self.vcs.count;
}

/** 获取每一个菜单选项的文字 */
-(NSString *) titleOfEveryoneInMenuView:(UIView*)menuView index:(NSInteger)index{
    
    return self.arr[index];
}
/** 获取每一个菜单选项的图片 */
//-(UIImage *) imageOfEveryoneInMenuView:(UIView*)menuView index:(NSInteger)index{
//    return [UIImage imageNamed:@"composer_rating_small_icon_half"];
//};
/** 监听当前下标和上一个下标 */
-(void)scrollMenuView:(UIView *)menuView WithTargetIndex:(NSInteger)index oldIndex:(NSInteger)oldIndex{
    NSLog(@"_%@_%d_%@",[self class] , __LINE__,[NSString stringWithFormat:@"newIndex %lu  oldIndex %lu ",index , oldIndex]);
}
/** 显示内容的frame */
-(CGRect)collectionFrameInscrollMenuView:(UIView *)menuView{
    return CGRectMake(0, self.startY, self.view.bounds.size.width, screenH-self.startY-self.tabBarController.tabBar.bounds.size.height);
}

/** 获取用来显示内容的视图控件 */
-(UIView *)contentViewInScrollMenuView:(UIView *)menuView index:(NSInteger)index{
    if (index==0) {
        BaseVC *vc = self.vcs[0];

        return vc.view;
    }else{
        BaseVC *vc= self.vcs[1];
        return vc.view;
    }
}
-(NSArray * )arr{
    if(_arr==nil){
        NSMutableArray * arrM =  [[NSMutableArray alloc]initWithObjects:@"捞便宜",@"捞故事", nil];
        
        
        _arr =arrM.copy;
    }
    return _arr;
}

-(NSArray *)vcs{
    if (_vcs==nil) {
        LaoCheapVC *vc1= [[LaoCheapVC alloc]init];
        LaoStoryVC *vc2= [[LaoStoryVC alloc]init];
//        ShopCarEmptyVC *vc1= [[ShopCarEmptyVC alloc]init];
//        ShopCarEmptyVC *vc2= [[ShopCarEmptyVC alloc]init];
        
        [self addChildViewController:vc1];
        [self addChildViewController:vc2];
        _vcs=[NSArray arrayWithObjects:vc1,vc2, nil];
    }
    return _vcs;
}






-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
//    LOG(@"_%@_%d_lao的视图即将出现时 ,打印当前的网络状态%ld",[self class] , __LINE__,self.networkingStatus)
    //    BOOL change= self.networkHasChange;
    //
    //        if (self.networkingStatus==0) {
    //            AlertInVC(@"网络故障")
    //        }else{
    //                    [self gotHomeDataSuccess:^{
    //                        self.networkHasChange=NO;
    //
    //                    }];
    //
    //        }
    //
    
    
    
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
//    LOG(@"_%@_%d_lao的视图  已经  出现时 ,打印当前的网络状态%ld",[self class] , __LINE__,self.networkingStatus)
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
