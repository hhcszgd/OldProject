//
//  TestScrollViewProPerty.m
//  b2c
//
//  Created by wangyuanfei on 16/8/2.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "TestScrollViewProPerty.h"

@interface TestScrollViewProPerty ()<UIScrollViewDelegate>
@property(nonatomic,weak)UIScrollView * scrollView ;
@end

@implementation TestScrollViewProPerty

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets  = NO;
    [self setupTableView];
    // Do any additional setup after loading the view.
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
-(void)setupTableView
{
    
//    UIScrollView * scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, self.startY, screenW, screenH-self.startY)];
//    [self.view addSubview:scrollView];
//    self.scrollView=scrollView;
//    scrollView.delegate = self;
//    scrollView.backgroundColor = randomColor;
    
//    LOG(@"_%@_%d_bouns-->%@",[self class] , __LINE__,NSStringFromCGRect(scrollView.bounds));
//
//    LOG(@"_%@_%d_frame-->%@",[self class] , __LINE__,NSStringFromCGRect(scrollView.frame));
//
//    LOG(@"_%@_%d_contentSize-->%@",[self class] , __LINE__,NSStringFromCGSize(scrollView.contentSize));
//
//    LOG(@"_%@_%d_contentOffset-->%@",[self class] , __LINE__,NSStringFromCGPoint(scrollView.contentOffset));
//    
//    LOG(@"_%@_%d_contentInset-->%@\n",[self class] , __LINE__,NSStringFromUIEdgeInsets(scrollView.contentInset));
//
//    scrollView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
//    
//    LOG(@"_%@_%d_bouns-->%@",[self class] , __LINE__,NSStringFromCGRect(scrollView.bounds));
//    
//    LOG(@"_%@_%d_frame-->%@",[self class] , __LINE__,NSStringFromCGRect(scrollView.frame));
//    
//    LOG(@"_%@_%d_contentSize-->%@",[self class] , __LINE__,NSStringFromCGSize(scrollView.contentSize));
//    
//    LOG(@"_%@_%d_contentOffset-->%@",[self class] , __LINE__,NSStringFromCGPoint(scrollView.contentOffset));
//    
//    LOG(@"_%@_%d_contentInset-->%@",[self class] , __LINE__,NSStringFromUIEdgeInsets(scrollView.contentInset));
//    
//    
//    self.tableView.backgroundColor=BackgroundGray;
//    self.tableView.delegate = self;
//    self.tableView.dataSource=self;
//    self.tableView.rowHeight=UITableViewAutomaticDimension;
//    self.tableView.estimatedRowHeight = 14.0;
    //    [self.tableView registerClass:[ChatCellBC class] forCellReuseIdentifier:@"ChatCellBC"];
    //    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
//    self.tableView.showsVerticalScrollIndicator=NO;
//    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    //    UIView * ffff = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 375, 30)];
    //    self.tableView.tableFooterView =ffff;
    //    self.tableView.contentInset=UIEdgeInsetsMake(0, 0, 50, 0);
    
}
@end
