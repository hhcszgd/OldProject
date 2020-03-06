//
//  ClistOfGoodsBlockCell.m
//  b2c
//
//  Created by 0 on 16/4/25.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//


#import "ClistOfGoodsBlockCell.h"
@interface ClistOfGoodsBlockCell()
/**商品图片*/
@property (nonatomic, weak) UIImageView *goodImage;
/**商品介绍*/
@property (nonatomic, weak) UILabel *goodlabel;
/**商品销售量*/
@property (nonatomic, weak) UILabel *goodSVLabel;
/**商品价格*/
@property (nonatomic, weak) UILabel *goodPrice;
@end
@implementation ClistOfGoodsBlockCell
- (UILabel *)goodlabel{
    if (_goodlabel == nil) {
        UILabel *goodlabel = [[UILabel alloc] init];
        [goodlabel setNumberOfLines:2];
        [goodlabel sizeToFit];
        [goodlabel configmentfont:[UIFont systemFontOfSize:12 * SCALE] textColor:[UIColor colorWithHexString:oneLevelUnselectColor] backColor:[UIColor clearColor] textAligement:0 cornerRadius:0 text:@""];
        _goodlabel = goodlabel;
        [self.contentView addSubview:goodlabel];
        
    }
    return _goodlabel;
}
- (UIImageView *)goodImage{
    if (_goodImage == nil) {
        UIImageView *goodImage = [[UIImageView alloc] init];
        _goodImage = goodImage;
        [self.contentView addSubview:goodImage];
    }
    return _goodImage;
}
- (UILabel *)goodSVLabel{
    if (_goodSVLabel == nil) {
        UILabel *sv = [[UILabel alloc] init];
        _goodSVLabel = sv;
        [sv configmentfont:[UIFont systemFontOfSize:11 * SCALE] textColor:[UIColor colorWithHexString:threeLevelTextColor] backColor:[UIColor clearColor] textAligement:0 cornerRadius:0 text:@""];
        [sv sizeToFit];
        [sv setNumberOfLines:2];
        [self.contentView addSubview:sv];
    }
    return _goodSVLabel;
}
- (UILabel *)goodPrice{
    if (_goodPrice == nil) {
        UILabel *price = [[UILabel alloc] init];
        _goodPrice = price;
        [price configmentfont:[UIFont systemFontOfSize:13 * SCALE] textColor:[UIColor colorWithHexString:oneLevelSelectColor] backColor:[UIColor clearColor] textAligement:0 cornerRadius:0 text:@""];
        [price sizeToFit];
        [self.contentView addSubview:price];
    }
    return _goodPrice;
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self layout];
    }
    return self;
}
- (void)layout{
    //布局产品图片
    self.contentView.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
    [self.goodImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView);
        make.height.equalTo(self.goodImage.mas_width);
    }];
    //布局产品介绍
    [self.goodlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.goodImage.mas_bottom).offset(5);
        make.left.equalTo(self.contentView).offset(8);
        make.right.equalTo(self.contentView.mas_right).offset(-8);
        make.bottom.equalTo(self.goodPrice.mas_top).offset(0);
    }];
    CGSize priceSize = [self.goodPrice.text stringSizeWithFont:11 * SCALE];
    //布局价格
    [self.goodPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-9);
        make.left.equalTo(self.contentView.mas_left).offset(8);
        make.height.equalTo(@(priceSize.height));
    }];
    //布局销量
    [self.goodSVLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-8);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-9);
    }];
}
- (void)setClistModel:(ClistOfGoodsModel *)clistModel{
    
    NSURL *urlStr = ImageUrlWithString(clistModel.img);
    [self.goodImage sd_setImageWithURL:urlStr placeholderImage:[UIImage imageNamed:@"accountBiiMap"] options:SDWebImageCacheMemoryOnly];
    
    [self.goodlabel setText:clistModel.short_name];
    [self.goodSVLabel setText:[NSString stringWithFormat:@"月销%@",clistModel.sales_month]];
    [self.goodPrice setAttributedText:[clistModel.price dealhomePricefirstFont:[UIFont systemFontOfSize:11 * SCALE] lastfont:[UIFont systemFontOfSize:11 * SCALE]]];
}
- (void)setSubModel:(HStoreSubModel *)subModel{
    
    NSURL *urlStr = ImageUrlWithString(subModel.img);
    [self.goodImage sd_setImageWithURL:urlStr placeholderImage:[UIImage imageNamed:@"accountBiiMap"] options:SDWebImageCacheMemoryOnly];
    
    [self.goodlabel setText:subModel.short_name];
    [self.goodSVLabel setText:[NSString stringWithFormat:@"月销%@",subModel.sales_month]];
    [self.goodPrice setAttributedText:[subModel.price dealhomePricefirstFont:[UIFont systemFontOfSize:11 * SCALE] lastfont:[UIFont systemFontOfSize:11 * SCALE]]];
}





@end
