//
//  UserDefineAlertView.m
//  b2c
//
//  Created by 0 on 16/6/6.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "UserDefineAlertView.h"
@interface UserDefineAlertView()

@end
@implementation UserDefineAlertView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor clearColor];
        self.backView.bounds = CGRectMake(0, 0, 221 *zkqScale *1.2, 116 *zkqScale *1.2);
        self.backView.center = CGPointMake(screenW/2.0, screenH/2.0);
        self.title.center = CGPointMake(screenW/2.0, screenH/2.0 -20);
        self.title.bounds = CGRectMake(0, 0, 221 *zkqScale, 116 *zkqScale);
        self.btn.center = CGPointMake(screenW/2.0, screenH/2.0 + 20);
        self.btn.bounds = CGRectMake(0, 0, 56, 26);
    }
    return self;
}


- (void)show{
    
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.backgroundColor = [[UIColor colorWithHexString:@"000000"] colorWithAlphaComponent:0.3];
        self.backView.bounds = CGRectMake(0, 0, 221 *zkqScale , 116 *zkqScale );
    } completion:^(BOOL finished) {
        
    }];
}

- (void)dismiss{
    [UIView animateWithDuration:0.4 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


- (UIView *)backView{
    if (_backView == nil) {
        _backView= [[UIView alloc] init];
        [self addSubview:_backView];
        _backView.layer.cornerRadius = 6;
        _backView.layer.masksToBounds = YES;
        _backView.backgroundColor = [UIColor whiteColor];
    }
    return _backView;
}
- (UILabel *)title{
    if (_title == nil) {
        _title = [[UILabel alloc] init];
        [self addSubview:_title];
        [_title configmentfont:[UIFont systemFontOfSize:13 *zkqScale] textColor:[UIColor colorWithHexString:@"333333"] backColor:[UIColor clearColor] textAligement:1 cornerRadius:0 text:@""];
        [_title sizeToFit];
    }
    return _title;
}
- (UIButton *)btn{
    if (_btn == nil) {
        _btn = [[UIButton alloc] init];
        [self addSubview:_btn];
        [_btn setTitle:@"确定" forState:UIControlStateNormal];
        _btn.titleLabel.font = [UIFont systemFontOfSize:12 * zkqScale];
        [_btn setTitleColor:THEMECOLOR forState:UIControlStateNormal];
        _btn.layer.masksToBounds = YES;
        _btn.layer.cornerRadius = 3;
        _btn.layer.borderWidth = 1;
        _btn.layer.borderColor = [THEMECOLOR CGColor];
        [_btn addTarget:self action:@selector(tureSelect:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _btn;
}
/**点击确定按钮消失*/
- (void)tureSelect:(UIButton *)btn{
    [self dismiss];
}
@end
