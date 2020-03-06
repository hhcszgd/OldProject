//
//  NSString+StrSize.h
//  b2c
//
//  Created by wangyuanfei on 3/29/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (StrSize)
/** 自定义计算多行(含单行)的字符串尺寸 */
- (CGSize)sizeWithFont:(UIFont *)font MaxSize:(CGSize)maxSize;
/** 自定义计算单行的字符串尺寸 */
- (CGSize)stringSizeWithFont:(CGFloat)textFont;
@end
