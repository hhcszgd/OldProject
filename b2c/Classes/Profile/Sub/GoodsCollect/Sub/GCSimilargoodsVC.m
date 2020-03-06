//
//  GCSimilargoodsVC.m
//  b2c
//
//  Created by 0 on 16/4/9.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "GCSimilargoodsVC.h"

@interface GCSimilargoodsVC ()

@end

@implementation GCSimilargoodsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self configmentNa];
    // Do any additional setup after loading the view.
}
- (void)configmentNa{
    self.naviTitle = @"相似产品";
    UIImageView *moreImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shop_more"]];
    moreImageView.frame = CGRectMake(0, 0, 20, 6);
    self.navigationBarRightActionViews = @[moreImageView];
    
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
