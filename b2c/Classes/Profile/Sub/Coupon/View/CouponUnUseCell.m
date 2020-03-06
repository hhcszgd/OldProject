//
//  CouponUnUseCell.m
//  b2c
//
//  Created by 0 on 16/4/21.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "CouponUnUseCell.h"
@interface CouponUnUseCell()
@property (nonatomic, strong) UIImageView *couponImage;

@end
@implementation CouponUnUseCell
- (UIImageView *)couponImage{
    if (_couponImage == nil) {
        _couponImage = [[UIImageView alloc] init];
        [self.contentView addSubview:_couponImage];
    }
    return _couponImage;
}


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self.couponImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.equalTo(self.contentView);
        }];
        self.couponImage.image = [UIImage imageNamed:@"gwxq_product_header"];
    }
    return self;
}


@end
