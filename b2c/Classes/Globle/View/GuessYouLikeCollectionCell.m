//
//  GuessYouLikeCollectionCell.m
//  b2c
//
//  Created by 0 on 16/5/3.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "GuessYouLikeCollectionCell.h"

@interface GuessYouLikeCollectionCell()


@end
@implementation GuessYouLikeCollectionCell




- (UIImageView *)img{
    if (_img == nil) {
        _img = [[UIImageView alloc] init];
        [self.contentView addSubview:_img];
    }
    return _img;
}
- (UILabel *)title{
    if (_title == nil) {
        _title = [[UILabel alloc] init];
        [self.contentView addSubview:_title];
        [_title configmentfont:[UIFont systemFontOfSize:12 * SCALE] textColor:[UIColor colorWithHexString:@"333333"] backColor:[UIColor whiteColor] textAligement:0 cornerRadius:0 text:@""];
        [_title sizeToFit];
        [_title setNumberOfLines:2];
        
    }
    return _title;
}
- (UILabel *)price{
    if (_price == nil) {
        _price = [[UILabel alloc] init];
        [self.contentView addSubview:_price];
        [_price configmentfont:[UIFont systemFontOfSize:13 * SCALE] textColor:THEMECOLOR backColor:[UIColor whiteColor] textAligement:0 cornerRadius:0 text:@""];
        [_price sizeToFit];
    }
    return _price;
}
- (UILabel *)count{
    if (_count == nil) {
        _count = [[UILabel alloc] init];
        [self.contentView addSubview:_count];
        [_count configmentfont:[UIFont systemFontOfSize:11 * SCALE] textColor:[UIColor colorWithHexString:@"999999"] backColor:[UIColor whiteColor] textAligement:0 cornerRadius:0 text:@""];
        [_count sizeToFit];
    }
    return _count;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor =[UIColor whiteColor];
        [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.equalTo(self.contentView.mas_top).offset(0);
            make.left.equalTo(self.contentView.mas_left).offset(0);
            make.right.equalTo(self.contentView.mas_right).offset(0);
            make.height.equalTo(self.img.mas_width);
        }];
        CGSize priceSize = [@"我" stringSizeWithFont:12 *SCALE];
        [self.price mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
            make.left.equalTo(self.contentView.mas_left).offset(8);
            make.height.equalTo(@(priceSize.height));
        }];
        [self.count mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
            make.right.equalTo(self.contentView.mas_right).offset(-8);
            
        }];
        [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(8);
            make.right.equalTo(self.contentView.mas_right).offset(-8);
            make.top.equalTo(self.img.mas_bottom).offset(5);
            
        }];
        
    }
    return self;
}


- (void)setCustomModel:(CustomCollectionModel *)customModel{
    
    NSURL *url = ImageUrlWithString(customModel.img);
    [self.img sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"accountBiiMap"]options:SDWebImageCacheMemoryOnly ];
    self.title.text = customModel.short_name;
    self.price.text = [NSString stringWithFormat:@"￥%@",dealPrice(customModel.price)];
    self.count.text =[NSString stringWithFormat:@"月销量%@",customModel.sales_month];
    
}

@end
