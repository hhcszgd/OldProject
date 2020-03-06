//
//  CateGaryItem.h
//  TTmall
//
//  Created by 0 on 16/1/28.
//  Copyright © 2016年 Footway tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HSepcSubTypeDetailModel.h"
@class HSpecItem;
@protocol sizeAndColorDelegate<NSObject>

- (void)cateCarycell:(HSpecItem *)cateGaryitem atIndexPath:(NSIndexPath *)indexPath button:(UIButton *)button;

@end
@interface HSpecItem : UICollectionViewCell
@property (nonatomic, strong) HSepcSubTypeDetailModel *deatilModel;

@property (nonatomic, strong) UIButton *button;
@property (nonatomic, weak) id <sizeAndColorDelegate>delegate;
@property (nonatomic, strong) UICollectionView *fatherView;



@end
