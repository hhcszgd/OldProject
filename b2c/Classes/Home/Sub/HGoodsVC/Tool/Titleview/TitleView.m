//
//  TitleView.m
//  TTmall
//
//  Created by 0 on 16/1/7.
//  Copyright © 2016年 Footway tech. All rights reserved.
//

#import "TitleView.h"
@interface TitleView()
{
    UIButton *_selectedButton;
    UIView *_smallview;
    CGFloat lead;
    CGFloat top;
    CGFloat bottom;
    CGFloat tral;
    CGFloat intervalcount;
    CGSize size;

    CGFloat _widthcount;
    CGFloat _heightcount;
}
@property (nonatomic, strong) NSMutableArray *buttonArray;
@end


@implementation TitleView

- (instancetype)initWithFrame:(CGRect)frame withTitleArray:(NSArray *)titleArray withFont:(CGFloat)font{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        _buttonArray = [@[] mutableCopy];
        lead = 0;
        top = 0;
        bottom = 2;
        tral = 0;
        _widthcount =0;
        _heightcount = 0;
        self.defaultColor = THEMECOLOR;
        NSMutableArray *sizeArr = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < titleArray.count; i++) {
            NSString *titleStr = titleArray[0];
            CGSize s  = [titleStr sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:font],NSFontAttributeName, nil]];
            NSValue *value = [NSValue valueWithCGSize:s];
            _widthcount = _widthcount + s.width;
            [sizeArr addObject:value];
        }
        intervalcount = (self.frame.size.width - _widthcount)/2.0;
        
        
        
        for (int i = 0; i < titleArray.count; i++) {
            CGSize titleSize = [sizeArr[i] CGSizeValue];
//            top = (self.frame.size.height - titleSize.height)/2.0;
            top= 0;
            _widthcount = titleSize.width;
            _heightcount = frame.size.height - 2;
            
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(lead + i * _widthcount + i * intervalcount, top, _widthcount, _heightcount)];
            [self addSubview:button];
            [button setTitle:titleArray[i] forState:UIControlStateNormal];
//            button.titleLabel.adjustsFontSizeToFitWidth = YES;
            [button setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
            [button setTitleColor:self.defaultColor forState:UIControlStateSelected];
            
            button.titleLabel.font = [UIFont systemFontOfSize:font];
            [button setBackgroundColor:[UIColor clearColor]];
            
            size = [button.titleLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:button.titleLabel.font,NSFontAttributeName, nil]];
            button.tag = i;
            [button addTarget:self action:@selector(topButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            if (i == 0) {
                button.selected = YES;
                _selectedButton = button;
                
                
            }
            [_buttonArray addObject:button];
        }
        UIButton *button = _buttonArray[0];
        _smallview = [[UIView alloc] init];
        CGPoint center = button.center;
        center.y = self.frame.size.height - bottom/2.0;
        _smallview.center = center;
        _smallview.bounds = CGRectMake(0, 0, 40 , bottom);
        
        _smallview.backgroundColor = self.defaultColor;
        [self addSubview:_smallview];
         
    }
    return self;
}

- (void)topButtonClick:(UIButton *)button{
    
    _selectedButton.selected = NO;
    _selectedButton = button;
    _selectedButton.selected = YES;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2f];
    CGPoint center = button.center;
    center.y = self.frame.size.height - bottom/2.0;
    _smallview.center = center;
    _smallview.bounds = CGRectMake(0, 0, 40 , bottom);
    [UIView commitAnimations];
    if ([self.delegate respondsToSelector:@selector(titleViewScrollToTarget:)]) {
        [self.delegate performSelector:@selector(titleViewScrollToTarget:) withObject:@(button.tag)];
    }
    
    
}

- (void)configmentSelectButtonWithItem:(NSInteger)item{
    
    UIButton *button = _buttonArray[item];
    _selectedButton.selected = NO;
    _selectedButton = button;
    _selectedButton.selected = YES;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    CGPoint center = button.center;
    center.y = self.frame.size.height - bottom/2.0;
    _smallview.center = center;
    _smallview.bounds = CGRectMake(0, 0, 40 , bottom);
    [UIView commitAnimations];
}
- (void)setDefaultColor:(UIColor *)defaultColor{
    _defaultColor = defaultColor;
    for (UIButton *btn in self.buttonArray) {
        [btn setTitleColor:defaultColor forState:UIControlStateSelected];
        
    }
    _smallview.backgroundColor = defaultColor;
}

@end
