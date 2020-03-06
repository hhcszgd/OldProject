//
//  HFranOverflowSellCell.h
//  b2c
//
//  Created by 0 on 16/4/7.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//
@class CustomCollectionModel;
@protocol HFranOverflowSellCellDelegate <NSObject>

/**跳转到商品详情页面*/
- (void)HFranOverflowSellCellActionToGoodsDetailWithSubModel:(CustomCollectionModel *)subModel;

@end
#import <UIKit/UIKit.h>
#import "HFranchiseBaseCell.h"
@interface HFranOverflowSellCell : HFranchiseBaseCell
@property (nonatomic, weak) id <HFranOverflowSellCellDelegate>delegate;
@end
