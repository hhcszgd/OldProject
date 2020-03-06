//
//  HFGuessYouLikeCell.m
//  b2c
//
//  Created by 0 on 16/5/2.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HFGuessYouLikeCell.h"

@interface HFGuessYouLikeCell()
@property (nonatomic, strong) UIImageView *img;
@property (nonatomic, strong) UILabel *full_name;
@property (nonatomic, strong) UILabel *price;
@property (nonatomic, strong) UILabel *count;
@end
@implementation HFGuessYouLikeCell

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
- (UILabel *)price{
    if (_price == nil) {
        _price = [[UILabel alloc] init];
        [self.contentView addSubview:_price];
        [_price configmentfont:[UIFont systemFontOfSize:10] textColor:[UIColor redColor] backColor:[UIColor whiteColor] textAligement:0 cornerRadius:0 text:@""];
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
        [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.contentView);
            make.height.equalTo(self.img.mas_width);
        }];
        [self.full_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView);
            make.top.equalTo(self.img.mas_bottom).offset(0);
            
        }];
        [self.price mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(10);
            make.top.equalTo(self.full_name.mas_bottom).offset(0);
        }];
        [self.count mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).offset(0);
            make.top.equalTo(self.full_name.mas_bottom).offset(0);
        }];
    }
    return self;
}

- (void)setCustomModel:(CustomCollectionModel *)customModel{
    if ([customModel.img isEqualToString:@"xxxxxx"] || (customModel.img.length == 0)) {
        self.img.image = [UIImage imageNamed:@"zhekouqu"];
    }else{
        NSURL *url = ImageUrlWithString(customModel.img);
        [self.img sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"me"]];
    }
    self.price.text = customModel.price;
    
    self.full_name.text = customModel.full_name;
    
}

@end
