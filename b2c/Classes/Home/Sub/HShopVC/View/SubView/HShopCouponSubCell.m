//
//  HShopCouponSubCell.m
//  b2c
//
//  Created by 0 on 16/5/6.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//


#import "HShopCouponSubCell.h"
@interface HShopCouponSubCell()
@property (nonatomic, strong) UIImageView *backImage;
@property (nonatomic, strong) UILabel *discount_price;

@property (nonatomic, strong) UILabel *endTime;
@property (nonatomic, strong) UILabel  *cTitleLabel;


@end



@implementation HShopCouponSubCell
- (UILabel *)cTitleLabel{
    if (_cTitleLabel == nil) {
        _cTitleLabel =[[UILabel alloc] init];
        [_cTitleLabel configmentfont:[UIFont systemFontOfSize:12] textColor:[UIColor whiteColor] backColor:[UIColor clearColor] textAligement:1 cornerRadius:0 text:@""];
        [_cTitleLabel sizeToFit];
        [self.contentView addSubview:_cTitleLabel];
    }
    return _cTitleLabel;
}
- (UIImageView *)backImage{
    if (_backImage == nil) {
        _backImage = [[UIImageView alloc] init];
        [self.contentView addSubview:_backImage];
    }
    return _backImage;
}
- (UILabel *)discount_price{
    if (_discount_price == nil) {
        _discount_price = [[UILabel alloc] init];
        [self.contentView addSubview:_discount_price];
        [_discount_price configmentfont:[UIFont systemFontOfSize:18 ] textColor:[UIColor colorWithHexString:@"64acfd"] backColor:[UIColor clearColor] textAligement:1 cornerRadius:0 text:@""];
        [_discount_price sizeToFit];
    }
    return _discount_price;
}
- (UILabel *)endTime{
    if (_endTime == nil) {
        _endTime = [[UILabel alloc] init];
        [self.contentView addSubview:_endTime];
        [_endTime configmentfont:[UIFont systemFontOfSize:12  ] textColor:[UIColor colorWithHexString:@"64acfd"] backColor:[UIColor clearColor] textAligement:1 cornerRadius:0 text:@""];
        [_endTime sizeToFit];
    }
    return _endTime;
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backImage.frame = self.contentView.bounds;
        [self.cTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(7);
            make.left.equalTo(self.contentView.mas_left).offset(6);
            make.right.equalTo(self.contentView.mas_right).offset(-6);
            
        }];
        [self.discount_price mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.cTitleLabel.mas_bottom).offset(3);
            make.left.equalTo(self.contentView.mas_left).offset( 8);
            make.right.equalTo(self.contentView.mas_right).offset(-8);
        }];
        [self.endTime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(8);
            make.right.equalTo(self.contentView.mas_right).offset(-8);
            make.top.equalTo(self.discount_price.mas_bottom).offset(3);
        }];
        
    }
    return self;
}
-(void)setSubModel:(HStoreSubModel *)subModel{
    NSInteger p = [subModel.discount_price integerValue];
    NSInteger pp = p/100;
    NSString *price = [NSString stringWithFormat:@"%ld元",pp];
    NSInteger man = [subModel.full_price integerValue];
    NSInteger manman = man/100;
    NSString *manStr = [NSString stringWithFormat:@"%ld",manman];
//    NSMutableAttributedString *priceStr = [[NSMutableAttributedString alloc] initWithString:price];
//    [priceStr addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:20 * SCALE],NSFontAttributeName, nil] range:NSMakeRange(0, priceStr.length)];
//    [priceStr addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:30 * SCALE],NSFontAttributeName, nil] range:NSMakeRange(0, priceStr.length - 1)];
    self.discount_price.text = price;
//    NSRange range = [subModel.end_time rangeOfString:@" "];
    self.endTime.text = [NSString stringWithFormat:@"满%@元可用",manStr];
    if ([subModel.type  isEqualToString:@"2"]) {
        self.cTitleLabel.text = @"指定商品";
        self.cTitleLabel.textColor = [UIColor colorWithHexString:@"64acfd"];
        self.discount_price.textColor =[UIColor colorWithHexString:@"64acfd"];
        self.endTime.textColor =[UIColor colorWithHexString:@"64acfd"];
        self.backImage.image =[UIImage imageNamed:@"bg_coupon_shop_specially"];
    }
    if ([subModel.type isEqualToString:@"1"]) {
        self.cTitleLabel.text = @"全部商品";
        self.cTitleLabel.textColor = [UIColor colorWithHexString:@"ff5858"];
        self.discount_price.textColor =[UIColor colorWithHexString:@"ff5858"];
        self.endTime.textColor =[UIColor colorWithHexString:@"ff5858"];
        self.backImage.image =[UIImage imageNamed:@"bg_coupon_shop_all"];
    }
    
    
//     [self.backImage sd_setImageWithURL:[NSURL URLWithString:subModel.img]];

}


@end
