//
//  HCellBaseComposeView.h
//  b2c
//
//  Created by wangyuanfei on 16/4/14.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
/**
    首页cell中的子控件的基类
 */

#import "ActionBaseView.h"
@class HCellComposeModel;
@interface HCellBaseComposeView : ActionBaseView
@property(nonatomic,strong)HCellComposeModel * composeModel ;
@property (nonatomic, strong) UIImageView *privateImage;

@end