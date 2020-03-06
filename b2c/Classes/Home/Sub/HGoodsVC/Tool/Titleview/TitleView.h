//
//  TitleView.h
//  TTmall
//
//  Created by 0 on 16/1/7.
//  Copyright © 2016年 Footway tech. All rights reserved.
//

@protocol TitleViewDelegate <NSObject>

- (void)titleViewScrollToTarget:(id)index;

@end


#import <UIKit/UIKit.h>

@interface TitleView : UIView

- (void)configmentSelectButtonWithItem:(NSInteger)item;
- (instancetype)initWithFrame:(CGRect)frame withTitleArray:(NSArray *)titleArray withFont:(CGFloat )font;

@property (nonatomic, weak) id <TitleViewDelegate>delegate;
@property (nonatomic, strong) UIColor *defaultColor;

@end
