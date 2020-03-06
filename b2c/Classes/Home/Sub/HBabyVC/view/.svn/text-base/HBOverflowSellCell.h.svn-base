//
//  HBOverflowSellCell.h
//  b2c
//
//  Created by 0 on 16/4/7.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//
@class CustomCollectionModel;
@protocol HBOverflowSellCellDelegate <NSObject>

/**跳转到商品详情页面*/
- (void)HBOverflowSellCellActionToGoodsDeatilWithSubModel:(CustomCollectionModel *)subModel;

@end
#import <UIKit/UIKit.h>
#import "HBabyBaseCell.h"

@interface HBOverflowSellCell : HBabyBaseCell
@property (nonatomic, weak) id <HBOverflowSellCellDelegate>delegate;
@end
