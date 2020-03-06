//
//  HStoreHeader.m
//  b2c
//
//  Created by 0 on 16/5/6.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HStoreHeader.h"
#import "ClistTopBtn.h"
@interface HStoreHeader()
/**四个按钮中之前被选中的按钮*/
@property (nonatomic, strong) UIButton *selectButton;
/**记录被选中的按钮的下标*/
@property (nonatomic, assign) NSInteger index;
/**数组保存*/
@property (nonatomic, strong) NSMutableArray *buttonArr;
@property (nonatomic, strong) ClistTopBtn *beforselectButton;
@property (nonatomic, assign) BOOL isLowToHeight;
@property (nonatomic, copy) NSString *sortOrder;
/**排序方式*/
@property (nonatomic, assign) NSInteger sort;
/**分页*/
@property (nonatomic, assign) NSInteger pageNumber;
@end



@implementation HStoreHeader

- (NSMutableArray *)buttonArr{
    if (_buttonArr == nil) {
        _buttonArr = [[NSMutableArray alloc] init];
    }
    return _buttonArr;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _isLowToHeight = YES;
        [self configmentCategary];
    }
    return self;
}
/**添加四个点击按钮*/
#pragma mark -- 添加分类的关键词
- (void)configmentCategary{
    NSArray *buttonArray = @[@"推荐",@"销量",@"价格",@"评价"];
    CGFloat width = (screenW - 0)/4.0;
   
    for (int i = 0; i < buttonArray.count; i++) {
        ClistTopBtn *button = [[ClistTopBtn alloc] initWithFrame:CGRectMake(i * width, 0, width, self.frame.size.height) withFont:15 * SCALE WithStr:buttonArray[i]];
        [self addSubview:button];
        button.tag = i;
        if (i == 0) {
            button.selected = YES;
            _beforselectButton = button;
        }
        //设置价格按钮的选择图片
        if (i == 2) {
            [button setImage:[UIImage imageNamed:@"icon_array_nor"] forState:UIControlStateNormal];
        }
        button.frame = CGRectMake(i * width, 0, width, self.frame.size.height);
        button.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
        [button setTitle:buttonArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithHexString:oneLevelUnselectColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithHexString:oneLevelSelectColor] forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont systemFontOfSize:15 * SCALE];
        [button addTarget:self action:@selector(categary:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
   
    
    
    
    
}

#pragma mark -- 根据关键词排行
- (void)categary:(ClistTopBtn *)btn{
    if (_beforselectButton == btn) {
        _isLowToHeight = !_isLowToHeight;
        if (btn.tag == 2) {
            if (_isLowToHeight) {
                [btn setImage:[UIImage imageNamed:@"icon_array_rise"] forState:UIControlStateSelected];
                _sortOrder = classifyAsc;
            }else{
                [btn setImage:[UIImage imageNamed:@"icon_array_drop"] forState:UIControlStateSelected];
                _sortOrder = classifyDesc;
            }
            _pageNumber = 1;
            _sort = btn.tag;
            [self handoverclassification];
        }
        
        
        
        return;
    }
    //如果button被点击的话说明是被选中了
    //排序的时候默认从高到底
    _sortOrder = classifyDesc;
    
    //价格按钮第一被选中的时候默认选择从低到高
    if (btn.tag == 2) {
        [btn setImage:[UIImage imageNamed:@"icon_array_rise"] forState:UIControlStateSelected];
        _isLowToHeight = YES;
        _sortOrder = classifyAsc;
    }
    
    
    btn.selected = YES;
    _beforselectButton.selected = NO;
    _beforselectButton = btn;
    //点击按钮的时候重新加载
    _pageNumber = 1;
    _sort = btn.tag;
    [self handoverclassification];
    
}

- (void)handoverclassification{
    if ([self.delegate respondsToSelector:@selector(requestDataWithsort:sortOrder:)]) {
        [self.delegate performSelector:@selector(requestDataWithsort:sortOrder:) withObject:@(_sort)withObject:_sortOrder];
    }
    
}
- (void)setBaseModel:(HStoreDetailModel *)baseModel{
    
}




@end
