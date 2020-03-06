//
//  GCollectionCell.h
//  b2c
//
//  Created by 0 on 16/4/5.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//
@protocol GestureRecognizerActionDelegate <NSObject>

- (void)singleAction;

@end


#import <UIKit/UIKit.h>

@interface GCollectionCell : UICollectionViewCell
@property (nonatomic, strong) id model;
@property (nonatomic, weak) id <GestureRecognizerActionDelegate>delegate;
@end
