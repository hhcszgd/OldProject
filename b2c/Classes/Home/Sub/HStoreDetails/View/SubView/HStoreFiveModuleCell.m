//
//  HStoreFiveModuleCell.m
//  b2c
//
//  Created by 0 on 16/3/30.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HStoreFiveModuleCell.h"

@interface HStoreFiveModuleCell()
/**5个功能模块中的被选择的按钮*/
@property (nonatomic, strong) UIButton *selectButton;
@property (nonatomic, strong) UICollectionView *superView;
@end
@implementation HStoreFiveModuleCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self configmentUI];
    }
    return self;
}
- (void)configmentUI{
        NSArray *array = @[@"全部商品", @"全部分类", @"店铺故事", @"店铺介绍", @"荣誉资质"];
        CGFloat width = screenW * 1.0/array.count;
        for (NSInteger i = 0; i < array.count; i++) {
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(i * width, 0, width, self.contentView.bounds.size.height)];
            [self.contentView addSubview:button];
            button.tag = i;
            [button setBackgroundColor:[UIColor whiteColor]];
            [button addTarget:self action:@selector(cageGaryButton:) forControlEvents:UIControlEventTouchUpInside];
            [button setTitle:array[i] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont boldSystemFontOfSize:14];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
//            [self.buttonArray addObject:button];
        }
    
}
#warning 跳转到相应的页面
#pragma mark -- 模块分类的点击方法
- (void)cageGaryButton:(UIButton *)button{
//    if (_selectButton == button) {
//        return;
//    }
//    button.selected = YES;
//    _selectButton.selected = NO;
//    _selectButton = button;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HStoreFiveModuleCell" object:nil userInfo:@{@"tag":@(button.tag)}];
    
}

#pragma mark  赋值
- (void)setCollectionView:(UICollectionView *)collectionView{
    
}

- (void)setModel:(id)model{
    
}

@end
