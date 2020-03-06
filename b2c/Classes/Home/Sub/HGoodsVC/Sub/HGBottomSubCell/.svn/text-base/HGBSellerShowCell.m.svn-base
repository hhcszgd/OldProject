//
//  HGBSellerShowCell.m
//  b2c
//
//  Created by 0 on 16/5/14.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HGBSellerShowCell.h"
@interface HGBSellerShowCell()
@property (nonatomic, strong) UIImageView *mainImageView;
@end
@implementation HGBSellerShowCell
- (UIImageView *)mainImageView{
    if (_mainImageView == nil) {
        _mainImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_mainImageView];
    }
    return _mainImageView;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.mainImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(self.contentView);
            
            
        }];
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.bottom.equalTo(self.mainImageView.mas_bottom).offset(0);
        }];
    }
    return self;
}

- (void)setGoodDetailsubModel:(HGoodsBottomSubModel *)goodDetailsubModel{
    NSURL *url = ImageUrlWithString(goodDetailsubModel.img);
    [self.mainImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"accountBiiMap"] options:SDWebImageCacheMemoryOnly];
}
@end
