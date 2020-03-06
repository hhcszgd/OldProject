//
//  HFShCGoodsCell.m
//  b2c
//
//  Created by 0 on 16/5/2.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HFSOverflowSubCell.h"
@interface HFSOverflowSubCell()
@property (nonatomic, strong) UIImageView *img;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *price;
@property (nonatomic, strong) UILabel *count;

@end
@implementation HFSOverflowSubCell




- (UIImageView *)img{
    if (_img == nil) {
        _img = [[UIImageView alloc] init];
        _img.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_img];
    }
    return _img;
}
- (UILabel *)title{
    if (_title == nil) {
        _title = [[UILabel alloc] init];
        [self.contentView addSubview:_title];
        [_title configmentfont:[UIFont systemFontOfSize:11 * zkqScale] textColor:[UIColor colorWithHexString:@"333333"] backColor:[UIColor clearColor] textAligement:0 cornerRadius:0 text:@""];
        [_title setNumberOfLines:2];
        [_title sizeToFit];
    }
    return _title;
}
- (UILabel *)price{
    if (_price == nil) {
        _price = [[UILabel alloc] init];
        [self.contentView addSubview:_price];
        [_price configmentfont:[UIFont systemFontOfSize:11 * zkqScale] textColor:[UIColor colorWithHexString:@"9445ff"] backColor:[UIColor clearColor] textAligement:0 cornerRadius:0 text:@""];
        [_price sizeToFit];
    }
    return _price;
}
- (UILabel *)count{
    if (_count == nil) {
        _count = [[UILabel alloc] init];
        [self.contentView addSubview:_count];
        [_count configmentfont:[UIFont systemFontOfSize:10] textColor:[UIColor whiteColor] backColor:[UIColor whiteColor] textAligement:0 cornerRadius:0 text:@""];
        [_count sizeToFit];
    }
    return _count;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor colorWithHexString:@"e7e7e7"];
        [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.contentView);
            make.height.equalTo(self.img.mas_width);
        }];
        [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.equalTo(self.contentView.mas_left).offset(6);
            make.right.equalTo(self.contentView.mas_right).offset(-6);
            make.top.equalTo(self.img.mas_bottom).offset(3);
        }];
        [self.price mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-6);
            make.left.equalTo(self.contentView.mas_left).offset(6);
            make.right.equalTo(self.contentView.mas_right).offset(-6);
        }];
        self.layer.cornerRadius = 6;
        self.layer.masksToBounds = YES;
    }
    return self;
}


- (void)setCustomModel:(CustomCollectionModel *)customModel{
    
    NSURL *url = ImageUrlWithString(customModel.img);
    [self.img sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"accountBiiMap"]options:SDWebImageCacheMemoryOnly];
    self.title.text = customModel.short_name;
    self.price.text = [NSString stringWithFormat:@"￥%@",dealPrice(customModel.price)];
    
}




@end
