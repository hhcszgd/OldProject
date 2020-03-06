//
//  ClistChngeUIBtn.m
//  b2c
//
//  Created by 0 on 16/4/27.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//


#import "ClistChngeUIBtn.h"
@interface ClistChngeUIBtn()
@property (nonatomic, assign) CGSize imageSize;
@end
@implementation ClistChngeUIBtn
- (instancetype)initWithFrame:(CGRect)frame withImageSize:(CGSize)imageSize{
    self = [super initWithFrame:frame];
    if (self) {
        _imageSize = imageSize;
    }
    return self;
}


- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat x = (contentRect.size.width - _imageSize.width)/2.0;
    CGFloat y = (contentRect.size.height - _imageSize.height)/2.0;
    return CGRectMake(x, y, _imageSize.width, _imageSize.height);
}

@end
