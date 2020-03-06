//
//  HGBSeeAndSeeItem.m
//  b2c
//
//  Created by 0 on 16/6/29.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HGBSeeAndSeeItem.h"

@implementation HGBSeeAndSeeItem
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}


- (void)setSubModel:(HGoodsBottomSubModel *)subModel{
    NSURL *url = ImageUrlWithString(subModel.img);
    [self.img sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"accountBiiMap"] options:SDWebImageCacheMemoryOnly];
    self.title.text = subModel.short_name;
    self.price.text = [NSString stringWithFormat:@"￥%@",dealPrice(subModel.price)];
    self.count.text = [NSString stringWithFormat:@"月销量%@",subModel.sales_month];
}

@end
