//
//  PayPsdOperationVC.m
//  b2c
//
//  Created by wangyuanfei on 6/14/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "PayPsdOperationVC.h"

#import "CustomDetailCell.h"

#import "ChangePasswordVC.h"

@interface PayPsdOperationVC ()
@property(nonatomic,weak)   CustomDetailCell * forgetPayPsd ;

@property(nonatomic,weak)   CustomDetailCell * changePayPsd ;
@end

@implementation PayPsdOperationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.naviTitle = @"设置支付密码";
    
    CGFloat margin = 10 ;
    CGFloat rowHeight = 44 ;
    CustomDetailCell * forgetPayPsd = [[CustomDetailCell alloc]initWithFrame:CGRectMake(0, self.startY+margin, self.view.bounds.size.width, rowHeight)];
    [forgetPayPsd addTarget:self action:@selector(forgetPayPsdClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetPayPsd];
    self.forgetPayPsd = forgetPayPsd;
    [self setAttributeWithCustomDetailCellView:forgetPayPsd WithLeftTitle:@"忘记支付密码" rightTitle:nil];
    
    
    CustomDetailCell * changePayPsd = [[CustomDetailCell alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.forgetPayPsd.frame), self.view.bounds.size.width, rowHeight)];
    [self.view addSubview:changePayPsd];
    [self setAttributeWithCustomDetailCellView:changePayPsd WithLeftTitle:@"修改支付密码" rightTitle:nil];
    [changePayPsd addTarget:self action:@selector(changePayPsdClick:) forControlEvents:UIControlEventTouchUpInside];
    self.changePayPsd = changePayPsd;

}
-(void)forgetPayPsdClick:(CustomDetailCell*)sender
{
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"忘记支付密码");
    BaseModel * model = [[BaseModel alloc]init];
    model.actionKey = @"AuthForPaypsdVC";
    [[SkipManager shareSkipManager] skipByVC:self withActionModel:model];
}
-(void)changePayPsdClick:(CustomDetailCell*)sender
{
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"修改支付密码");
    ChangePasswordVC * changepadVC = [[ChangePasswordVC alloc]initWithType:ChangePayPassword];
    [self.navigationController pushViewController:changepadVC animated:YES];
    
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
-(void)setAttributeWithCustomDetailCellView:(CustomDetailCell*)customDetailCell WithLeftTitle:(NSString * )leftTitle rightTitle:(NSString*)rightTitle{
    customDetailCell.backgroundColor = [UIColor whiteColor];
    customDetailCell.leftTitleFont = [UIFont systemFontOfSize:14];
    customDetailCell.leftTitleColor = MainTextColor;
    customDetailCell.showBottomLine = YES;
    customDetailCell.leftTitle = leftTitle;
    customDetailCell.rightDetailTitle=rightTitle;
    
}

@end
