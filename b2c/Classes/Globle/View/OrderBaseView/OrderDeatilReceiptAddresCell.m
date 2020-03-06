//
//  OrderDeatilReceiptAddresCell.m
//  b2c
//
//  Created by 0 on 16/4/13.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "OrderDeatilReceiptAddresCell.h"

@implementation OrderDeatilReceiptAddresCell

- (UIImageView *)locationImage{
    if (_locationImage == nil) {
        _locationImage = [[UIImageView alloc] init];
        [self.contentView addSubview:_locationImage];
    }
    return _locationImage;
}

- (UILabel *)receiptName{
    if (_receiptName == nil) {
        _receiptName = [[UILabel alloc] init];
        [self.contentView addSubview:_receiptName];
    }
    return _receiptName;
}
- (UILabel *)receiptPhone{
    if (_receiptPhone == nil) {
        _receiptPhone = [[UILabel alloc] init];
        [self.contentView addSubview:_receiptPhone];
    }
    return _receiptPhone;
}

- (UILabel *)receiptAddress{
    if (_receiptAddress == nil) {
        _receiptAddress = [[UILabel alloc] init];
        [self.contentView addSubview:_receiptAddress];
    }
    return _receiptAddress;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
             make.width.equalTo(@(screenW));
        }];
        [self.locationImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.left.equalTo(self.contentView.mas_left).offset(10);
            make.width.equalTo(@(15));
            make.height.equalTo(@(20));
        }];
        [self.receiptName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(10);
            make.left.equalTo(self.locationImage.mas_right).offset(5);
        }];
        [self.receiptName sizeToFit];
        
        [self.receiptPhone mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(10);
            make.right.equalTo(self.contentView.mas_right).offset(-10);
        }];
        [self.receiptPhone sizeToFit];
        
        
        [self.receiptAddress mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.receiptName.mas_bottom).offset(5);
            make.left.equalTo(self.locationImage.mas_right).offset(5);
            make.right.equalTo(self.contentView.mas_right).offset(-10);
            
        }];
        [self.receiptAddress sizeToFit];
        [self.receiptAddress setNumberOfLines: 0];
        
        UIView *view = [[UIView alloc] init];
        [self.contentView addSubview:view];
        view.backgroundColor = BackgroundGray;
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.receiptAddress.mas_bottom).offset(5);
            make.right.bottom.left.equalTo(self.contentView);
            make.height.equalTo(@(20));
        }];
        
      
    }
    return self;
}

- (void)setOrderTailModel:(OrderDetailModel *)orderTailModel{
    [self.receiptName configmentfont:[UIFont systemFontOfSize:13] textColor:[UIColor blackColor] backColor:[UIColor whiteColor] textAligement:0 cornerRadius:0 text:[NSString stringWithFormat:@"收货人:%@",orderTailModel.receiptName]];
    [self.receiptPhone configmentfont:[UIFont systemFontOfSize:13] textColor:[UIColor blackColor] backColor:[UIColor whiteColor] textAligement:0 cornerRadius:0 text:orderTailModel.receiptPhone];
    [self.receiptAddress configmentfont:[UIFont systemFontOfSize:13] textColor:[UIColor blackColor] backColor:[UIColor whiteColor] textAligement:0 cornerRadius:0 text:[NSString stringWithFormat:@"收货地址:%@",orderTailModel.receiptAddress]];
}



@end
