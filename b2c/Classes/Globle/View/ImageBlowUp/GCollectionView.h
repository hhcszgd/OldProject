//
//  GCollectionView.h
//  b2c
//
//  Created by 0 on 16/4/5.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//
@class GCollectionView;
@protocol HindleFromSuperView <NSObject>

- (void)hindleView:(GCollectionView *)gcollection;

@end
#import <UIKit/UIKit.h>

@interface GCollectionView : UIView
- (instancetype)initWithFrame:(CGRect)frame withIndexPath:(NSIndexPath *)indexpath withArr:(NSArray *)arr;
@property (nonatomic, weak) id <HindleFromSuperView>delegate;
@end
