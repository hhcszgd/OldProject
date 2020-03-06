//
//  HCellBaseComposeView.m
//  b2c
//
//  Created by wangyuanfei on 16/4/14.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HCellBaseComposeView.h"

@implementation HCellBaseComposeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.privateImage = [[UIImageView alloc] init];
        [self addSubview:self.privateImage];
        [self.privateImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.right.equalTo(self);
        }];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
