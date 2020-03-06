//
//  HBabyGirlHeader.m
//  b2c
//
//  Created by 0 on 16/4/7.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HBabyGirlHeader.h"

@interface HBabyGirlHeader()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *img;
@property (nonatomic, strong) UIView *leftView;
@property (nonatomic, strong) UIView *rightView;

@end
@implementation HBabyGirlHeader
- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        [self addSubview:_titleLabel];
        [_titleLabel configmentfont:[UIFont boldSystemFontOfSize:14 * SCALE] textColor:[UIColor colorWithHexString:@"333333"] backColor:[UIColor clearColor] textAligement:1 cornerRadius:0 text:@""];
        [_titleLabel sizeToFit];
    }
    return _titleLabel;
}
- (UIPageControl *)page{
    if (_page == nil) {
        
    }
    return _page;
}
- (UIImageView *)img{
    if (_img == nil) {
        _img = [[UIImageView alloc] init];
        [self addSubview:_img];
    }
    return _img;
}
- (UIView *)leftView{
    if (_leftView == nil) {
        _leftView = [[UIView alloc] init];
        [self addSubview:_leftView];
    }
    return _leftView;
}

- (UIView *)rightView{
    if (_rightView == nil) {
        _rightView = [[UIView alloc] init];
        [self addSubview:_rightView];
    }
    return _rightView;
}



- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.centerX.equalTo(self);
        }];
        
//        _page = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
//        [self addSubview:_page];
#pragma mark -- 设置page
//        [_page mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerY.equalTo(self);
//            make.right.equalTo(self.mas_right).offset(-20);
//            make.width.equalTo(@(60));
//            make.height.equalTo(@(30));
//        }];
//        _page.backgroundColor = [UIColor redColor];
//        _page.numberOfPages = 2;
//        _page.currentPageIndicatorTintColor = [UIColor redColor];
//        _page.pageIndicatorTintColor = [UIColor blackColor];
        [self.img mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.titleLabel);
            make.right.equalTo(self.titleLabel.mas_left).offset(-5);
            make.height.equalTo(@(12));
             make.width.equalTo(@(12));
        }];
        
        
        [self.leftView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.img.mas_left).offset(-20);
             make.width.equalTo(@(94 * SCALE));
            make.height.equalTo(@(1));
            make.centerY.equalTo(self);
        }];
       
        
        
        [self.rightView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLabel.mas_right).offset(20);
            make.width.equalTo(@(94 * SCALE));
            make.height.equalTo(@(1));
            make.centerY.equalTo(self);
        }];
        self.rightView.backgroundColor = [UIColor colorWithHexString:@"e4e4e4"];
        self.leftView.backgroundColor = [UIColor colorWithHexString:@"e4e4e4"];
        
        

    }
    return self;
}



- (void)setBabyModel:(HBabyBaseModel *)babyModel{
    self.titleLabel.text = babyModel.channel;

}
- (void)setTitleImage:(UIImage *)titleImage{
    
    self.img.image = titleImage;
    if (self.img.image == nil) {
        [self.leftView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.img.mas_left).offset(-5);
            make.width.equalTo(@(94 * SCALE));
            make.height.equalTo(@(1));
            make.centerY.equalTo(self);
        }];
        
    }else{
        [self.img mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.titleLabel);
            make.right.equalTo(self.titleLabel.mas_left).offset(-5);
            make.width.equalTo(@(titleImage.size.width));
            make.height.equalTo(@(titleImage.size.height));
        }];
        [self.leftView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.img.mas_left).offset(-5);
            make.width.equalTo(@(94 * SCALE));
            make.height.equalTo(@(1));
            make.centerY.equalTo(self);
        }];
    }
    
}



@end
