//
//  OrderDetailStateCell.m
//  b2c
//
//  Created by 0 on 16/4/13.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "OrderDetailStateCell.h"

@implementation OrderDetailStateCell


- (UIImageView *)backGroundImage{
    if (_backGroundImage == nil) {
        _backGroundImage = [[UIImageView alloc] init];
        [self.contentView addSubview:_backGroundImage];
    }
    return _backGroundImage;
}
- (UILabel *)statusLabel{
    if (_statusLabel == nil) {
        _statusLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_statusLabel];
    }
    return _statusLabel;
}

- (UILabel *)reasonLabel{
    if (_reasonLabel == nil) {
        _reasonLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_reasonLabel];
    }
    return _reasonLabel;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
             make.width.equalTo(@(screenW));
        }];
        [self.backGroundImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.equalTo(self.contentView);
            make.height.equalTo(@(screenW/3.0));
            
        }];
        [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView).offset(-15);
            make.left.equalTo(self.contentView.mas_left).offset(30);
            
        }];
        [self.statusLabel sizeToFit];
        [self.reasonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.statusLabel.mas_bottom).offset(0);
            make.left.equalTo(self.statusLabel.mas_left).offset(0);
            
        }];
        [self.reasonLabel setNumberOfLines:2];
        [self.reasonLabel sizeToFit];
    }
    return self;
}
- (void)setOrderTailModel:(OrderDetailModel *)orderTailModel{
    switch (orderTailModel.orderState) {
        case orderStatusClose:
        {
            [self.statusLabel configmentfont:[UIFont systemFontOfSize:14 * SCALE] textColor:[UIColor redColor] backColor:[UIColor clearColor] textAligement:0 cornerRadius:0 text:@"交易关闭"];
            
            
            
            
        }
            break;
        case orderStatusSuccessed:
        {
            [self.statusLabel configmentfont:[UIFont systemFontOfSize:14 * SCALE] textColor:[UIColor redColor] backColor:[UIColor clearColor] textAligement:0 cornerRadius:0 text:@"交易成功"];
            
            
    
            
        }
            break;
        case orderStatusWaitingForBuyerToPay:
        {
            
            [self.statusLabel configmentfont:[UIFont systemFontOfSize:14 * SCALE] textColor:[UIColor redColor] backColor:[UIColor clearColor] textAligement:0 cornerRadius:0 text:@"等待买家付款"];
            
        }
            break;
        case orderStatusWaitingForDelivery:
        {
            [self.statusLabel configmentfont:[UIFont systemFontOfSize:14 * SCALE] textColor:[UIColor redColor] backColor:[UIColor clearColor] textAligement:0 cornerRadius:0 text:@"卖家已发货"];
            
      
        }
            break;
        case orderStatusChaseRatings:
        {
            [self.statusLabel configmentfont:[UIFont systemFontOfSize:14 * SCALE] textColor:[UIColor redColor] backColor:[UIColor clearColor] textAligement:0 cornerRadius:0 text:@"交易成功"];
            
            
        }
            break;
        case orderStatusRemindSellerShip:
        {
            
            [self.statusLabel configmentfont:[UIFont systemFontOfSize:14 * SCALE] textColor:[UIColor redColor] backColor:[UIColor clearColor] textAligement:0 cornerRadius:0 text:@"提醒卖家发货"];
            
            
        }
            break;
            
        case orderStatusRefundSuccess:
        {
            [self.statusLabel configmentfont:[UIFont systemFontOfSize:14 * SCALE] textColor:[UIColor redColor] backColor:[UIColor clearColor] textAligement:0 cornerRadius:0 text:@"退款成功"];
            
            
        }
            break;
        case orderStatusInRefund:
        {
            [self.statusLabel configmentfont:[UIFont systemFontOfSize:14 * SCALE] textColor:[UIColor redColor] backColor:[UIColor clearColor] textAligement:0 cornerRadius:0 text:@"退款成功"];
            
        }
            break;
        default:
            break;
    }
}



@end
