//
//  LaoVC.m
//  b2c
//
//  Created by wangyuanfei on 3/23/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "HLaoVC.h"

@interface HLaoVC ()

@end

@implementation HLaoVC

- (void)viewDidLoad {

    [super viewDidLoad];
        self.naviTitle=nil;
    
    LOG(@"_%@_%d_%ld",[self class] , __LINE__,[AFNetworkReachabilityManager sharedManager].networkReachabilityStatus)
    
    
    
    
    
//    self.backButtonHidden=YES;
    // Do any additional setup after loading the view.
}

-(CGRect)collectionFrameInscrollMenuView:(UIView *)menuView{
    return CGRectMake(0, self.startY, self.view.bounds.size.width, screenH-self.startY);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"fuck , 内存警告");
    // Dispose of any resources that can be recreated.
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGRect frame = CGRectMake(0, self.startY, self.view.bounds.size.width, self.view.bounds.size.height - self.startY);
    [self showTheViewWhenDisconnectWithFrame:frame];
        LOG(@"_%@_%d_%ld",[self class] , __LINE__,[AFNetworkReachabilityManager sharedManager].networkReachabilityStatus)
//    [[SkipManager shareSkipManager] skipByVC:self urlStr:nil title:nil action:@"SecondBaseVC"];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    LOG(@"_%@_%d_%ld",[self class] , __LINE__,[AFNetworkReachabilityManager sharedManager].networkReachabilityStatus)
}
-(void)clickTry:(UIButton*)sender
{
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"在子控制器中  , 点击重连的回调方法")
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
