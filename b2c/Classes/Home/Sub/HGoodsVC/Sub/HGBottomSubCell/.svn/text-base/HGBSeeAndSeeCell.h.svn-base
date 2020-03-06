//
//  HGBSeeAndSeeCell.h
//  b2c
//
//  Created by 0 on 16/5/14.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//
@class HGoodsBottomSubModel;
@protocol HGoodsSeeAndSeeDelegate <NSObject>
- (void)clickActionToGoodsDetailVCWithModel:(HGoodsBottomSubModel *)goodsModel;

@end
#import "BaseCell.h"
#import "HGBSeeAndSeeSub.h"
@interface HGBSeeAndSeeCell : BaseCell
@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, weak) id <HGoodsSeeAndSeeDelegate>delegate;
@end
