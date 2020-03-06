//
//  HSuperWebVC.m
//  b2c
//
//  Created by 张凯强 on 2017/1/12.
//  Copyright © 2017年 www.16lao.com. All rights reserved.
//

#import "HSuperWebVC.h"

@interface HSuperWebVC ()

@end

@implementation HSuperWebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webview.frame = CGRectMake(0, 64, screenW, self.view.frame.size.height - 50 - 64);
    self.navigationView.hidden = YES;
    

    // Do any additional setup after loading the view.
}

-(void)AddToShopCartSuccessInWapPage
{
    if ([self.delegate respondsToSelector:@selector(changeShopCarNumber)]) {
        [self.delegate performSelector:@selector(changeShopCarNumber)];
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
