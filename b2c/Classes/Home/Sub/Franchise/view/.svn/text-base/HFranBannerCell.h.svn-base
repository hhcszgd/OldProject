//
//  HFranBannerCell.h
//  b2c
//
//  Created by 0 on 16/4/7.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

@class CustomCollectionModel;
@protocol HFranBannerCellDelegate <NSObject>

/**跳转到活动页面*/
- (void)HFranBannerCellActionToActiveWithSubModel:(CustomCollectionModel *)subModel;

@end


#import <UIKit/UIKit.h>
#import "HFranchiseBaseCell.h"
@interface HFranBannerCell : HFranchiseBaseCell
@property (nonatomic, weak) id <HFranBannerCellDelegate>delegate;
/**移除定时器*/
- (void)removeTiemr;
@end
