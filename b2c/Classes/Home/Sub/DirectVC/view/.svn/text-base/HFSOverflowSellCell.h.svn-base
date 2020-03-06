//
//  HFSOverflowSellCell.h
//  b2c
//
//  Created by 0 on 16/4/6.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//
@class CustomCollectionModel;
@protocol HFSOverflowSellCellDelegate <NSObject>
/**跳转到商品详情页面*/
- (void)HFSOverflowSellCellActionToGoodsDetailWithSubModel:(CustomCollectionModel *)subModel;

@end
#import <UIKit/UIKit.h>
#import "HFactoryBaseCell.h"
@interface HFSOverflowSellCell : HFactoryBaseCell
@property (nonatomic, weak) id <HFSOverflowSellCellDelegate>delegate;
@end
