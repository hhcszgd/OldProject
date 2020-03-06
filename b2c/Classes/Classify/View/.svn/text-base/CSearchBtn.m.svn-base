//
//  CSearchBtn.m
//  b2c
//
//  Created by 0 on 16/4/22.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "CSearchBtn.h"
@interface CSearchBtn()
/**放大镜*/
@property (nonatomic, strong) UIImageView *magnifierImage;


@end
@implementation CSearchBtn

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //设置弧度
        self.layer.cornerRadius = 5 * zkqScale;
        self.layer.borderColor = [[UIColor colorWithHexString:@"cccccc"] CGColor];
        self.layer.borderWidth = 0.5;
        //背景颜色
        self.backgroundColor = [UIColor whiteColor];
        [self.magnifierImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self).offset(7);
            make.height.equalTo(@(15 * zkqScale));
             make.width.equalTo(self.magnifierImage.mas_height);
        }];
        self.magnifierImage.image = [UIImage imageNamed:@"icon_search"];
        //布局文字
        [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.magnifierImage.mas_right).offset(5);
            make.top.bottom.right.equalTo(self);
        }];
        [self.textLabel configmentfont:[UIFont systemFontOfSize:14 * zkqScale] textColor:[UIColor colorWithHexString:@"999999"] backColor:[UIColor clearColor] textAligement:0 cornerRadius:0 text:@""];
        
    }
    return self;
}
- (UIImageView *)magnifierImage{
    if (_magnifierImage == nil) {
        _magnifierImage = [[UIImageView alloc] init];
        [self addSubview:_magnifierImage];
    }
    return _magnifierImage;
}
- (UILabel *)textLabel{
    if (_textLabel == nil) {
        _textLabel = [[UILabel alloc] init];
        [self addSubview:_textLabel];
    }
    return _textLabel;
}
- (void)setTitleStr:(NSString *)titleStr{
    self.textLabel.text = titleStr;
    _titleStr = titleStr;
}




@end
