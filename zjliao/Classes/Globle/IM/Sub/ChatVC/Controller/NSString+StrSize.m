//
//  NSString+StrSize.m
//  b2c
//
//  Created by wangyuanfei on 3/29/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "NSString+StrSize.h"

@implementation NSString (StrSize)
- (CGSize)sizeWithFont:(UIFont *)font MaxSize:(CGSize)maxSize {
    if (!font) {
        NSLog(@"_%@_%d_%@",[self class] , __LINE__,@"font 为空");
        return CGSizeZero;
    }
    NSDictionary *attr = @{NSFontAttributeName : font};
   //ios7以后使用的方法获取字符串的rect.会把反义字符\n\r当做字符串进行处理，因此如果字符串中含反义字符那么房子啊uitextfield或者是UItextview中的时候要单独计算
    return [self boundingRectWithSize: maxSize options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:attr context:nil].size;
    
    
}
- (CGSize)stringSizeWithFont:(CGFloat )textFont{
    UIFont * font = [UIFont systemFontOfSize:textFont];
    NSDictionary *attr = @{NSFontAttributeName : font};
   return [self boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attr context:nil].size;
}
@end
