//
//  HStoreBaseVC.m
//  b2c
//
//  Created by 0 on 16/3/30.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HStoreBaseVC.h"

@interface HStoreBaseVC ()

@end

@implementation HStoreBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = randomColor;
    [self configmentNavigation];
    [self configmentMidleView];
    // Do any additional setup after loading the view.
}
#pragma maek -- 设置导航栏
- (void)configmentNavigation{
    //导航栏颜色
    self.navigationBarColor = customColor(253, 253, 253, 1);
    
    //右边搜索按钮
    //    UIImageView *searchBtn = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 21, 28)];
    //    searchBtn.image  =[UIImage imageNamed:@"shop_main_category"];
    //    searchBtn.userInteractionEnabled = YES;
    //    UITapGestureRecognizer *searchTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(search:)];
    //    [searchBtn addGestureRecognizer:searchTap];
    //右边消息按钮
    UIImageView *messageBtn = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    messageBtn.image  =[UIImage imageNamed:@"shop_iconfont-message"];
    messageBtn.userInteractionEnabled = YES;
    UITapGestureRecognizer *messageTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(message:)];
    [messageBtn addGestureRecognizer:messageTap];
    self.navigationBarRightActionViews = @[messageBtn];
    
    
    
}




- (void)configmentMidleView{
    //搜索框
    ActionBaseView *searchView = [[ActionBaseView alloc] init];
    [searchView addTarget:self action:@selector(actionToSearch:) forControlEvents:UIControlEventTouchUpInside];
    self.searchView = searchView;
    
    //放大镜
    searchView.backgroundColor = customColor(234, 234, 234, 1);
    UIImageView *searchImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tmall_orderlist_search"]];
    searchImage.backgroundColor = [UIColor clearColor];
    [searchView addSubview:searchImage];
    [searchImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(searchView.mas_top).offset(10);
        make.left.equalTo(searchView.mas_left).offset(0);
        make.bottom.equalTo(searchView.mas_bottom).offset(-10);
        make.width.equalTo(@(20));
    }];
    //文字提示
    UILabel *searchLabel = [[UILabel alloc] init];
    [searchView addSubview:searchLabel];
    [searchLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(searchView.mas_top).offset(0);
        make.left.equalTo(searchImage.mas_right).offset(5);
        make.bottom.equalTo(searchView.mas_bottom).offset(0);
        make.right.equalTo(searchView.mas_right).offset(0);
    }];
    [searchLabel configmentfont:[UIFont boldSystemFontOfSize:17] textColor:customColor(133, 133, 133, 1) backColor:[UIColor clearColor] textAligement:0 cornerRadius:0 text:@"搜索店铺里面的宝贝"];
    
}

#pragma maek -- 右边消息按钮
- (void)message:(UITapGestureRecognizer *)tap{
    LOG(@"%@,%d,%@",[self class], __LINE__,@"消息")
}
#pragma mark --
- (void)actionToSearch:(ActionBaseView *)searchView{
    LOG(@"%@,%d,%@",[self class], __LINE__,searchView)
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
