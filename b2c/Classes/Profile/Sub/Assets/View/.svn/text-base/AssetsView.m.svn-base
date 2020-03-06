//
//  AssetsView.m
//  b2c
//
//  Created by 0 on 16/4/20.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "AssetsView.h"
@interface AssetsView()
/**左边的图片*/
@property (nonatomic, strong) UIImageView *leftImage;
/**左边的文字*/
@property (nonatomic, strong) UILabel *leftLabel;
/**右边的箭头*/
@property (nonatomic, strong) UIImageView *arrowImage;
@end
@implementation AssetsView
- (UIImageView *)leftImage{
    if (_leftImage == nil) {
        _leftImage = [[UIImageView alloc] init];
        [self addSubview:_leftImage];
    }
    return _leftImage;
}
- (UILabel *)leftLabel{
    if (_leftLabel == nil) {
        _leftLabel= [[UILabel alloc] init];
        [self addSubview:_leftLabel];
    }
    return _leftLabel;
}
- (UIImageView *)arrowImage{
    if (_arrowImage == nil) {
        _arrowImage = [[UIImageView alloc] init];
        [self addSubview:_arrowImage];
    }
    return _arrowImage;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.userInteractionEnabled = YES;
        [self.leftImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self).offset(10);
             make.width.equalTo(@(30));
            make.height.equalTo(@(30));
        }];
        [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.leftImage.mas_right).offset(5);
            make.centerY.equalTo(self);
            
        }];
        [self.leftLabel sizeToFit];
        [self.arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.right.equalTo(self.mas_right).offset(-10);
             make.width.equalTo(@(20));
            make.height.equalTo(@(20));
        }];
    }
    return self;
}
- (void)setTitleImage:(UIImage *)TitleImage{
    self.leftImage.image = TitleImage;
}
- (void)setLeftTitle:(NSString *)leftTitle{
    [self.leftLabel configmentfont:[UIFont boldSystemFontOfSize:13] textColor:[UIColor blackColor] backColor:[UIColor clearColor] textAligement:0 cornerRadius:0 text:leftTitle];
}
- (void)setRightImage:(UIImage *)rightImage{
    self.arrowImage.image = rightImage;
}

@end
