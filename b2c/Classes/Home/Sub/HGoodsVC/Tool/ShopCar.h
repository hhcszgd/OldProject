//
//  ShopCar.h
//  b2c
//
//  Created by 0 on 16/4/29.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "ActionBaseView.h"

@interface ShopCar : ActionBaseView
- (instancetype)initWithFrame:(CGRect)frame withNum:(NSString *)shopNub;
/**购物车中的产品数量*/
@property (nonatomic, strong) UILabel *numLabel;
- (void)editShopCarNumber:(NSString *)numberStr;
@property (nonatomic, copy) NSString *shopcarNumber;
@property (nonatomic, strong) UIColor *numBackColor;
@end