//
//  HSuperBannerCell.h
//  b2c
//
//  Created by 0 on 16/5/5.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//
@class CustomCollectionModel;
@protocol HSuperBannerCellDelegate <NSObject>
- (void)HSuperBannerCellActionToSuperMarketActiveWithSubModel:(CustomCollectionModel *)subModel;


@end
#import "HSuperMarketBaseCell.h"

@interface HSuperBannerCell : HSuperMarketBaseCell
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, weak) id <HSuperBannerCellDelegate>delegate;
/**移除定时器*/
- (void)removeTiemr;
@end
