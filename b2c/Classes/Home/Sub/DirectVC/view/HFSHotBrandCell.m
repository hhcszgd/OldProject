//
//  HFSHotBrandCell.m
//  b2c
//
//  Created by 0 on 16/4/6.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HFSHotBrandCell.h"

@interface HFSHotBrandCell()
@property (nonatomic, strong) UIImageView *brandImage;

@end
@implementation HFSHotBrandCell
- (UIImageView *)brandImage{
    if (_brandImage == nil) {
        _brandImage = [[UIImageView alloc] init];
        _brandImage.backgroundColor = [UIColor whiteColor];
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
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 6 * SCALE;
}

- (void)setCustomModel:(CustomCollectionModel *)customModel{
    NSURL *url = ImageUrlWithString(customModel.img);
    [self.brandImage sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"accountBiiMap"] options:SDWebImageCacheMemoryOnly];
}
-(void)dealloc{
//    LOG(@"%@,%d,%@",[self class], __LINE__,@"销毁")
}
@end
