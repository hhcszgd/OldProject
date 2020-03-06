//
//  FHistoryCell.m
//  b2c
//
//  Created by 0 on 16/4/9.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//


#import "FHistoryCell.h"
@interface FHistoryCell()
/**图片*/
@property (nonatomic, strong) UIImageView *gcImageView;
/**介绍*/
@property (nonatomic, strong) UILabel *gcTitleLabel;
/**价格*/
@property (nonatomic, strong) UILabel *gcPriceLabel;
@end
@implementation FHistoryCell

- (UIImageView *)gcImageView{
    if (_gcImageView == nil) {
        _gcImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_gcImageView];
    }
    return _gcImageView;
}
- (UILabel *)gcTitleLabel{
    if (_gcTitleLabel == nil) {
        _gcTitleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_gcTitleLabel];
    }
    return _gcTitleLabel;
}
- (UILabel *)gcPriceLabel{
    if (_gcPriceLabel == nil) {
        _gcPriceLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_gcPriceLabel];
    }
    return _gcPriceLabel;
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self.gcImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.contentView.mas_left).offset(10);
            make.centerY.equalTo(self.contentView);
            make.width.equalTo(@(80));
            make.height.equalTo(self.gcImageView.mas_width);
            
        }];
        self.gcImageView.image = [UIImage imageNamed:@"lottery_withoutChannce"];
//        self.gcImageView.backgroundColor = randomColor;
        //布局gcTitleLabel
        [self.gcTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            //让gctitlelabel根据照片布局
            make.top.equalTo(self.gcImageView.mas_top).offset(5);
            make.left.equalTo(self.gcImageView.mas_right).offset(5);
            make.right.equalTo(self.contentView.mas_right).offset(-5);
            
        }];
        [self.gcTitleLabel sizeToFit];
        [self.gcTitleLabel setNumberOfLines:2];
        //根据字体确定两行字的高度
        NSString *str = @"我";
        CGSize fontSize = [str sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
        
        //布局价格label
        [self.gcPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.gcTitleLabel.mas_top).offset(5 + fontSize.height * 2 + 1);
            make.left.equalTo(self.gcImageView.mas_right).offset(5);
            
        }];
        [self.gcPriceLabel sizeToFit];
    }
    return self;
}
- (void)setFootHistoryModel:(FHistoryModel *)footHistoryModel{
    _footHistoryModel = footHistoryModel;
    [self.gcTitleLabel configmentfont:[UIFont systemFontOfSize:13] textColor:[UIColor blackColor] backColor:[UIColor whiteColor] textAligement:0 cornerRadius:0 text:@"你好，加快了房了卡立爱空间发空间放开垃圾收款单风借口啦刻就看了看了"];
    [self.gcPriceLabel configmentfont:[UIFont systemFontOfSize:12] textColor:[UIColor redColor] backColor:[UIColor whiteColor] textAligement:0 cornerRadius:0 text:@"$12.5"];
}



@end
