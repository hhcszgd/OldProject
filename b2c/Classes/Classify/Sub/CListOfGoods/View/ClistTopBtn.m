//
//  ClistTopBtn.m
//  b2c
//
//  Created by 0 on 16/4/27.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//


#import "ClistTopBtn.h"
@interface ClistTopBtn()
@property (nonatomic, assign) NSInteger font;
@property (nonatomic, copy) NSString *str;
@property (nonatomic, assign) CGSize size;


@end
@implementation ClistTopBtn

- (instancetype)initWithFrame:(CGRect)frame withFont:(CGFloat)font WithStr:(NSString *)titleStr{
    self = [super initWithFrame:frame];
    if (self) {
        _str = titleStr;
        _font = font;
        CGSize textSize = [titleStr sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:font],NSFontAttributeName, nil]];
        _size = textSize;
        
    }
    return self;
}


- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    return CGRectMake((contentRect.size.width - _size.width)/2.0 + _size.width + 5, (contentRect.size.height - 11)/2.0, 6, 11);
}
- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    return CGRectMake((contentRect.size.width - _size.width)/2.0, (contentRect.size.height - _size.height)/2.0, _size.width, _size.height);
}
@end
