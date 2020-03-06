//
//  FactorySellCell.m
//  b2c
//
//  Created by 0 on 16/4/6.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "FactorySellCell.h"

@interface FactorySellCell()
@property (nonatomic, strong) CustomCollectionView *banner;
@end
@implementation FactorySellCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self configmentUI];
    }
    return self;
}

- (void)configmentUI{
    CustomCollectionView *banner = [[CustomCollectionView alloc] initWithFrame:self.contentView.bounds withData:@[@"1",@"2",@"3"] pageIndicatorTintColor:[UIColor whiteColor] currentPageIndicatorTintColor:[UIColor purpleColor] bottom:10 right:0 width:100 height:30 on_off:YES];
    _banner = banner;
    [self.contentView addSubview:banner];
}

#pragma mark  赋值
- (void)setCollectionView:(UICollectionView *)collectionView{
    
}

- (void)setFactoryModel:(HFactoryBaseModel *)factoryModel{
    LOG(@"%@,%d,%@",[self class], __LINE__,factoryModel.items)
    [super setFactoryModel:factoryModel];
    _banner.dataArr = factoryModel.items;
    __weak typeof(self) Myself = self;
    _banner.customBlock = ^(id model){
      LOG(@"%@,%d,%@",[Myself class], __LINE__,model)
    };
}

@end
