//
//  HAPBannerCell.h
//  b2c
//
//  Created by 0 on 16/4/7.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//
@class CustomCollectionModel;
@protocol HAPBannerCellDelegate <NSObject>

/**跳转到活动页面*/
- (void)HAPBannerCellActionToHEaActiveWithSubModel:(CustomCollectionModel *)sucModel;

@end

#import <UIKit/UIKit.h>
#import "HEaBaseCell.h"
@interface HAPBannerCell :HEaBaseCell<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, weak) id <HAPBannerCellDelegate>delegate;

/**移除定时器*/
- (void)removeTiemr;
@end
