//
//  ConponSelectView.m
//  b2c
//
//  Created by 0 on 16/4/21.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "ConponSelectView.h"
@interface ConponSelectView()
@property (nonatomic, strong) MASConstraint *centerXContraint;
@end
@implementation ConponSelectView
- (UILabel *)leftLabel{
    if (_leftLabel == nil) {
        _leftLabel = [[UILabel alloc] init];
        [self addSubview:_leftLabel];
        _leftLabel.userInteractionEnabled = YES;
    }
    return _leftLabel;
}
- (UILabel *)midleLabel{
    if (_midleLabel == nil) {
        _midleLabel = [[UILabel alloc] init];
        [self addSubview:_midleLabel];
        _midleLabel.userInteractionEnabled = YES;
    }
    return _midleLabel;
}

- (UILabel *)rightLabel{
    if (_rightLabel == nil) {
        _rightLabel= [[UILabel alloc] init];
        [self addSubview:_rightLabel];
        _rightLabel.userInteractionEnabled = YES;
    }
    return _rightLabel;
}
- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        [self addSubview:_lineView];
    }
    return _lineView;
}



- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
       
        self.backgroundColor = [UIColor whiteColor];
        //布局
        CGFloat Width = frame.size.width/3.0;
        CGFloat height = frame.size.height;
        self.leftLabel.frame = CGRectMake(0, 0, Width, height);
        self.midleLabel.frame = CGRectMake(self.leftLabel.frame.size.width + self.leftLabel.frame.origin.x, 0, Width, height);
        self.rightLabel.frame = CGRectMake(self.midleLabel.frame.size.width + self.midleLabel.frame.origin.x, 0, Width, height);
        
        self.lineView.backgroundColor = [UIColor redColor];
        
        
        [self.leftLabel configmentfont:[UIFont boldSystemFontOfSize:15 *SCALE] textColor:[UIColor blackColor] backColor:[UIColor clearColor] textAligement:1 cornerRadius:0. text:@"未使用(0)"];
        
        [self.midleLabel configmentfont:[UIFont boldSystemFontOfSize:15 *SCALE] textColor:[UIColor blackColor] backColor:[UIColor clearColor] textAligement:1 cornerRadius:0. text:@""];
        
        
        [self.rightLabel configmentfont:[UIFont boldSystemFontOfSize:15 *SCALE] textColor:[UIColor blackColor] backColor:[UIColor clearColor] textAligement:1 cornerRadius:0. text:@""];
        CGSize lineWidth = [self.leftLabel.text sizeWithFont:[UIFont boldSystemFontOfSize:15 *SCALE] MaxSize:CGSizeMake(screenW/3.0, frame.size.height)];
        [self.lineView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self);
            make.height.equalTo(@(2));
             make.width.equalTo(@(lineWidth.width +10));
            self.centerXContraint = make.centerX.equalTo(self.leftLabel);
        }];
        
        UITapGestureRecognizer *leftTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(leftTap:)];
        _leftTap = leftTap;
        [self.leftLabel addGestureRecognizer:leftTap];
        
        UITapGestureRecognizer *midleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(midleTap:)];
        _midleTap = midleTap;
        [self.midleLabel addGestureRecognizer:midleTap];
        
        UITapGestureRecognizer *rightTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rightTap:)];
        _rightTap = rightTap;
        [self.rightLabel addGestureRecognizer:rightTap];
        
        
        
        
        
        self.leftLabel.tag = 0;
        self.midleLabel.tag = 1;
        self.rightLabel.tag = 2;
        
    }
    return self;
}
- (void)leftTap:(UITapGestureRecognizer *)leftTap{
//    LOG(@"%@,%d,%ld",[self class], __LINE__,leftTap.view.tag)
    
    CGSize lineSize = [self.leftLabel gotSizeWithLabel];
    [self.centerXContraint uninstall];
    [self.lineView mas_updateConstraints:^(MASConstraintMaker *make) {
       self.centerXContraint =  make.centerX.equalTo(self.leftLabel.mas_centerX);
        make.width.equalTo(@(lineSize.width +10));
        
    }];
    [self setNeedsUpdateConstraints];
    [self needsUpdateConstraints];
    [UIView animateWithDuration:0.2 animations:^{
        
        [self layoutIfNeeded];
    }];
    if ([self.delegate respondsToSelector:@selector(scrollToTargetindexPath:)]) {
        [self.delegate performSelector:@selector(scrollToTargetindexPath:) withObject:@(leftTap.view.tag)];
    }
}


- (void)midleTap:(UITapGestureRecognizer *)midleTap{
    [self.centerXContraint uninstall];
    CGSize lineSize = [self.midleLabel gotSizeWithLabel];
    [self.lineView mas_updateConstraints:^(MASConstraintMaker *make) {
     self.centerXContraint =   make.centerX.equalTo(self.midleLabel.mas_centerX);
        make.width.equalTo(@(lineSize.width +10));
        
    }];
    [self setNeedsUpdateConstraints];
    [self needsUpdateConstraints];
    
    [UIView animateWithDuration:0.2 animations:^{
        [self layoutIfNeeded];
    }];
    if ([self.delegate respondsToSelector:@selector(scrollToTargetindexPath:)]) {
        [self.delegate performSelector:@selector(scrollToTargetindexPath:) withObject:@(midleTap.view.tag)];
    }
}
- (void)rightTap:(UITapGestureRecognizer *)rightTap{
    [self.centerXContraint uninstall];
    CGSize lineSize = [self.rightLabel gotSizeWithLabel];
    [self.lineView mas_updateConstraints:^(MASConstraintMaker *make) {
      self.centerXContraint =  make.centerX.equalTo(self.rightLabel.mas_centerX);
        make.width.equalTo(@(lineSize.width +10));
        
    }];
    
    [self setNeedsUpdateConstraints];
    [self needsUpdateConstraints];
    [UIView animateWithDuration:0.2 animations:^{
        [self layoutIfNeeded];
    }];
    
    
    if ([self.delegate respondsToSelector:@selector(scrollToTargetindexPath:)]) {
        [self.delegate performSelector:@selector(scrollToTargetindexPath:) withObject:@(rightTap.view.tag)];
    }
    
}
- (void)setLeftStr:(NSString *)leftStr{
    _leftStr = leftStr;
    self.leftLabel.text = leftStr;
}
- (void)setMidleStr:(NSString *)midleStr{
    _midleStr = midleStr;
    self.midleLabel.text = midleStr;
}
-(void)setRightStr:(NSString *)rightStr{
    _rightStr = rightStr;
    self.rightLabel.text = rightStr;
}

@end
