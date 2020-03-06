//
//  PendingPayHeader.m
//  b2c
//
//  Created by 0 on 16/4/12.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "PendingPayHeader.h"

@implementation PendingPayHeader

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self.logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self.mas_left).offset(10);
            make.width.equalTo(@(20));
            make.height.equalTo(@(20));
        }];
        
        [self.storeNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self.logoImage.mas_right).offset(5);
            
        }];
        [self.storeNameLabel sizeToFit];
        
        [self.arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self.storeNameLabel.mas_right).offset(5);
            make.width.equalTo(@(10));
            make.height.equalTo(@(20));
        }];
        self.arrowImage.image = [UIImage imageNamed:@"sen"];
        [self.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.equalTo(self.mas_right).offset(-10);
        }];
        [self.stateLabel sizeToFit];
        
        
#pragma mark 假数据
        self.logoImage.image = [UIImage imageNamed:@"tm_shopcart_couponicon"];
        [self.storeNameLabel configmentfont:[UIFont boldSystemFontOfSize:14 * SCALE] textColor:[UIColor blackColor] backColor:[UIColor whiteColor] textAligement:0 cornerRadius:0 text:@"adidas官方旗舰店"];
        [self.stateLabel configmentfont:[UIFont systemFontOfSize:14 * SCALE] textColor:[UIColor redColor] backColor:[UIColor whiteColor] textAligement:0 cornerRadius:0 text:@"买家等待付款"];
    }
    return self;
}


@end
