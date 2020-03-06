//
//  OrderDetailHeader.m
//  b2c
//
//  Created by 0 on 16/4/18.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "OrderDetailHeader.h"

@implementation OrderDetailHeader

- (UIImageView *)storeLogoImage{
    if (_storeLogoImage == nil) {
        _storeLogoImage = [[UIImageView alloc] init];
        [self.contentView addSubview:_storeLogoImage];
    }
    return _storeLogoImage;
}
- (UILabel *)storeName{
    if (_storeName == nil) {
        _storeName = [[UILabel alloc] init];
        [self.contentView addSubview:_storeName];
        
    }
    return _storeName;
}
- (UITapGestureRecognizer *)toStoreTap{
    if (_toStoreTap == nil) {
        _toStoreTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toStoreTap:)];
    }
    return _toStoreTap;
}
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        //布局logo图片
        
        [self.storeLogoImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.contentView.mas_left).offset(10);
             make.width.equalTo(@(20));
            make.height.equalTo(@(20));
        }];
        //布局店铺名字
        
        [self.storeName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.storeLogoImage.mas_right).offset(10);
        }];
        [self.storeName sizeToFit];
        //布局指示箭头
        UIImageView *arrowImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_Lcoin"]];
        [self.contentView addSubview:arrowImage];
        [arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.storeName.mas_right).offset(5);
            make.width.equalTo(@(20));
            make.height.equalTo(@(20));
        }];
        [self.contentView addGestureRecognizer:self.toStoreTap];
        self.contentView.userInteractionEnabled = YES;
        self.contentView.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}
- (void)toStoreTap:(UITapGestureRecognizer *)toStoreTap{
    if ([self.delegate respondsToSelector:@selector(actionToSotreDetail)]) {
        [self.delegate performSelector:@selector(actionToSotreDetail) withObject:nil];
    }
}
- (void)setOrderDetailModel:(OrderDetailModel *)orderDetailModel{
    self.storeLogoImage.image = [UIImage imageNamed:orderDetailModel.storeLogoImage];
    [self.storeName configmentfont:[UIFont systemFontOfSize:13] textColor:[UIColor blackColor] backColor:[UIColor clearColor] textAligement:0 cornerRadius:0 text:orderDetailModel.storeName];
}




@end
