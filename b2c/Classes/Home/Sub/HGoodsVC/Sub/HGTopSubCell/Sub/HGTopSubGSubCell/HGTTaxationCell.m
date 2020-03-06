//
//  HGTTaxationCell.m
//  b2c
//
//  Created by 张凯强 on 2017/2/21.
//  Copyright © 2017年 www.16lao.com. All rights reserved.
//

#import "HGTTaxationCell.h"

@interface HGTTaxationCell()
@property (nonatomic, strong) UILabel *taxationLabel;
@property (nonatomic, strong) UILabel *subTaxationLabel;


@end
@implementation HGTTaxationCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        UIView *lineView = [[UIView alloc] init];
        [self.contentView addSubview:lineView];
        lineView.backgroundColor = BackgroundGray;
        [self.taxationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(15);
            make.left.equalTo(self.contentView.mas_left).offset(10);
            
        }];
        [self.subTaxationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.taxationLabel.mas_right).offset(10);
            make.centerY.equalTo(self.taxationLabel.mas_centerY);
        }];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.taxationLabel.mas_bottom).offset(15);
            make.right.left.equalTo(self.contentView).offset(0);
            make.width.equalTo(@(screenW));
            make.height.equalTo(@(10));
            make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
        }];
        self.taxationLabel.text = @"税费:";
       
        
    }
    return self;
}
- (void)setTaxationModel:(HGTaxationModel *)taxationModel{
    if (taxationModel.taxation) {
        self.subTaxationLabel.text = taxationModel.taxation;
    }else {
        self.subTaxationLabel.text = @"卖家未设置税费";
    }
    
}

- (UILabel *)taxationLabel {
    if (_taxationLabel == nil) {
        _taxationLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_taxationLabel];
         [_taxationLabel configmentfont:[UIFont systemFontOfSize:15 * zkqScale] textColor:[UIColor colorWithHexString:@"333333"] backColor:[UIColor clearColor] textAligement:0 cornerRadius:0 text:@""];
        [_taxationLabel sizeToFit];
    }
    return  _taxationLabel;
}
- (UILabel *)subTaxationLabel {
    if (_subTaxationLabel == nil) {
        _subTaxationLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_subTaxationLabel];
        [_subTaxationLabel configmentfont:[UIFont systemFontOfSize:15 * zkqScale] textColor:[UIColor colorWithHexString:@"333333"] backColor:[UIColor clearColor] textAligement:0 cornerRadius:0 text:@""];
        [_subTaxationLabel sizeToFit];
    }
    return _subTaxationLabel;
}

@end
