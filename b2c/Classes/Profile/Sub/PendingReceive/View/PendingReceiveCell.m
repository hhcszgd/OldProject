//
//  PendingReceiveCell.m
//  b2c
//
//  Created by 0 on 16/4/13.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "PendingReceiveCell.h"

@implementation PendingReceiveCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = BackgroundGray;
        
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(screenW));
            make.height.equalTo(@(103));
        }];
        //布局图片
        [self.goodsImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(11);
            make.left.equalTo(self.contentView.mas_left).offset(10);
            make.height.equalTo(@(77));
            
            make.width.equalTo(self.goodsImage.mas_height);
        }];
        //布局title
        [self.TitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.goodsImage.mas_top).offset(5);
            make.left.equalTo(self.goodsImage.mas_right).offset(5);
            make.width.equalTo(@(screenW * 0.5));
        }];
        [self.TitleLabel sizeToFit];
        [self.TitleLabel setNumberOfLines:2];
        //布局尺寸和颜色
        [self.sizeAndcolorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.TitleLabel.mas_bottom).offset(2);
            make.left.equalTo(self.goodsImage.mas_right).offset(5);
            make.width.equalTo(@(screenW * 0.55));
        }];
        [self.sizeAndcolorLabel sizeToFit];
        [self.sizeAndcolorLabel setNumberOfLines:2];
        //布局售后服务
        [self.afterCostLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.sizeAndcolorLabel.mas_bottom).offset(2);
            make.left.equalTo(self.goodsImage.mas_right).offset(5);
        }];
        [self.afterCostLabel sizeToFit];
        //布局价格
        [self.PriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(15);
            make.right.equalTo(self.contentView.mas_right).offset(-10);
        }];
        [self.PriceLabel sizeToFit];
        //布局商品数量
        [self.countLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.PriceLabel.mas_bottom).offset(5);
            make.right.equalTo(self.contentView.mas_right).offset(-10);
        }];
        [self.countLable sizeToFit];
        
        
#pragma mark 假数据
        self.goodsImage.image = [UIImage imageNamed:@"zhekouqu"];
        [self.TitleLabel configmentfont:[UIFont boldSystemFontOfSize:13* SCALE] textColor:[UIColor blackColor] backColor:[UIColor clearColor] textAligement:0 cornerRadius:0 text:@"adidas 阿迪达斯 三叶草 女子 短袖 T桖 亮白 F78193"];
        [self.sizeAndcolorLabel configmentfont:[UIFont systemFontOfSize:13 * SCALE] textColor:customColor(150, 150, 150, 1) backColor:[UIColor clearColor] textAligement:0 cornerRadius:0 text:[NSString stringWithFormat:@"%@:%@;%@:%@",@"颜色分类",@"亮白",@"尺码",@"M"]];
        [self.PriceLabel configmentfont:[UIFont systemFontOfSize:12 * SCALE] textColor:[UIColor blackColor] backColor:[UIColor clearColor] textAligement:1 cornerRadius:0 text:@"$221.00"];
        [self.countLable configmentfont:[UIFont systemFontOfSize:11 * SCALE] textColor:customColor(146, 146, 146, 1) backColor:[UIColor clearColor] textAligement:1 cornerRadius:0 text:@"X1"];
        [self.afterCostLabel configmentfont:[UIFont systemFontOfSize:13 *SCALE] textColor:[UIColor whiteColor] backColor:[UIColor redColor] textAligement:1 cornerRadius:0 text:@"七天退换"];
    }
    return self;
}


@end
