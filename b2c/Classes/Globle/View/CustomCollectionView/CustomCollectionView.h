//
//  CustomCollectionView.h
//  TTmall
//
//  Created by 0 on 16/3/24.
//  Copyright © 2016年 Footway tech. All rights reserved.
//



#import <UIKit/UIKit.h>
/**
 on_off 是否有计时器的开关，如果有是YES，如果没有是NO。
 
 
 */
typedef void(^CustomCollectionViewBlock)(id);

@interface CustomCollectionView : UIView<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>


@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, strong) NSTimer *timer;
/**点击将模型传递给控制器*/
@property (nonatomic, copy) CustomCollectionViewBlock customBlock;
/**初始化方法，主要实现图片的自动或者是非自动轮播*/
- (instancetype)initWithFrame:(CGRect)frame withData:(NSArray *)dataArray pageIndicatorTintColor:(UIColor *)pageIndicatorTintColor currentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor bottom:(CGFloat)bottom right:(CGFloat)right width:(CGFloat)width height:(CGFloat)height;

@end
