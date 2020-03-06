//
//  HBBannerCell.h
//  b2c
//
//  Created by 0 on 16/4/6.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//
@class CustomCollectionModel;
@protocol HBBannerCellDelegate <NSObject>
/**跳转到女婴管的活动页面*/
- (void)HBBannerCellActionToBabyActiveWithSubModel:(CustomCollectionModel *)subModel;

@end


#import <UIKit/UIKit.h>
#import "HBabyBaseCell.h"

@interface HBBannerCell : HBabyBaseCell
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, weak) id <HBBannerCellDelegate>delegate;
/**移除定时器*/
- (void)removeTiemr;
@end
