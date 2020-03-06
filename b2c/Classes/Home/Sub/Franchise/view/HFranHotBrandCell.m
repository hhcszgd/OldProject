//
//  HFranHotBrandCell.m
//  b2c
//
//  Created by 0 on 16/4/7.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HFranHotBrandCell.h"

@interface HFranHotBrandCell()
@property (nonatomic, strong) UIImageView *brandImage;

@end
@implementation HFranHotBrandCell
- (UIImageView *)brandImage{
    if (_brandImage == nil) {
        _brandImage = [[UIImageView alloc] init];
        [self.contentView addSubview:_brandImage];
    }
    return _brandImage;
}





- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self configmentUI];
    }
    return self;
}
- (void)configmentUI{
    self.brandImage.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
   
}

- (void)setCustomModel:(CustomCollectionModel *)customModel{
    NSURL *url = ImageUrlWithString(customModel.img);
    [self.brandImage sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"accountBiiMap"]options:SDWebImageCacheMemoryOnly];
    
}

@end
