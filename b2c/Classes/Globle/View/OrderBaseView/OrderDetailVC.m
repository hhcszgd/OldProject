//
//  OrderDetailVC.m
//  b2c
//
//  Created by 0 on 16/4/13.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "OrderDetailVC.h"

@interface OrderDetailVC ()

@end

@implementation OrderDetailVC
- (UITableView *)table{
    if (_table == nil) {
        _table = [[UITableView alloc] initWithFrame:CGRectMake(0, self.startY, screenW, screenH -  self.startY) style:UITableViewStyleGrouped];
        [_table registerClass:[OrderDeatilReceiptAddresCell class] forCellReuseIdentifier:@"OrderDeatilReceiptAddresCell"];
        [_table registerClass:[OrderDetailHeader class] forHeaderFooterViewReuseIdentifier:@"OrderDetailHeader"];
        [_table registerClass:[OrderDetailContactSeller class] forCellReuseIdentifier:@"OrderDetailContactSeller"];
        [_table registerClass:[OrderDeatilFooter class] forHeaderFooterViewReuseIdentifier:@"OrderDeatilFooter"];
        [self.view addSubview:_table];
    }
    return _table;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configmentNa];
    // Do any additional setup after loading the view.
}

/**设置导航栏*/
- (void)configmentNa{
    self.naviTitle = @"订单详情";
    UIImageView *rightImage =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    rightImage.image = [UIImage imageNamed:@"collect_item_selected"];
    self.navigationBarRightActionViews = @[rightImage];
    [rightImage setUserInteractionEnabled:YES];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionMore:)];
    [rightImage addGestureRecognizer:tap];
}
- (void)actionMore:(UITapGestureRecognizer *)tap{
    LOG(@"%@,%d,%@",[self class], __LINE__,@"查看更多")
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
