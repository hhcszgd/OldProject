//
//  ReusableViewHeader.m
//  b2c
//
//  Created by 0 on 16/4/6.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "ReusableViewHeader.h"

@interface ReusableViewHeader()
@property (nonatomic, strong) UILabel *titleLabel;
@end
@implementation ReusableViewHeader
- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(0);
            make.left.equalTo(self.mas_left).offset(10);
            make.bottom.equalTo(self.mas_bottom).offset(0);
            make.right.equalTo(self.mas_right).offset(0);
        }];
    }
    return self;
}
- (void)setTitle:(NSString *)title{
    [self.titleLabel configmentfont:[UIFont boldSystemFontOfSize:15] textColor:[UIColor blackColor] backColor:[UIColor whiteColor] textAligement:0 cornerRadius:0 text:title];
}
@end
