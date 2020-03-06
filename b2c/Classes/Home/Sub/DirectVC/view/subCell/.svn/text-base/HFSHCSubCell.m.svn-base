//
//  HFSHCSubCell.m
//  b2c
//
//  Created by 0 on 16/5/2.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HFSHCSubCell.h"
@interface HFSHCSubCell()
@property (nonatomic, strong) UIImageView *img;
@property (nonatomic, strong) UILabel *full_name;
@end
@implementation HFSHCSubCell

- (UIImageView *)img{
    if (_img == nil) {
        _img = [[UIImageView alloc] init];
        [self.contentView addSubview:_img];
    }
    return _img;
}
- (UILabel *)full_name{
    if (_full_name == nil) {
        _full_name = [[UILabel alloc] init];
        [self.contentView addSubview:_full_name];
        [_full_name configmentfont:[UIFont systemFontOfSize:11] textColor:[UIColor blackColor] backColor:[UIColor whiteColor] textAligement:1 cornerRadius:0 text:@""];
        [_full_name setNumberOfLines:2];
        [_full_name sizeToFit];
    }
    return _full_name;
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.contentView);
            make.height.equalTo(self.img.mas_width);
        }];
        [self.full_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView);
            make.top.equalTo(self.img.mas_bottom).offset(0);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
        }];
    }
    return self;
}

- (void)setCustomModel:(CustomCollectionModel *)customModel{
    if ([customModel.img isEqualToString:@"xxxxxx"] || (customModel.img.length == 0)) {
        self.img.image = [UIImage imageNamed:@"zhekouqu"];
    }else{
        NSURL *url = ImageUrlWithString(customModel.img);
        [self.img sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"accountBiiMap"]options:SDWebImageCacheMemoryOnly];
    }
    LOG(@"%@,%d,%@",[self class], __LINE__,customModel.full_name)
    self.full_name.text = customModel.full_name;
    
}


@end
