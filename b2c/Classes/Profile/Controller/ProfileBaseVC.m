//
//  ProfileBaseVC.m
//  b2c
//
//  Created by wangyuanfei on 3/23/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "ProfileBaseVC.h"
//#import "PTableView.h"
//#import "BaseCell.h"
#import "PBackgroundVC.h"
@interface ProfileBaseVC ()
@end

@implementation ProfileBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setupTableView];
    // Do any additional setup after loading the view.
}
//-(void)setupTableView
//{
//    CGRect frame  = CGRectMake(0, 0, self.view.bounds.size.width,self.view.bounds.size.height - self.tabBarController.tabBar.bounds.size.height);
//    PTableView * tableView =[[PTableView alloc]initWithFrame:frame style:UITableViewStyleGrouped];
//    self.tableView =tableView;
//    CGFloat tableViewTopViewW = self.view.bounds.size.width;
//    CGFloat tableViewTopViewH = screenH-200;
//    CGFloat tableViewTopViewY = -tableViewTopViewH;
//    CGFloat tableViewTopViewX = 0;
//    UIView * tableViewTopView = [[UIView alloc]initWithFrame:CGRectMake(tableViewTopViewX, tableViewTopViewY, tableViewTopViewW, tableViewTopViewH)];
//    tableViewTopView.backgroundColor=[UIColor redColor];
//
//    [self.tableView addSubview:tableViewTopView];
//}
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return 49;
//}
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    BaseCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
//    if (!cell) {
//        cell = [[BaseCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
//    }
//    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
//    return cell;
//}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"停止拖动")
    if (self.tableView.contentOffset.y<-100) {
//        [self.navigationController pushViewController:[[PBackgroundVC alloc]init] animated:NO];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,NSStringFromCGPoint(scrollView.contentOffset));
    if (scrollView.contentOffset.y < -150) {
        scrollView.contentOffset = CGPointMake(0, -150);
    }

}
@end
