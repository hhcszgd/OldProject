//
//  COrderNormalCell.m
//  b2c
//
//  Created by 0 on 16/5/24.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "COrderNormalCell.h"
@interface COrderNormalCell()
@property (nonatomic, strong) UILabel *normalTitle;
@property (nonatomic, strong) UILabel *normalValue;
@property (nonatomic, weak) UIView *lineView;
@end
@implementation COrderNormalCell
- (UILabel *)normalTitle{
    if (_normalTitle == nil) {
        _normalTitle = [[UILabel alloc] init];
        [self.contentView addSubview:_normalTitle];
        [_normalTitle configmentfont:[UIFont systemFontOfSize:15 *zkqScale] textColor:[UIColor colorWithHexString:@"333333"] backColor:[UIColor whiteColor] textAligement:0 cornerRadius:0 text:@""];
        [_normalTitle sizeToFit];
    }
    return _normalTitle;
}
- (UILabel *)normalValue{
    if (_normalValue == nil) {
        _normalValue = [[UILabel alloc] init];
        [self.contentView addSubview:_normalValue];
        [_normalValue configmentfont:[UIFont systemFontOfSize:13 * zkqScale] textColor:[UIColor colorWithHexString:@"999999"] backColor:[UIColor whiteColor] textAligement:0 cornerRadius:0 text:@""];
        [_normalValue sizeToFit];
    }
    return _normalValue;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor =[UIColor whiteColor];
        [self.normalTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(16);
            make.left.equalTo(self.contentView.mas_left).offset(10);
        }];
        [self.normalValue mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.normalTitle);
            make.right.equalTo(self.contentView.mas_right).offset(-10);
        }];
        UIView *lineView = [[UIView alloc] init];
        [self.contentView addSubview:lineView];
        lineView.backgroundColor = BackgroundGray;
        [lineView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.normalTitle.mas_bottom).offset(16);
            make.left.equalTo(self.contentView.mas_left).offset(0);
            make.right.equalTo(self.contentView.mas_right).offset(0);
            make.width.equalTo(@(screenW));
            make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
            make.height.equalTo(@(1));
        }];
        self.lineView = lineView;
    }
    return self;
}
- (void)setNorMaleModel:(COrderNormalModel *)norMaleModel{
    self.normalTitle.text = norMaleModel.title;
    self.normalValue.text = norMaleModel.subtitle;
    if ([norMaleModel.key isEqualToString:@"taxes"]) {
        if ([norMaleModel.subtitle isEqualToString:@"0"]) {
            self.normalValue.textColor = [UIColor colorWithHexString:@"999999"];
            self.normalValue.text = @"免费";
        }else {
            self.normalValue.textColor = THEMECOLOR;
            self.normalValue.attributedText = [norMaleModel.subtitle dealhomePricefirstFont:[UIFont systemFontOfSize:10] lastfont:[UIFont systemFontOfSize:10]];
            
        }
        [self.lineView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.normalTitle.mas_bottom).offset(16);
            make.left.equalTo(self.contentView.mas_left).offset(0);
            make.right.equalTo(self.contentView.mas_right).offset(0);
            make.width.equalTo(@(screenW));
            make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
            make.height.equalTo(@(10));
        }];
        
    }else {
        [self.lineView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.normalTitle.mas_bottom).offset(16);
            make.left.equalTo(self.contentView.mas_left).offset(0);
            make.right.equalTo(self.contentView.mas_right).offset(0);
            make.width.equalTo(@(screenW));
            make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
            make.height.equalTo(@(1));
        }];
    }
    
    
}


@end
