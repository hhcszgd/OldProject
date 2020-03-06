//
//  ChooseLBVC.m
//  b2c
//
//  Created by wangyuanfei on 16/5/17.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "ChooseLBVC.h"

@interface ChooseLBVC ()
@property(nonatomic,weak)UIButton * confirmButton ;
@property(nonatomic,weak)UIButton * chooseButton  ;
@property(nonatomic,weak)UILabel * LBiLabel ;
@end

@implementation ChooseLBVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupsubview];
    // Do any additional setup after loading the view.
}
-(void)setupsubview;
{
    
    CGFloat containerW = self.view.bounds.size.width ;
    CGFloat containerH = 44 ;
    CGFloat containerX = 0 ;
    CGFloat containerY = self.startY;
    
    
    UIView * container = [[UIView alloc]initWithFrame:CGRectMake(containerX, containerY, containerW, containerH)];
    container.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:container];
    CGFloat margin = 10 ;
    CGFloat chooseW = 17 ;
    CGFloat chooseH = containerH ;
    CGFloat chooseX = margin ;
    CGFloat chooseY = 0 ;
    UIButton * chooseButton = [[UIButton alloc]initWithFrame:CGRectMake(chooseX, chooseY, chooseW, chooseH)];
    [chooseButton addTarget:self action:@selector(chooseLBButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.chooseButton = chooseButton;
    [container addSubview:chooseButton];
    [chooseButton setImage:[UIImage imageNamed:@"btn_round_nor"] forState:UIControlStateNormal];
    [chooseButton setImage:[UIImage imageNamed:@"btn_round_sel"] forState:UIControlStateSelected];
    
    CGFloat lbX = CGRectGetMaxX(self.chooseButton.frame) + margin ;
    CGFloat lbY = 0 ;
    CGFloat lbW = containerW  - margin  - lbX ;
    CGFloat lbH = containerH ;
    UILabel * LBiLabel = [[UILabel alloc]initWithFrame:CGRectMake(lbX, lbY, lbW , lbH)];
    self.LBiLabel = LBiLabel ;
    [container addSubview:LBiLabel];
    LBiLabel.text = [NSString stringWithFormat:@"%ld L币  这和人民币(%.02f)",self.lb , self.lb/1000.0];
    
    
    CGFloat confirmMargin = 20 ;
    CGFloat confirmBtnW = self.view.bounds.size.width - confirmMargin*2 ;
    CGFloat confirmBtnH = 44 ;
    CGFloat confirmBtnX = confirmMargin ;
    CGFloat confirmBtnY = self.view.bounds.size.height-confirmMargin -confirmBtnH ;

    UIButton * confirmButton =  [[UIButton alloc]initWithFrame:CGRectMake(confirmBtnX, confirmBtnY, confirmBtnW, confirmBtnH)];
    [confirmButton addTarget:self action:@selector(confirmButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    confirmButton.backgroundColor = THEMECOLOR;
    self.confirmButton = confirmButton;
    [self.view addSubview:confirmButton];
    
    
    //    MJRefreshAutoStateFooter* refreshFooter = [MJRefreshAutoStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(LoadMore)];
    //    self.tableView.mj_footer = refreshFooter;
    //    HomeRefreshHeader * refreshHeader = [HomeRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    //    self.tableView.mj_header=refreshHeader;
    
    
    
}
-(void)chooseLBButtonClick:(UIButton*)sender
{
    sender.selected=!sender.selected;
}
-(void)confirmButtonClick:(UIButton*)sender
{
    NSUInteger lbCount = 0 ;
    if (self.chooseButton.selected) {
        LOG(@"_%@_%d_%@",[self class] , __LINE__,@"使用了LB");
        lbCount = 100000;
    }else{
        LOG(@"_%@_%d_%@",[self class] , __LINE__,@"未使用LB");
        lbCount = 0;
    }
    
    if ([self.ChooseLBDelegate respondsToSelector:@selector(chooseLBCount:)]) {
        [self.ChooseLBDelegate chooseLBCount:lbCount];
    }
    [self.navigationController popViewControllerAnimated:YES];
    
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
