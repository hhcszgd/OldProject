//
//  HGMoreView.h
//  b2c
//
//  Created by 0 on 16/4/29.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//
@protocol HGMoreViewDelegate <NSObject>

- (void)HGMoreViewActionToTatargWithIndexPath:(NSIndexPath *)indexPath;

@end
#import "ActionBaseView.h"

@interface HGMoreView : ActionBaseView
@property (nonatomic, strong) UIImageView *moreView;

- (instancetype)initWithFrame:(CGRect)frame;
- (instancetype)initWithFrame:(CGRect)frame withDataArr:(NSArray *)menuArr fatherVC:(SecondBaseVC*)vc cellHeihgt:(CGFloat)cellHeight;
@property (nonatomic, weak) id <HGMoreViewDelegate>delegate;

@end
