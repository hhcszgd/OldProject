//
//  ShopCollectionRightButton.m
//  TTmall
//
//  Created by 0 on 16/3/21.
//  Copyright © 2016年 Footway tech. All rights reserved.
//

#import "ShopCollectionRightButton.h"

@implementation ShopCollectionRightButton

- (CGRect)titleRectForContentRect:(CGRect)contentRect{

    return CGRectMake(0, 0, contentRect.size.width/2.0, contentRect.size.height);
}
- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat margin = contentRect.size.height/10.0;
    return CGRectMake(contentRect.size.width/2.0 +1.0 * margin, margin *4.0, 2.0 *margin, 2.0 *margin);
}
@end
