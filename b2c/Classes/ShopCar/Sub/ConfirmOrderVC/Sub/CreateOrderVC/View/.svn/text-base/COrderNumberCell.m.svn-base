//
//  COrderNumberCell.m
//  b2c
//
//  Created by 0 on 16/5/24.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "COrderNumberCell.h"
@interface COrderNumberCell()
/**订单title*/
@property (nonatomic, strong) UILabel *orderTitle;
/**订单号*/
@property (nonatomic, strong) UILabel *orderNumber;

@end
@implementation COrderNumberCell
- (UILabel *)orderTitle{
    if (_orderTitle == nil) {
        _orderTitle = [[UILabel alloc] init];
        [self.contentView addSubview:_orderTitle];
        [_orderTitle configmentfont:[UIFont systemFontOfSize:15 *zkqScale] textColor:[UIColor colorWithHexString:@"333333"] backColor:[UIColor whiteColor] textAligement:0 cornerRadius:0 text:@"订单号:"];
        [_orderTitle sizeToFit];
    }
    return _orderTitle;
}

- (UILabel *)orderNumber{
    if (_orderNumber == nil) {
        _orderNumber = [[UILabel alloc] init];
        [self.contentView addSubview:_orderNumber];
        [_orderNumber configmentfont:[UIFont systemFontOfSize:15 * zkqScale] textColor:[UIColor colorWithHexString:@"333333"] backColor:[UIColor whiteColor] textAligement:0 cornerRadius:0 text:@""];
        [_orderNumber sizeToFit];
    }
    return _orderNumber;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self.orderTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(13);
            make.left.equalTo(self.contentView.mas_left).offset(10);
            
        }];
        [self.orderNumber mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.orderTitle);
            make.left.equalTo(self.orderTitle.mas_right).offset(10);
        }];
        UIView *lineView = [[UIView alloc] init];
        [self.contentView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView);
            make.top.equalTo(self.orderTitle.mas_bottom).offset(13);
            make.height.equalTo(@(10));
            make.bottom.equalTo(self.contentView.mas_bottom);
            make.width.equalTo(@(screenW));
        }];
        lineView.backgroundColor = BackgroundGray;
        
        
        
        
    }
    return self;
}

- (void)setNumberModel:(COrderNumberModel *)numberModel{
    self.orderNumber.text = numberModel.ordernumber;
}


@end
