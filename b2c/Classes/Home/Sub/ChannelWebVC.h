//
//  ChannelWebVC.h
//  b2c
//
//  Created by 张凯强 on 2017/1/12.
//  Copyright © 2017年 www.16lao.com. All rights reserved.
//

#import "BaseWebVC.h"
#import "ShopCar.h"
#import "HNaviCompose.h"
#import "HCellComposeModel.h"
#import "LoginNavVC.h"
@class GDMsgIconView;
@interface ChannelWebVC : BaseWebVC
- (void)configmentNavigation;
@property (nonatomic, weak) GDMsgIconView *messageButton;
- (void)message:(ActionBaseView *)message;
@property (nonatomic, strong) ShopCar *shopCarBtn;
@end
