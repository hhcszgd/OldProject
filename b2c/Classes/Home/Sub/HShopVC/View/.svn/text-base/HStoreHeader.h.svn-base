//
//  HStoreHeader.h
//  b2c
//
//  Created by 0 on 16/5/6.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//
@protocol StoreHeaderDelegate <NSObject>

- (void)requestDataWithsort:(id)sort sortOrder:(NSString *)sortOrder;

@end
#import <UIKit/UIKit.h>
#import "HStoreDetailModel.h"
@interface HStoreHeader : UICollectionReusableView
@property (nonatomic, assign) NSInteger selecIndex;
@property (nonatomic, weak) id <StoreHeaderDelegate>delegate;
@property (nonatomic, strong) HStoreDetailModel *baseModel;
@end
