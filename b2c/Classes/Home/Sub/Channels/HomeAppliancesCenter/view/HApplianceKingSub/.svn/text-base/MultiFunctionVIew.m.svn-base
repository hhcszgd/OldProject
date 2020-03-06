//
//  MultiFunctionVIew.m
//  b2c
//
//  Created by 0 on 16/4/7.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "MultiFunctionVIew.h"
#import "HApplianceKingModel.h"
@implementation MultiFunctionVIew

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self configMentUI];
    }
    return self;
}
//懒加载
- (UIImageView *)imageView{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:_imageView];
    }
    return _imageView;
}
- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}
- (UILabel *)secondLabel{
    if (_secondLabel == nil) {
        _secondLabel = [[UILabel alloc] init];
        [self addSubview:_secondLabel];
    }
    return _secondLabel;
}
- (void)configMentUI{
    
}
- (void)layoutSubviews{
    self.imageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.width);
    self.titleLabel.frame = CGRectMake(0, self.frame.size.width, self.frame.size.width, 15);
    
    self.secondLabel.frame = CGRectMake(0, self.frame.size.width +15, self.frame.size.width, 15);
    
}
- (void)setApplianceKingModel:(HApplianceKingModel *)applianceKingModel{
    _applianceKingModel = applianceKingModel;
   
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:applianceKingModel.imageURl] placeholderImage:[UIImage imageNamed:@"lottery_withoutChannce"]];
    [self.titleLabel configmentfont:[UIFont systemFontOfSize:12] textColor:[UIColor blackColor] backColor:[UIColor whiteColor] textAligement:1 cornerRadius:0 text:applianceKingModel.titleStr];
    [self.secondLabel configmentfont:[UIFont systemFontOfSize:10] textColor:[UIColor blackColor] backColor:[UIColor whiteColor] textAligement:0 cornerRadius:0 text:applianceKingModel.priceStr];
}




@end
