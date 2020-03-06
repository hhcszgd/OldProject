//
//  HShopSearchField.m
//  b2c
//
//  Created by 0 on 16/5/17.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HShopSearchField.h"

@implementation HShopSearchField



- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}


- (void)configmentAttributePlaceholderFont:(UIFont *)font color:(UIColor *)color placeholder:(NSString *)placeholder{
    
    NSMutableParagraphStyle *style = [self.defaultTextAttributes[NSParagraphStyleAttributeName] mutableCopy];
    style.minimumLineHeight = self.font.lineHeight -(self.font.lineHeight - font.lineHeight)/2.0;
    NSMutableAttributedString *attrubuteString = [[NSMutableAttributedString alloc] initWithString:placeholder];
    [attrubuteString addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName,color,NSForegroundColorAttributeName,style,NSParagraphStyleAttributeName, nil] range:NSMakeRange(0, placeholder.length)];
    self.attributedPlaceholder = attrubuteString;
}
- (void)setSCornerRadius:(CGFloat)sCornerRadius{
    self.layer.cornerRadius = sCornerRadius;
    self.layer.masksToBounds = YES;
}
- (void)setSborderColor:(UIColor *)sborderColor{
    self.layer.borderColor = [sborderColor CGColor];
}
- (void)setSborderWidth:(CGFloat)sborderWidth{
    self.layer.borderWidth = sborderWidth;
}
- (void)setSLeftView:(UIView *)sLeftView{
    
}



@end
