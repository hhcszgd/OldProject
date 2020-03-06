//
//  OrderDeatilFooter.m
//  b2c
//
//  Created by 0 on 16/4/18.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//


#import "OrderDeatilFooter.h"
@interface OrderDeatilFooter()
/**运费view*/
@property (nonatomic, strong) UIView *freightView;
/**实付款view*/
@property (nonatomic, strong) UIView *relayPaymentView;
@end
@implementation OrderDeatilFooter

- (UIView *)freightView{
    if (_freightView == nil) {
        UIView *freightView = [[UIView alloc] init];
        
        [self.contentView addSubview:freightView];
        _freightView = freightView;
    }
    return _freightView;
}
- (UIView *)relayPaymentView{
    if (_relayPaymentView == nil) {
        UIView *relayPaymentView = [[UIView alloc] init];
        
        [self.contentView addSubview:relayPaymentView];
        _relayPaymentView = relayPaymentView;
    }
    return _relayPaymentView;
}



- (UILabel *)freightLabel{
    if (_freightLabel == nil) {
        _freightLabel = [[UILabel alloc] init];
        
    }
    return _freightLabel;
}

- (UILabel *)realPaymentLabel{
    if (_realPaymentLabel == nil) {
        _realPaymentLabel = [[UILabel alloc] init];
        
    }
    return _realPaymentLabel;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        //运费view
        
        self.freightView.backgroundColor = [UIColor whiteColor];
        self.relayPaymentView.backgroundColor = [UIColor whiteColor];
        //布局运费view和实付款view
        [self.freightView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.contentView).offset(0);
            make.height.equalTo(self.relayPaymentView);
            
            
        }];
        [self.relayPaymentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.equalTo(self.contentView);
            make.top.equalTo(self.freightView.mas_bottom).offset(0);
            
        }];
        
        UILabel *freight = [[UILabel alloc] init];
        [self.freightView addSubview:freight];
        [freight configmentfont:[UIFont systemFontOfSize:13] textColor:[UIColor blackColor] backColor:[UIColor clearColor] textAligement:0 cornerRadius:0 text:@"运费"];
        [freight mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.freightView.mas_left).offset(10);
            make.centerY.equalTo(self.freightView);
        }];
        [self.freightView addSubview:self.freightLabel];
        [self.freightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.freightView);
            make.right.equalTo(self.freightView.mas_right).offset(-10);
            
        }];
        [self.freightLabel sizeToFit];
        
        
        
        //布局实付款
        UILabel *relayPayment = [[UILabel alloc] init];
        [self.relayPaymentView addSubview:relayPayment];
        [relayPayment configmentfont:[UIFont systemFontOfSize:13] textColor:[UIColor blackColor] backColor:[UIColor clearColor] textAligement:0 cornerRadius:0 text:@"实付款"];
        
        [relayPayment mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.relayPaymentView.mas_left).offset(10);
            make.centerY.equalTo(self.relayPaymentView);
        }];
        
        
        
        [self.relayPaymentView addSubview:self.realPaymentLabel];
        [self.realPaymentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.relayPaymentView.mas_right).offset(-10);
           make.centerY.equalTo(self.relayPaymentView);
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

- (void)setOrderDetailModel:(OrderDetailModel *)orderDetailModel{
    [self.realPaymentLabel configmentfont:[UIFont systemFontOfSize:13] textColor:[UIColor blackColor] backColor:[UIColor clearColor] textAligement:0 cornerRadius:0 text:orderDetailModel.realPaymentLabel];
    [self.freightLabel configmentfont:[UIFont systemFontOfSize:13] textColor:[UIColor blackColor] backColor:[UIColor clearColor] textAligement:0 cornerRadius:0 text:orderDetailModel.freightLabel];
}



@end
