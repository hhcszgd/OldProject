//
//  HGoodsBottomCell.h
//  b2c
//
//  Created by 0 on 16/4/25.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//
@class HGoodsBottomSubModel;
#import <WebKit/WebKit.h>
@protocol HGoodsBottomCellDelegate <NSObject>
@optional
/**点击商品跳转到商品详情页面*/
- (void)clickGoodsActionToTheGoodsDetailVCWith:(HGoodsBottomSubModel *)goodModel;
/**弹出alert框*/
- (void)presentAlertWith:(id)object;
/**弹出一个confirm弹出框*/
- (void)presentConfirmWith:(id)object;
@end
#import <UIKit/UIKit.h>
#import "HGoodsBaseCell.h"
@interface HGoodsBottomCell : HGoodsBaseCell


@property (nonatomic, weak) id <HGoodsBottomCellDelegate>delegate;
@end
