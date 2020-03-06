//
//  LoginNavVC.m
//  TTmall
//
//  Created by wangyuanfei on 3/11/16.
//  Copyright © 2016 Footway tech. All rights reserved.
//

#import "LoginNavVC.h"
#import "LoginVC.h"

@interface LoginNavVC ()<LoginVCDelegate>
@property(nonatomic,strong)   LoginVC * vc ;
@end

@implementation LoginNavVC
-(instancetype)initLoginNavVC{
    LoginVC * vc = [[LoginVC alloc]init] ;
    self.vc = vc ;
    
//    UIViewController * aa = [[UIViewController alloc]init];
//    aa.view.backgroundColor = randomColor;

//    ActionBaseView * btn = [[ActionBaseView alloc]init];
////    btn.bounds=CGRectMake(0, 0, 26, 26);
//    btn.backgroundColor=randomColor;
//    [btn addTarget:self action:@selector(dismissLogin) forControlEvents:UIControlEventTouchUpInside];
//   
//    vc.navigationBarLeftActionViews = @[btn];
//    CATransition * animation = [CATransition animation];
//    animation.subtype = kCATransitionFromLeft;
//    animation.type=kCATransitionPush;
//    animation.duration = 1 ;
//    [vc.view.layer addAnimation:animation forKey:nil];
//    [aa.view.layer addAnimation:animation forKey:nil];
    
    LoginNavVC * vcnavi = [[LoginNavVC alloc]initWithRootViewController:vc];
    vc.mydelegate = vcnavi ;
    return vcnavi ;
}

-(instancetype)init{
    if (self=[super init]) {
        
    }
    return self;
}
- (void)sbloginsuccessed:(LoginVC *) vc{
    if ([self.mydelegate respondsToSelector:@selector(loginnavisuccessed)]) {
        [self.mydelegate loginnavisuccessed];
    }
}

-(void)dismissLogin
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
