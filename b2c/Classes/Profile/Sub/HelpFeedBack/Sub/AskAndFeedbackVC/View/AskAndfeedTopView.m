//
//  AskAndfeedTopView.m
//  b2c
//
//  Created by 张凯强 on 16/7/9.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "AskAndfeedTopView.h"
@interface AskAndfeedTopView()

/**self的位置*/
@property (nonatomic,assign) viewFrame leftOrRight;
/**底线*/
@property (nonatomic, strong)UIView *bottomView;
/**左边的选中线*/
@property (nonatomic, strong) UIView *leftLine;
/**右边的选中线*/
@property (nonatomic, strong) UIView *rightLine;

/**竖线*/
@property (nonatomic, strong) UIView *vertialLine;

@end
@implementation AskAndfeedTopView
- (UIView *)vertialLine{
    if (_vertialLine == nil) {
        _vertialLine = [[UIView alloc] init];
        _vertialLine.backgroundColor = [UIColor colorWithHexString:@"dfdfdd"];
        [self addSubview:_vertialLine];
    }
    return _vertialLine;
}


- (UIView *)leftLine{
    if (_leftLine == nil) {
        _leftLine = [[UIView alloc] init];
        _leftLine.backgroundColor = THEMECOLOR;
        [self addSubview:_leftLine];
        _leftLine.hidden = NO;
    }
    return _leftLine;
}
- (UIView *)rightLine{
    if (_rightLine == nil) {
        _rightLine = [[UIView alloc] init];
        [_rightLine setBackgroundColor:THEMECOLOR];
        [self addSubview:_rightLine];
         _rightLine.hidden = YES;
    }
    return _rightLine;
}


- (UILabel *)leftTitleLabel{
    if (_leftTitleLabel == nil) {
        _leftTitleLabel = [[UILabel alloc] init];
        [self addSubview:_leftTitleLabel];
        [_leftTitleLabel configmentfont:[UIFont systemFontOfSize:14 * SCALE] textColor:[UIColor colorWithHexString:@"333333"] backColor:[UIColor whiteColor] textAligement:1 cornerRadius:0 text:@"体验问题"];
        UITapGestureRecognizer *leftTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAction:)];
        [_leftTitleLabel addGestureRecognizer:leftTap];
        _leftTitleLabel.userInteractionEnabled = YES;
        [self clickAction:leftTap];
    }
    return _leftTitleLabel;
}
- (UILabel *)rightTitleLabel{
    if (_rightTitleLabel == nil) {
        _rightTitleLabel = [[UILabel alloc] init];
        [self addSubview:_rightTitleLabel];
        [_rightTitleLabel configmentfont:[UIFont systemFontOfSize:14 * SCALE] textColor:[UIColor colorWithHexString:@"333333"] backColor:[UIColor whiteColor] textAligement:1 cornerRadius:0 text:@"商品、商家投诉"];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAction:)];
        [_rightTitleLabel addGestureRecognizer:tap];
        _rightTitleLabel.userInteractionEnabled = YES;
    }
    return _rightTitleLabel;
}


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
- (UIView*)bottomView{
    if (_bottomView == nil) {
        _bottomView  =[[UIView alloc] init];
        _bottomView.backgroundColor = [UIColor colorWithHexString:@"dfdfdd"];
        [self addSubview:_bottomView];
    }
    return _bottomView;
}

- (void)layoutSubviews{
    self.leftTitleLabel.frame =CGRectMake(0, 0, self.frame.size.width/2.0, self.frame.size.height);
    self.rightTitleLabel.frame = CGRectMake(self.frame.size.width/2.0, 0, self.frame.size.width/2.0, self.frame.size.height);
    self.bottomView.frame = CGRectMake(0, self.frame.size.height - 1, self.frame.size.width, 1);
    self.rightLine.frame = CGRectMake(self.frame.size.width/2.0, self.frame.size.height - 2, self.frame.size.width/2.0 -10, 2);
    self.leftLine.frame = CGRectMake(10, self.frame.size.height - 2, self.frame.size.width/2.0 -10, 2);
    
    
    self.vertialLine.frame = CGRectMake((self.frame.size.width -1 * SCALE)/2.0, (self.frame.size.height - 26* SCALE)/2.0, 1, 26 * SCALE);
    
    
    
}
/**点击方法*/

- (void)clickAction:(UITapGestureRecognizer *)tap{
    UILabel *tapLabel = (UILabel *)tap.view;
    if (tapLabel == self.leftTitleLabel) {
        _rightLine.hidden = YES;

        _leftLine.hidden = NO;
        
    }else{
        _rightLine.hidden = NO;

        _leftLine.hidden = YES;
    }
    if ([self.delegate respondsToSelector:@selector(askAndfeedTopView:)]) {
        [self.delegate performSelector:@selector(askAndfeedTopView:) withObject:tap.view];
    }
    
}


@end
