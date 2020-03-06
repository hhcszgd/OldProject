//
//  ShopColDetCollectionCell.m
//  TTmall
//
//  Created by 0 on 16/3/21.
//  Copyright © 2016年 Footway tech. All rights reserved.
//

#import "ShopColDetCollectionCell.h"

@interface ShopColDetCollectionCell()
@property (nonatomic, strong) UIImageView *image;
@property (nonatomic, strong) UILabel *price;
@property (nonatomic, strong) UILabel *more;
@end
@implementation ShopColDetCollectionCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self layout];
    }
    return self;
}
- (UILabel *)price{
    if (_price == nil) {
        _price = [[UILabel alloc] init];
        [self.contentView addSubview:_price];
        [_price configmentfont:[UIFont systemFontOfSize:12] textColor:[UIColor redColor] backColor:[UIColor whiteColor] textAligement:1 cornerRadius:0 text:@""];
    }
    return _price;
}
- (UIImageView *)image{
    if (_image == nil) {
        _image = [UIImageView new];
        [self.contentView addSubview:_image];
    }
    return _image;
}
- (UILabel *)more{
    if (_more == nil) {
        _more = [UILabel new];
        [self.contentView addSubview:_more];
    }
    return _more;
}


- (void)layout{
    [self.image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.equalTo(self.contentView);
        make.height.equalTo(_image.mas_width);
    }];
    [self.price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.image.mas_bottom).offset(0);
        make.right.bottom.left.equalTo(self.contentView);
    }];
    
}
- (void)setModel:(SCCellSubModel*)model{
    _model = model;
    NSURL *imageUrl = ImageUrlWithString(model.img);
    [self.image sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"accountBiiMap"]options:SDWebImageCacheMemoryOnly];
    
    self.price.text = model.price;
    
    
    
}


@end
