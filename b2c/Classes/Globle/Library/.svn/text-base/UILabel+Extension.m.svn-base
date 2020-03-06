//
//  UILabel+Extension.m
//  b2c
//
//  Created by 0 on 16/3/28.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "UILabel+Extension.h"

@implementation UILabel (Extension)

- (void)configmentfont:(UIFont *)textFont textColor:(UIColor *)textColor backColor:(UIColor *)backColor textAligement:(NSTextAlignment)textAlignment cornerRadius:(CGFloat)cornerRadius text:(NSString *)str{
    self.font = textFont;
    self.textColor = textColor;
    self.backgroundColor = backColor;
    self.textAlignment = textAlignment;
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = cornerRadius;
    self.text = str;
}



- (CGSize)gotSizeWithLabel{
    CGSize size = [self.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:NSFontAttributeName,self.font, nil]];
    return size;
}


@end
