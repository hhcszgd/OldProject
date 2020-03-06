//
//  ConponSelectView.h
//  b2c
//
//  Created by 0 on 16/4/21.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//
@protocol ConponScrollToTargetDelegate <NSObject>

- (void)scrollToTargetindexPath:(id)index;

@end
#import <UIKit/UIKit.h>

@interface ConponSelectView : UIView
@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UILabel *midleLabel;
@property (nonatomic, strong) UILabel *rightLabel;
@property (nonatomic, strong) UIView  *lineView;


@property (nonatomic, copy) NSString *leftStr;
@property (nonatomic, copy) NSString *midleStr;
@property (nonatomic, copy) NSString *rightStr;
@property (nonatomic, weak) id <ConponScrollToTargetDelegate>delegate;



@property (nonatomic, strong) UITapGestureRecognizer *leftTap;
@property (nonatomic, strong) UITapGestureRecognizer *midleTap;
@property (nonatomic, strong) UITapGestureRecognizer *rightTap;

- (void)leftTap:(UITapGestureRecognizer *)leftTap;
- (void)midleTap:(UITapGestureRecognizer *)midleTap;
- (void)rightTap:(UITapGestureRecognizer *)rightTap;
@end
