//
//  HEOverflowSellCell.h
//  b2c
//
//  Created by 0 on 16/5/4.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//
@class CustomCollectionModel;
@protocol HEOverflowSellCellDelegate <NSObject>

/**跳转到商品详情页面*/
- (void)HEOverflowSellCellActionToGoodsDetailWith:(CustomCollectionModel *)subModel;

@end
#import <UIKit/UIKit.h>
#import "HEaBaseCell.h"
@interface HEOverflowSellCell : HEaBaseCell
@property (nonatomic, weak) id <HEOverflowSellCellDelegate>delegate;
@end
