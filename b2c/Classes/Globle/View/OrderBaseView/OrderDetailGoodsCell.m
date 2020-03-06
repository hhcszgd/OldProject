//
//  OrderDetailGoodsCell.m
//  b2c
//
//  Created by 0 on 16/4/14.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//


#import "OrderDetailGoodsCell.h"
@interface OrderDetailGoodsCell()
@property (nonatomic, copy) NSArray *tapArr;

@end
@implementation OrderDetailGoodsCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (UIImageView*)goodImage{
    if (_goodImage == nil) {
        _goodImage = [[UIImageView alloc] init];
        [self.contentView addSubview:_goodImage];
    }
    return _goodImage;
}
- (UILabel *)goodTitle{
    if (_goodTitle == nil) {
        _goodTitle = [[UILabel alloc] init];
        [self.contentView addSubview:_goodImage];
    }
    return _goodTitle;
}
- (UILabel *)priceLabel{
    if (_priceLabel == nil) {
        _priceLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_priceLabel];
    }
    return _priceLabel;
}
- (UILabel *)countLabel{
    if (_countLabel == nil) {
        _countLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_countLabel];
    }
    return _countLabel;
}


- (UITapGestureRecognizer *)applicateACTap{
    if (_applicateACTap == nil) {
        _applicateACTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(applicateACTap:)];
    }
    return _applicateACTap;
}
- (UILabel *)afterCostLabel{
    if (_afterCostLabel == nil) {
        _afterCostLabel = [[UILabel alloc] init];
        _afterCostLabel.userInteractionEnabled = YES;
    }
    return _afterCostLabel;
}
- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        [self.contentView addSubview:_lineView];
    }
    return _lineView;
}


- (UITapGestureRecognizer *)refundReumTap{
    if (_refundReumTap == nil) {
        _refundReumTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(refundReumTap:)];
        
    }
    return _refundReumTap;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _tapArr =  @[self.applicateACTap, self.refundReumTap];
        self.contentView.backgroundColor = BackgroundGray;
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
             make.width.equalTo(@(screenW));
        }];
        //布局商品图片
        
        [self.goodImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(10);
            make.left.equalTo(self.contentView.mas_left).offset(10);
            make.width.equalTo(@(80));
            make.height.equalTo(@(80));
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-13);
        }];
        //布局商品介绍
        [self.contentView addSubview:self.goodTitle];
        [self.goodTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.goodImage.mas_top).offset(3);
            make.left.equalTo(self.goodImage.mas_right).offset(10);
             make.width.equalTo(@(0.5 * screenW));
        }];
        [self.goodTitle sizeToFit];
        [self.goodTitle setNumberOfLines:2];
        //布局商品价格
    
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.goodImage.mas_top).offset(0);
            make.right.equalTo(self.contentView.mas_right).offset(-10);
            
        }];
        [self.priceLabel sizeToFit];
        //布局数量
        [self.contentView addSubview:self.countLabel];
        [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.priceLabel.mas_bottom).offset(10);
            make.right.equalTo(self.contentView.mas_right).offset(-10);
            
        }];
        [self.countLabel sizeToFit];
        [self.contentView addSubview:self.afterCostLabel];
        [self.afterCostLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.countLabel.mas_bottom).offset(10);
            make.right.equalTo(self.contentView.mas_right).offset(-20);
             make.width.equalTo(@(70));
            make.height.equalTo(@(30));
        }];
        
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.contentView);
            make.height.equalTo(@(4));
        }];
                
        
        
        
                
        
        
    }
    return self;
}

- (void)toStoreTap:(UITapGestureRecognizer *)toStoreTap{
    LOG(@"%@,%d,%@",[self class], __LINE__,@"店铺")
}


- (void)setOrderTailModel:(OrderDetailModel *)orderTailModel{
    for (NSInteger i = 0; i < _tapArr.count; i++) {
        [self.afterCostLabel removeGestureRecognizer:_tapArr[i]];
    }
    
    switch (orderTailModel.orderState) {
        case orderStatusClose:
        {
            [self.afterCostLabel setHidden:YES];
            
            
            
            
        }
            break;
        case orderStatusSuccessed:
        {
            [self.afterCostLabel configmentfont:[UIFont systemFontOfSize:14 * SCALE] textColor:[UIColor redColor] backColor:[UIColor whiteColor] textAligement:1 cornerRadius:0 text:@"申请售后"];
            [self.afterCostLabel addGestureRecognizer:self.applicateACTap];
            [self.afterCostLabel setHidden:NO];
            
            
            
            
        }
            break;
        case orderStatusWaitingForBuyerToPay:
        {
            
            [self.afterCostLabel setHidden:YES];
            
        }
            break;
        case orderStatusWaitingForDelivery:
        {
            
            [self.afterCostLabel configmentfont:[UIFont systemFontOfSize:14 * SCALE] textColor:[UIColor redColor] backColor:[UIColor whiteColor] textAligement:1 cornerRadius:0 text:@"退款"];
            [self.afterCostLabel addGestureRecognizer:self.refundReumTap];
            [self.afterCostLabel setHidden:NO];
            
            
        }
            break;
        case orderStatusChaseRatings:
        {
           [self.afterCostLabel setHidden:YES];
            
            
        }
            break;
        case orderStatusRemindSellerShip:
        {
            [self.afterCostLabel setHidden:NO];
            LOG(@"%@,%d,%@",[self class], __LINE__,@"退款")
            [self.afterCostLabel configmentfont:[UIFont systemFontOfSize:14 * SCALE] textColor:[UIColor redColor] backColor:[UIColor whiteColor] textAligement:1 cornerRadius:0 text:@"退款"];
            [self.afterCostLabel addGestureRecognizer:self.refundReumTap];
            
            
            
        }
            break;
            
        case orderStatusRefundSuccess:
        {
            [self.afterCostLabel setHidden:YES];
            
            
        }
            break;
        case orderStatusInRefund:
        {
            [self.afterCostLabel setHidden:YES];
            
        }
            break;
        default:
            break;
    }
    
}
- (void)refundReumTap:(UITapGestureRecognizer *)refundReumTap{
    LOG(@"%@,%d,%@",[self class], __LINE__,@"退款")
}
- (void)applicateACTap:(UITapGestureRecognizer *)applicateACTap{
    LOG(@"%@,%d,%@",[self class], __LINE__,@"申请售后")
}


@end
