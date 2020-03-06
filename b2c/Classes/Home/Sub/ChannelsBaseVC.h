//
//  ChannelsBaseVC.h
//  b2c
//
//  Created by 0 on 16/4/6.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//
#import "BaseWebVC.h"
#import "SecondBaseVC.h"
#import "ChannelRefreshHeader.h"
#import "GuessYouLikeHeader.h"
#import "ChannelRefreshFooter.h"
//#import "b2c-Swift.h"
#import "ShopCar.h"
@interface ChannelsBaseVC :SecondBaseVC

@property (nonatomic, assign) NSInteger pageNumber;
/**刷新头*/
@property (nonatomic, strong) ChannelRefreshHeader *refreshHeader;
/**刷新尾*/
@property (nonatomic, strong) ChannelRefreshFooter *refreshFooter;
/**滑动到顶部按钮*/
@property (nonatomic, strong) UIButton *scrollToTopBtn;
/**滑动collectionview*/
@property (nonatomic, strong) UICollectionView *col;
/**布局类*/
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) ShopCar *shopCarBtn;

/**下来刷新*/
- (void)downRefresh;
/**上拉刷新*/
- (void)upRefresh;

- (void)actionToSearch:(ActionBaseView *)searchView;
- (void)configmentNavigation;
- (void)message:(ActionBaseView *)message;
- (void)search:(ActionBaseView *)searchBtn;
/**滑动到顶部*/
- (void)scrollToTop;
- (void)configmentUI;
@end
