//
//  HFranchiseHeader.m
//  b2c
//
//  Created by 0 on 16/5/4.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//


#import "HFranchiseHeader.h"
@interface HFranchiseHeader()

@property (nonatomic, strong) UIImageView *leftImage;
@property (nonatomic, strong) UIImageView *rightImage;

@end
@implementation HFranchiseHeader
- (UIImageView *)leftImage{
    if (_leftImage == nil) {
        _leftImage = [[UIImageView alloc] init];
        [self addSubview:_leftImage];
    }
    return _leftImage;
}
- (UIImageView *)rightImage{
    if (_rightImage == nil) {
        _rightImage = [[UIImageView alloc] init];
        [self addSubview:_rightImage];
    }
    return _rightImage;
}
- (UILabel *)titleHeader{
    if (_titleHeader == nil) {
        _titleHeader = [[UILabel alloc] init];
        [self addSubview:_titleHeader];
        [_titleHeader configmentfont:[UIFont systemFontOfSize:14 * SCALE] textColor:[UIColor colorWithHexString:@"333333"] backColor:[UIColor clearColor] textAligement:1 cornerRadius:0 text:@""];
        [_titleHeader sizeToFit];
    }
    return _titleHeader;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor =[UIColor whiteColor] ;
        [self.titleHeader mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.centerX.equalTo(self);
        }];
        [self.leftImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.titleHeader.mas_left).offset(-10);
            make.centerY.equalTo(self);
            make.height.equalTo(@(1.5 * SCALE));
             make.width.equalTo(@(28  *SCALE));
        }];
        self.leftImage.image = [UIImage imageNamed:@"bg_threelines-0"];
        [self.rightImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleHeader.mas_right).offset(10);
            make.centerY.equalTo(self);
             make.width.equalTo(@(28 * SCALE));
            make.height.equalTo(@(1.5 * SCALE));
        }];
        [self.rightImage setImage:[UIImage imageNamed:@"bg_threelines-0"]];
    }
    return self;
}
- (void)setBaseModel:(HFranchiseBaseModel *)baseModel{
    self.titleHeader.text = baseModel.channel;
}





@end
