//
//  HShopActiveCell.h
//  b2c
//
//  Created by 0 on 16/5/6.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//
@class HStoreSubModel;
@protocol HShopActiveCellDelegate <NSObject>

/**跳转到店铺活动页面*/
- (void)HShopActiveCellActionToShopActiveWith:(HStoreSubModel *)activeModel;

@end


#import "HStoreBaseCell.h"

@interface HShopActiveCell : HStoreBaseCell<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) NSTimer *timer;
- (void)removeTiemr;
@property (nonatomic, weak) id <HShopActiveCellDelegate>delegate;
@end
