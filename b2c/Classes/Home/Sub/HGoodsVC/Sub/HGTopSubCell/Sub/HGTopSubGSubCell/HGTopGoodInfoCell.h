//
//  HGTopGoodInfoCell.h
//  b2c
//
//  Created by 0 on 16/4/29.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//商品信息


@protocol HGTopGoodInfoCellDelegate <NSObject>

@optional
/**分享*/
- (void)HGTopGoodInfoCellShar;

@end


#import <UIKit/UIKit.h>
#import "HGoodsSubGinfoModel.h"

@interface HGTopGoodInfoCell : UITableViewCell
@property (nonatomic, strong) HGoodsSubGinfoModel *infoModel;
@property (nonatomic, weak) id <HGTopGoodInfoCellDelegate>delegate;
@end
