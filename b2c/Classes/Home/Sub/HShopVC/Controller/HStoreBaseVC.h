//
//  HStoreBaseVC.h
//  b2c
//
//  Created by 0 on 16/3/30.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "SecondBaseVC.h"
#import "CustomFRefresh.h"
#import "HNaviCompose.h"
#import "HCellComposeModel.h"
#import "CSearchBtn.h"
@interface HStoreBaseVC : SecondBaseVC
- (void)message:(ActionBaseView *)message;
- (void)actionToSearch:(ActionBaseView *)searchView;
- (void)configmentMidleView;
- (void)configmentNavigation;
/**加载更多*/
- (void)loadMoreData;
@property (nonatomic, strong) CustomFRefresh *fRefresh;
@property (nonatomic, strong)HNaviCompose  *messageButton;
@property (nonatomic,strong) CSearchBtn * searchBtn;
/**卖家用户名*/
@property (nonatomic, copy) NSString *sellerUser;
@end
