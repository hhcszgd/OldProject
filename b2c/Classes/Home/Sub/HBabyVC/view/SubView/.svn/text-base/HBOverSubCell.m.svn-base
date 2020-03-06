//
//  HBOverSubCell.m
//  b2c
//
//  Created by 0 on 16/5/3.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HBOverSubCell.h"
@interface HBOverSubCell()
@property (nonatomic, strong) UIImageView *img;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *price;
@property (nonatomic, strong) UILabel *count;

@end
@implementation HBOverSubCell




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
        [_title configmentfont:[UIFont systemFontOfSize:11 * SCALE] textColor:[UIColor colorWithHexString:@"333333"] backColor:[UIColor whiteColor] textAligement:0 cornerRadius:0 text:@""];
        [_title setNumberOfLines:2];
        [_title sizeToFit];
    }
    return _title;
}
- (UILabel *)price{
    if (_price == nil) {
        _price = [[UILabel alloc] init];
        [self.contentView addSubview:_price];
        [_price configmentfont:[UIFont systemFontOfSize:11 * SCALE] textColor:[UIColor colorWithHexString:@"ff3a30"] backColor:[UIColor whiteColor] textAligement:0 cornerRadius:0 text:@""];
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
            make.height.equalTo(@(94 * SCALE));
        }];
        [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(10);
            make.right.equalTo(self.contentView.mas_right).offset(-10);
            make.top.equalTo(self.img.mas_bottom).offset(10);
        }];
        [self.price mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-3);
            make.left.equalTo(self.contentView.mas_left).offset(10);
            make.right.equalTo(self.contentView.mas_right).offset(-10);
        }];
        self.contentView.backgroundColor =[UIColor whiteColor];
    }
    return self;
}


- (void)setCustomModel:(CustomCollectionModel *)customModel{
   
    NSURL *url = ImageUrlWithString(customModel.img);
    [self.img sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"accountBiiMap"] options:SDWebImageCacheMemoryOnly];
    
    NSString *title = [NSString stringWithFormat:@"[热销]%@",customModel.short_name];
    NSMutableAttributedString *full_name = [[NSMutableAttributedString alloc] initWithString:title];
    [full_name addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:11 * SCALE],NSFontAttributeName,[UIColor colorWithHexString:@"ff3a30"],NSForegroundColorAttributeName, nil] range:NSMakeRange(0, 4)];
    [full_name addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:11 * SCALE],NSFontAttributeName,[UIColor colorWithHexString:@"333333"],NSForegroundColorAttributeName, nil] range:NSMakeRange(4, title.length -4)];
    
    self.title.attributedText = full_name;
    self.price.text = [NSString stringWithFormat:@"￥%@",dealPrice(customModel.price)];
    
}
@end
