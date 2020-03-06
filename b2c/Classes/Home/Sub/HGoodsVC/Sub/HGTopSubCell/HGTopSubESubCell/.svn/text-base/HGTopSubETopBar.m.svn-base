//
//  HGTopSubETopBar.m
//  b2c
//
//  Created by 0 on 16/5/10.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HGTopSubETopBar.h"

@implementation HGTopSubETopBar
- (UILabel *)barTitleLabel{
    if (_barTitleLabel == nil) {
        _barTitleLabel = [[UILabel alloc] init];
        [self addSubview:_barTitleLabel];
        [_barTitleLabel configmentfont:[UIFont systemFontOfSize:14 * SCALE] textColor:[UIColor colorWithHexString:@"333333"] backColor:[UIColor whiteColor] textAligement:1 cornerRadius:0 text:@""];
        [_barTitleLabel sizeToFit];
    }
    return _barTitleLabel;
}
- (UILabel *)numberLabel{
    if (_numberLabel == nil) {
        _numberLabel = [[UILabel alloc] init];
        [self addSubview:_numberLabel];
        [_numberLabel configmentfont:[UIFont systemFontOfSize:12 * SCALE] textColor:[UIColor colorWithHexString:@"999999"] backColor:[UIColor whiteColor] textAligement:1 cornerRadius:0 text:@""];
        [_numberLabel sizeToFit];
    }
    return _numberLabel;
}



- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self.barTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(self).offset(0);
        }];
        [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.bottom.equalTo(self).offset(0);
        }];
    }
    return self;
}
- (void)setSubModel:(HGTopSubESubModel *)subModel{
    self.barTitleLabel.text = subModel.name;
    self.numberLabel.text = subModel.number;
}

- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    if (selected) {
        self.barTitleLabel.textColor = THEMECOLOR;
        self.numberLabel.textColor = THEMECOLOR;
    }else{
        self.barTitleLabel.textColor = [UIColor colorWithHexString:@"333333"];
        self.numberLabel.textColor = [UIColor colorWithHexString:@"999999"];
    }
}

@end
