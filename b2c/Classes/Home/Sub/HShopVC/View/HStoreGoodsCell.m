//
//  HStoreGoodsCell.m
//  b2c
//
//  Created by 0 on 16/5/6.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HStoreGoodsCell.h"

@implementation HStoreGoodsCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
-(void)setSubModel:(HStoreSubModel *)subModel{
    
    NSURL *url = ImageUrlWithString(subModel.img);
    [self.img sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"accountBiiMap"] options:SDWebImageCacheMemoryOnly];
    self.title.text = subModel.short_name;
    self.price.attributedText = [subModel.price dealhomePricefirstFont:[UIFont systemFontOfSize:11] lastfont:[UIFont systemFontOfSize:11]];
    self.count.text = [NSString stringWithFormat:@"月销量%@",subModel.sales_month];
}


@end
