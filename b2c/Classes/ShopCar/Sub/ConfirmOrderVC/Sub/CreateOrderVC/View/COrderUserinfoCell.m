//
//  COrderUserinfoCell.m
//  b2c
//
//  Created by 0 on 16/5/24.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "COrderUserinfoCell.h"
@interface COrderUserinfoCell()
/**电话*/
@property (nonatomic, strong) UILabel *phone;
/**姓名*/
@property (nonatomic, strong) UILabel *name;
/**地址*/
@property (nonatomic, strong) UILabel *address;
/**身份证号码*/
@property (nonatomic, strong) UILabel *CIDLabel;
@end
@implementation COrderUserinfoCell
- (UILabel *)CIDLabel {
    if (_CIDLabel == nil) {
        _CIDLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_CIDLabel];
        [_CIDLabel configmentfont:[UIFont systemFontOfSize:12 *zkqScale] textColor:[UIColor colorWithHexString:@"333333"] backColor:[UIColor whiteColor] textAligement:0 cornerRadius:0 text:@""];
        [_CIDLabel sizeToFit];
    }
    return _CIDLabel;
}


- (UILabel *)phone{
    if (_phone == nil) {
        _phone = [[UILabel alloc] init];
        [self.contentView addSubview:_phone];
        [_phone configmentfont:[UIFont systemFontOfSize:15 *zkqScale] textColor:[UIColor colorWithHexString:@"333333"] backColor:[UIColor whiteColor] textAligement:0 cornerRadius:0 text:@""];
        [_phone sizeToFit];
    }
    return _phone;
}
- (UILabel *)name{
    if (_name == nil) {
        _name = [[UILabel alloc] init];
        [self.contentView addSubview:_name];
        [_name configmentfont:[UIFont systemFontOfSize:15 * zkqScale] textColor:[UIColor colorWithHexString:@"333333"] backColor:[UIColor whiteColor] textAligement:0 cornerRadius:0 text:@""];
        [_name sizeToFit];
    }
    return _name;
}
- (UILabel *)address{
    if (_address == nil) {
        _address = [[UILabel alloc] init];
        [self.contentView addSubview:_address];
        [_address configmentfont:[UIFont systemFontOfSize:13 * zkqScale] textColor:[UIColor colorWithHexString:@"7f7f7f"] backColor:[UIColor whiteColor] textAligement:0 cornerRadius:0 text:@""];
        [_address setNumberOfLines:0];
    }
    return _address;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(16);
            make.left.equalTo(self.contentView.mas_left).offset(10);
            
        }];
        [self.CIDLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.name.mas_centerY);
            make.left.equalTo(self.name.mas_right).offset(10);
            
        }];
        [self.phone mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.name);
            make.right.equalTo(self.contentView.mas_right).offset(-10);
        }];
        [self.address mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.name.mas_bottom).offset(15);
            make.left.equalTo(self.contentView.mas_left).offset(10);
            make.right.equalTo(self.contentView.mas_right).offset(-10);
        }];
        
        UIView *lineView = [[UIView alloc] init];
        [self.contentView addSubview:lineView];
        lineView.backgroundColor = BackgroundGray;
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView);
            make.top.equalTo(self.address.mas_bottom).offset(15);
            make.height.equalTo(@(10));
            make.width.equalTo(@(screenW));
            make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
        }];
        
    }
    return self;
}
- (void)setUserInfoModel:(COrderUserInfo *)userInfoModel{
    self.name.text = userInfoModel.name;
    self.phone.text = userInfoModel.phone;
    self.address.text = userInfoModel.address;
    if ([userInfoModel.is_display isEqualToString:@"0"]) {
        self.CIDLabel.text = @"";
    }else {
        if (userInfoModel.id_number) {
            self.CIDLabel.text = [NSString stringWithFormat:@"(%@)",userInfoModel.id_number];
        }else {
            self.CIDLabel.text = @"";
        }
    }
    
    
    
    
}

@end
