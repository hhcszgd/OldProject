//
//  HGBSeeAndSeeHeader.h
//  b2c
//
//  Created by 0 on 16/5/14.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HGBSeeAndSeeHeader : UICollectionReusableView
/**猜你喜欢*/
@property (nonatomic, strong) UILabel *guessLabel;
/**右边的细线*/
@property (nonatomic, strong) UIView *rightLineView;
/**左边写细线*/
@property (nonatomic, strong) UIView *leftLineView;
@end