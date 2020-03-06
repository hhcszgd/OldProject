//
//  GCollectionView.h
//  b2c
//
//  Created by 0 on 16/4/5.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//
@class BrowsePicturesView;
@protocol HindleFromSuperView <NSObject>
@optional
- (void)hindleView:(BrowsePicturesView *)gcollection;

@end
#import <UIKit/UIKit.h>

@interface BrowsePicturesView : UIView
- (instancetype)initWithFrame:(CGRect)frame withIndexPath:(NSIndexPath *)indexpath withArr:(NSArray *)arr;
@property (nonatomic, weak) id <HindleFromSuperView>delegate;
@end
