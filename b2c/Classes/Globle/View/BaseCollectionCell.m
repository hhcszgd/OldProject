//
//  BaseCollectionCell.m
//  b2c
//
//  Created by 0 on 16/4/8.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "BaseCollectionCell.h"

@implementation BaseCollectionCell
- (UIImageView *)BCImageView{
    if (_BCImageView == nil) {
        _BCImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_BCImageView];
    }
    return _BCImageView;
}
- (UILabel *)BCTitleLabel{
    if (_BCTitleLabel == nil) {
        _BCTitleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_BCTitleLabel];
    }
    return _BCTitleLabel;
}
- (UILabel *)BCPriceLabel{
    if (_BCPriceLabel == nil) {
        _BCPriceLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_BCPriceLabel];
    }
    return _BCPriceLabel;
}
- (UILabel *)BCCountLabel{
    if (_BCCountLabel == nil) {
        _BCCountLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_BCCountLabel];
    }
    return _BCCountLabel;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {

        //固定图片的高度
        
//        
//        [self.BCImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.left.right.equalTo(self.contentView);
//            make.height.equalTo(self.BCImageView.mas_width);
//        }];
//        //创建三个label
//        //商品信息
//        [self.BCTitleLabel sizeToFit];
//        
//        //商品价格
//        [self.BCPriceLabel sizeToFit];
//        
//        //剩余的数量
//        [self.BCCountLabel sizeToFit];
//        //选择按钮
//
//        //布局控件
//        [self.BCTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.BCImageView.mas_bottom).offset(0);
//            make.left.equalTo(self.contentView.mas_left).offset(0);
//            make.right.equalTo(self.contentView.mas_right).offset(0);
//        }];
//        [self.BCPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.BCTitleLabel.mas_bottom).offset(0);
//            make.left.equalTo(self.contentView.mas_left).offset(0);
//            make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
//            
//        }];
//        [self.BCCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.BCTitleLabel.mas_bottom).offset(0);
//            make.right.equalTo(self.contentView.mas_right).offset(0);
//            make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
//        }];
        
    }
    return self;
}


@end
