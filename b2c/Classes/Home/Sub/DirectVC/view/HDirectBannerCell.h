//
//  FactorySellCell.h
//  b2c
//
//  Created by 0 on 16/4/6.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HFactoryBaseCell.h"

@class CustomCollectionModel;
@protocol HDirectBannerCellDelegate <NSObject>

/**跳转到厂家直销的活动页面*/
- (void)HDirectBannerCellActionToActiveWithSubModel:(CustomCollectionModel *)subModel;
@end
@interface HDirectBannerCell :HFactoryBaseCell

@property (nonatomic, weak) id <HDirectBannerCellDelegate>delegate;
/**移除定时器*/
- (void)removeTiemr;
@end
