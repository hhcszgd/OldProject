//
//  COrderPayCell.m
//  b2c
//
//  Created by 0 on 16/5/24.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "COrderPayCell.h"
@interface COrderPayCell()
/**支付配送*/
@property (nonatomic, strong) UILabel *payTitle;
/**支付方式*/
@property (nonatomic, strong) UILabel *payStyle;
/**配送方式*/
@property (nonatomic, strong) UILabel *dellveryStyle;
@end
@implementation COrderPayCell
- (UILabel *)payTitle{
    if (_payTitle == nil) {
        _payTitle = [[UILabel alloc] init];
        [self.contentView addSubview:_payTitle];
        [_payTitle configmentfont:[UIFont systemFontOfSize:15 *zkqScale] textColor:[UIColor colorWithHexString:@"333333"] backColor:[UIColor whiteColor] textAligement:0 cornerRadius:0 text:@""];
        [_payTitle sizeToFit];
    }
    return _payTitle;
}
- (UILabel *)payStyle{
    if (_payStyle == nil) {
        _payStyle = [[UILabel alloc] init];
        [self.contentView addSubview:_payStyle];
        [_payStyle configmentfont:[UIFont systemFontOfSize:13 *zkqScale] textColor:[UIColor colorWithHexString:@"999999"] backColor:[UIColor whiteColor] textAligement:0 cornerRadius:0 text:@""];
        [_payStyle sizeToFit];
    }
    return _payStyle;
}
- (UILabel *)dellveryStyle{
    if (_dellveryStyle == nil) {
        _dellveryStyle = [[UILabel alloc] init];
        [self.contentView addSubview:_dellveryStyle];
        [_dellveryStyle configmentfont:[UIFont systemFontOfSize:13 * zkqScale] textColor:[UIColor colorWithHexString:@"999999"] backColor:[UIColor whiteColor] textAligement:0 cornerRadius:0 text:@""];
        [_dellveryStyle sizeToFit];
    }
    return _dellveryStyle;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self.payTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(16);
            make.left.equalTo(self.contentView.mas_left).offset(10);
        }];
        [self.payStyle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.payTitle);
            make.right.equalTo(self.contentView.mas_right).offset(-10);
        }];
        [self.dellveryStyle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.payStyle.mas_bottom).offset(10);
            make.right.equalTo(self.contentView.mas_right).offset(-10);
        }];
        UIView *lineView = [[UIView alloc] init];
        [self.contentView addSubview:lineView];
        lineView.backgroundColor = BackgroundGray;
        
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.dellveryStyle.mas_bottom).offset(14);
            make.right.equalTo(self.contentView);
            make.left.equalTo(self.contentView.mas_left).offset(10);
            make.height.equalTo(@(1));
            make.width.equalTo(@(screenW - 10));
            make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
        }];
        
    }
    return self;
}

- (void)setPayModel:(COrderPayModel *)payModel{
    self.payTitle.text = payModel.title;
    self.payStyle.text = payModel.pay;
    self.dellveryStyle.text = payModel.ship;
}



@end
