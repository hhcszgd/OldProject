//
//  ShopCar.m
//  b2c
//
//  Created by 0 on 16/4/29.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "ShopCar.h"
@interface ShopCar()


@end


@implementation ShopCar
- (UILabel *)numLabel{
    if (_numLabel == nil) {
        _numLabel = [[UILabel alloc] init];
        [self addSubview:_numLabel];
        [_numLabel configmentfont:[UIFont systemFontOfSize:10] textColor:[UIColor colorWithHexString:@"ffffff"] backColor:[UIColor clearColor] textAligement:1 cornerRadius:14/2.0 text:@""];
    }
    return _numLabel;
}

- (instancetype)initWithFrame:(CGRect)frame withNum:(NSString *)shopNub{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *shopImage = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width - 21)/2.0, (frame.size.height-18)/2.0, 20, 17)];
        shopImage.image = [UIImage imageNamed:@"icon_shoppingcart_small"];
        [self addSubview:shopImage];
        self.numLabel.center = CGPointMake(shopImage.frame.origin.x + shopImage.frame.size.width, shopImage.frame.origin.y);
        self.numLabel.bounds = CGRectMake(0, 0, 14, 14);
        self.numLabel.text = shopNub;
        if ([self.numLabel.text isEqualToString:@"0"]) {
            self.numLabel.backgroundColor = [UIColor clearColor];
            self.numLabel.textColor = [UIColor clearColor];
        }
        self.numBackColor = THEMECOLOR;
    }
    return self;
}


- (void)editShopCarNumber:(NSString *)numberStr{
    self.shopcarNumber = numberStr;
    NSInteger number = [numberStr integerValue];
    if (number == 0) {
        self.numLabel.backgroundColor = [UIColor clearColor];
        self.numLabel.text = @"";
    }else if(number > 0 && number < 10){
        self.numLabel.backgroundColor = self.numBackColor;
        self.numLabel.textColor = [UIColor whiteColor];
        self.numLabel.text = [NSString stringWithFormat:@"%ld",number];
    }else{
        self.numLabel.backgroundColor = self.numBackColor;
        self.numLabel.text = @"9+";
        self.numLabel.textColor = [UIColor whiteColor];
    }
}
- (void)setNumBackColor:(UIColor *)numBackColor{
    _numBackColor = numBackColor;
    NSInteger number = [self.shopcarNumber integerValue];
    if (number == 0) {
        self.numLabel.backgroundColor = [UIColor clearColor];
        self.numLabel.text = @"";
    }else if(number > 0 && number < 10){
        self.numLabel.backgroundColor = numBackColor;
        self.numLabel.textColor = [UIColor whiteColor];
        self.numLabel.text = [NSString stringWithFormat:@"%ld",number];
    }else{
        self.numLabel.backgroundColor = numBackColor;
        self.numLabel.text = @"9+";
        self.numLabel.textColor = [UIColor whiteColor];
    }
}


@end
