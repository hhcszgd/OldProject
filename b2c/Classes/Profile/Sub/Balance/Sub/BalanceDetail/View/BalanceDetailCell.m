//
//  BalanceDetailCell.m
//  b2c
//
//  Created by 0 on 16/4/20.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "BalanceDetailCell.h"
@interface BalanceDetailCell()
/**余额标题*/
@property (nonatomic, strong) UILabel *detailTitleLabel;
/**余额*/
@property (nonatomic, strong) UILabel *balanceLabel;
/**商品名称*/
@property (nonatomic, strong) UILabel *goodsNameLabel;
/**时间*/
@property (nonatomic, strong) UILabel *timeLabel;
/**消费说明*/
@property (nonatomic, strong) UILabel *consumptionLabel;
@end
@implementation BalanceDetailCell
- (UILabel *)detailTitleLabel{
    if (_detailTitleLabel == nil) {
        _detailTitleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_detailTitleLabel];
        [_detailTitleLabel configmentfont:[UIFont boldSystemFontOfSize:16] textColor:[UIColor blackColor] backColor:[UIColor clearColor] textAligement:0 cornerRadius:0 text:@""];
        [_detailTitleLabel sizeToFit];
    }
    return _detailTitleLabel;
}

- (UILabel *)balanceLabel{
    if (_balanceLabel == nil) {
        _balanceLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_balanceLabel];
        [_balanceLabel configmentfont:[UIFont systemFontOfSize:14] textColor:[UIColor lightGrayColor] backColor:[UIColor clearColor] textAligement:0 cornerRadius:0 text:@""];
        [_balanceLabel sizeToFit];
    }
    return _balanceLabel;
}

- (UILabel *)goodsNameLabel{
    if (_goodsNameLabel == nil) {
        _goodsNameLabel= [[UILabel alloc] init];
        [self.contentView addSubview:_goodsNameLabel];
    }
    return _goodsNameLabel;
}

- (UILabel *)timeLabel{
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_timeLabel];
        [_timeLabel configmentfont:[UIFont systemFontOfSize:13] textColor:[UIColor lightGrayColor] backColor:[UIColor clearColor] textAligement:0 cornerRadius:0 text:@""];
        [_balanceLabel sizeToFit];
    }
    return _timeLabel;
}

- (UILabel *)consumptionLabel{
    if (_consumptionLabel == nil) {
        _consumptionLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_consumptionLabel];
        [_consumptionLabel configmentfont:[UIFont systemFontOfSize:14] textColor:[UIColor greenColor] backColor:[UIColor clearColor] textAligement:0 cornerRadius:0 text:@""];
        [_consumptionLabel sizeToFit];
    }
    return _consumptionLabel;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
             make.width.equalTo(@(screenW));
            
        }];
        /**余额标题*/
        [self.detailTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(10);
            make.left.equalTo(self.contentView.mas_left).offset(10);
        }];
        
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.detailTitleLabel.mas_top).offset(0);
            make.right.equalTo(self.contentView.mas_right).offset(-10);
        }];
        
        
        /**余额*/
        UILabel *balance = [[UILabel alloc] init];
        [self.contentView addSubview:balance];
        [balance sizeToFit];
        [balance configmentfont:[UIFont systemFontOfSize:14] textColor:[UIColor lightGrayColor] backColor:[UIColor clearColor] textAligement:0 cornerRadius:0 text:@"余额:"];
        [balance mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.detailTitleLabel.mas_bottom).offset(5);
            make.left.equalTo(self.contentView.mas_left).offset(10);
        }];
        [self.balanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.detailTitleLabel.mas_bottom).offset(5);
            make.left.equalTo(balance.mas_right).offset(5);
        }];
        
        
        [self.consumptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(balance.mas_top).offset(0);
            make.right.equalTo(self.contentView.mas_right).offset(-10);
        }];
        /**商品名称*/
        UILabel *goodName = [[UILabel alloc] init];
        [self.contentView addSubview:goodName];
        [goodName sizeToFit];
        [goodName configmentfont:[UIFont systemFontOfSize:14] textColor:[UIColor lightGrayColor] backColor:[UIColor clearColor] textAligement:0 cornerRadius:0 text:@"商品名称:"];
        [goodName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(balance.mas_bottom).offset(5);
            make.left.equalTo(self.contentView.mas_left).offset(10);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        }];
        [self.goodsNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(goodName.mas_top).offset(0);
            make.right.equalTo(self.contentView.mas_right).offset(-10);
        }];
        
        
        UIView *lineView = [[UIView alloc] init];
        [self.contentView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.equalTo(self.contentView);
            make.height.equalTo(@(2));
        }];
        lineView.backgroundColor = BackgroundGray;
        
        
    }
    return self;
}

- (void)setBalanceModel:(BalanceDetailModel *)balanceModel{
    _balanceModel = balanceModel;
    self.detailTitleLabel.text = balanceModel.detailTitleLabel;
    self.balanceLabel.text = balanceModel.balanceLabel;
    self.timeLabel.text = balanceModel.timeLabel;
    self.goodsNameLabel.text = balanceModel.goodsNameLabel;
    self.consumptionLabel.text = balanceModel.consumptionLabel;
    
}





@end
