//
//  HSuperGoodShopCommentCell.m
//  b2c
//
//  Created by 0 on 16/5/5.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HSuperGoodShopCommentCell.h"
@interface HSuperGoodShopCommentCell()
@property (nonatomic, strong) UIImageView *heightImage;
@property (nonatomic, strong) UILabel *full_name;


@end
@implementation HSuperGoodShopCommentCell
- (UIImageView *)heightImage{
    if (_heightImage == nil) {
        _heightImage = [[UIImageView alloc] init];
        [self.contentView addSubview:_heightImage];
    }
    return _heightImage;
}
- (UILabel *)full_name{
    if (_full_name == nil) {
        _full_name = [[UILabel alloc] init];
        
        [self.contentView addSubview:_full_name];
        [_full_name configmentfont:[UIFont systemFontOfSize:11 * SCALE] textColor:[UIColor colorWithHexString:@"333333"] backColor:[UIColor clearColor] textAligement:1 cornerRadius:0 text:@""];
        [_full_name sizeToFit];
    }
    return _full_name;
}



- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self configmentUI];
    }
    return self;
}
- (void)configmentUI{
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self.heightImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(0);
        make.left.equalTo(self.contentView.mas_left).offset(0);
        make.right.equalTo(self.contentView.mas_right).offset(0);
         make.height.equalTo(self.heightImage.mas_width);
    }];
    [self.full_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.heightImage.mas_bottom).offset(8);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
    }];
}
- (void)setCustomModel:(CustomCollectionModel *)customModel{
    NSURL *url = ImageUrlWithString(customModel.img);
    [self.heightImage sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"accountBiiMap"]options:SDWebImageCacheMemoryOnly];
    self.full_name.text = customModel.short_name;
    
}

@end
