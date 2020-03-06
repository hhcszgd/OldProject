//
//  CCancleOrderHeader.m
//  b2c
//
//  Created by 0 on 16/5/26.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "CCancleOrderHeader.h"
@interface CCancleOrderHeader()

@end
@implementation CCancleOrderHeader
- (UILabel *)titleLbale{
    if (_titleLbale == nil) {
        _titleLbale = [[UILabel alloc] init];
        [self addSubview:_titleLbale];
        [_titleLbale configmentfont:[UIFont systemFontOfSize:15 *zkqScale] textColor:[UIColor colorWithHexString:@"333333"] backColor:[UIColor clearColor] textAligement:0 cornerRadius:0 text:@""];
        [_titleLbale sizeToFit];
    }
    return _titleLbale;
}
- (UILabel *)subTitle{
    if (_subTitle == nil) {
        _subTitle = [[UILabel alloc] init];
        [self addSubview:_subTitle];
        [_subTitle configmentfont:[UIFont systemFontOfSize:13 *zkqScale] textColor:[UIColor colorWithHexString:@"999999"] backColor:[UIColor clearColor] textAligement:0 cornerRadius:0 text:@""];
        [_subTitle sizeToFit];
    }
    return _subTitle;
}
- (UIButton *)btn{
    if (_btn == nil) {
        _btn = [[UIButton alloc] init];
        [self addSubview:_btn];
        [_btn setTitle:@"去逛逛" forState:UIControlStateNormal];
        [_btn setTitleColor:THEMECOLOR forState:UIControlStateNormal];
        [_btn setBackgroundColor:[UIColor whiteColor]];
        _btn.layer.borderWidth = 1;
        _btn.layer.borderColor = [THEMECOLOR CGColor];
        [_btn addTarget:self action:@selector(toseesee:) forControlEvents:UIControlEventTouchUpInside];
        _btn.titleLabel.font = [UIFont systemFontOfSize:12 *zkqScale];
        _btn.layer.cornerRadius = 2;
        _btn.layer.masksToBounds = YES;
    }
    return _btn;
}
#pragma mark -- 去看看
- (void)toseesee:(UIButton *)button{
    LOG(@"%@,%d,%@",[self class], __LINE__,@"去逛逛")
    if ([self.delegate respondsToSelector:@selector(CCancleOrderHeaderBackRootVC)]) {
        [self.delegate performSelector:@selector(CCancleOrderHeaderBackRootVC)];
    }
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self.titleLbale mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(19);
            make.centerX.equalTo(self);
        }];
        [self.subTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLbale.mas_left).offset(0);
            make.top.equalTo(self.titleLbale.mas_bottom).offset(25);
        }];
        [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.subTitle);
            make.left.equalTo(self.subTitle.mas_right).offset(10);
             make.width.equalTo(@(61));
            make.height.equalTo(@(31));
        }];
        UIView *bottomView = [[UIView alloc] init];
        [self addSubview:bottomView];
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.height.equalTo(@(44));
        }];
        bottomView.backgroundColor = BackgroundGray;
        UILabel *guessYouLike = [[UILabel alloc] init];
        [bottomView addSubview:guessYouLike];
        [guessYouLike configmentfont:[UIFont systemFontOfSize:14 *zkqScale] textColor:[UIColor colorWithHexString:@"333333"] backColor:[UIColor clearColor] textAligement:0 cornerRadius:0 text:@"猜你喜欢"];
        [guessYouLike sizeToFit];
        [guessYouLike mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(bottomView);
            make.centerX.equalTo(bottomView);
        }];
        UIView *leftView = [[UIView alloc] init];
        [bottomView addSubview:leftView];
        leftView.backgroundColor = [UIColor colorWithHexString:@"333333"];
        [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(bottomView.mas_left).offset(10);
            make.right.equalTo(guessYouLike.mas_left).offset(-10);
            make.height.equalTo(@(1));
            make.centerY.equalTo(bottomView);
        }];
        
        UIView *rightView = [[UIView alloc] init];
        [bottomView addSubview:rightView];
        rightView.backgroundColor = [UIColor colorWithHexString:@"333333"];
        [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(guessYouLike.mas_right).offset(10);
            make.right.equalTo(bottomView.mas_right).offset(-10);
            make.centerY.equalTo(bottomView);
            make.height.equalTo(@(1));
        }];
    }
    return self;
}

@end
