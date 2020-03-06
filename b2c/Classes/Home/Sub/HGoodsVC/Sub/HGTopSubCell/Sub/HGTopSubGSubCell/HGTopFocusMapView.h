//
//  HGTopFocusMapView.h
//  b2c
//
//  Created by 0 on 16/4/29.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//焦点图
typedef void(^block)(NSInteger);
#import <UIKit/UIKit.h>

@interface HGTopFocusMapView : UIView<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
- (instancetype)initWithFrame:(CGRect)frame withdataArr:(NSArray *)dataArr;
@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, copy) block myBlock;
@end
