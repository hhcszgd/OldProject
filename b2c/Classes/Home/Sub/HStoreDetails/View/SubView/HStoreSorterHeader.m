//
//  HStoreSorterHeader.m
//  b2c
//
//  Created by 0 on 16/3/30.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HStoreSorterHeader.h"

@interface HStoreSorterHeader()
/**四个按钮中之前被选中的按钮*/
@property (nonatomic, strong) UIButton *selectButton;
/**记录被选中的按钮的下标*/
@property (nonatomic, assign) NSInteger index;
/**数组保存*/
@property (nonatomic, strong) NSMutableArray *buttonArr;
@end



@implementation HStoreSorterHeader

- (NSMutableArray *)buttonArr{
    if (_buttonArr == nil) {
        _buttonArr = [[NSMutableArray alloc] init];
    }
    return _buttonArr;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self configmentfourButtonInHeaderView:self];
    }
    return self;
}
/**添加四个点击按钮*/
- (void)configmentfourButtonInHeaderView:(UIView *)headerView{
    NSArray *array = @[@"推荐", @"销量", @"价格", @"评价"];
    CGFloat width = screenW * 1.0/array.count;
    for (NSInteger i = 0; i < array.count; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(i * width, 0, width, self.frame.size.height)];
        [headerView addSubview:button];
        button.tag = i;
        if (i == 0) {
            
            [self cageGaryButton:button];
        }
        [button setBackgroundColor:[UIColor whiteColor]];
        [button addTarget:self action:@selector(cageGaryButton:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:array[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [self.buttonArr addObject:button];
    }
    
}
#pragma mark -- 模块分类的点击方法
- (void)cageGaryButton:(UIButton *)button{
    if (_selectButton == button) {
        return;
    }
    _index = button.tag;
    button.selected = YES;
    _selectButton.selected = NO;
    _selectButton = button;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HStoreSorterHeader" object:nil userInfo:@{@"index":@(_index)}];
    
}

- (void)setSelecIndex:(NSInteger)selecIndex{
    UIButton *button = self.buttonArr[selecIndex];
    [self cageGaryButton:button];
}

@end
