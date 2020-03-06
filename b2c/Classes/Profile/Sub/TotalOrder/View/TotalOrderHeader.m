//
//  TotalOrderHeader.m
//  b2c
//
//  Created by 0 on 16/4/9.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//


#import "TotalOrderHeader.h"
@interface TotalOrderHeader()
/**图标*/
@property (nonatomic, strong) UIImageView *logoImage;
/**店铺名称*/
@property (nonatomic, strong) UILabel *storeNameLabel;
/**指示箭头*/
@property (nonatomic, strong) UIImageView *arrowImage;
/**卖家，买家的状态*/
@property (nonatomic, strong) UILabel *stateLabel;
@end
@implementation TotalOrderHeader
- (UIImageView *)logoImage{
    if (_logoImage == nil) {
        _logoImage = [[UIImageView alloc] init];
        [self addSubview:_logoImage];
    }
    return _logoImage;
}
- (UILabel *)storeNameLabel{
    if (_storeNameLabel == nil) {
        _storeNameLabel = [[UILabel alloc] init];
        [self addSubview:_storeNameLabel];
    }
    return _storeNameLabel;
}
- (UIImageView *)arrowImage{
    if (_arrowImage == nil) {
        _arrowImage = [[UIImageView alloc] init];
        [self addSubview:_arrowImage];
    }
    return _arrowImage;
}
- (UILabel *)stateLabel{
    if (_stateLabel == nil) {
        _stateLabel = [[UILabel alloc] init];
        [self addSubview:_stateLabel];
    }
    return _stateLabel;
}




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
        
        
#warning 假数据
        self.logoImage.image = [UIImage imageNamed:@"tm_shopcart_couponicon"];
        [self.storeNameLabel configmentfont:[UIFont boldSystemFontOfSize:14 * SCALE] textColor:[UIColor blackColor] backColor:[UIColor whiteColor] textAligement:0 cornerRadius:0 text:@"adidas官方旗舰店"];
        [self.stateLabel configmentfont:[UIFont systemFontOfSize:14 * SCALE] textColor:[UIColor redColor] backColor:[UIColor whiteColor] textAligement:0 cornerRadius:0 text:@"买家等待付款"];
        
    }
    return self;
}

@end
