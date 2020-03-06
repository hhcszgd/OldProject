//
//  HAllClassHeader.m
//  b2c
//
//  Created by 0 on 16/3/31.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HAllClassHeader.h"
#import "HAllClassModel.h"
@interface HAllClassHeader()
/**分组的组名*/
@property (nonatomic, strong) UILabel *titleLabel;
/**分割线*/
@property (nonatomic, strong) UIView *lineView;
@end
@implementation HAllClassHeader
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(0);
            make.left.equalTo(self.mas_left).offset(10);
            make.bottom.equalTo(self.mas_bottom).offset(0);
            make.right.equalTo(self.mas_right).offset(0);
        }];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom).offset(0);
            make.left.equalTo(self.mas_left).offset(10);
            make.right.equalTo(self.mas_right).offset(-10);
            make.height.equalTo(@(1));
        }];
        
    }
    return self;
}
- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}
- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = sepercolor;
        [self addSubview:_lineView];
        
    }
    return _lineView;
}
- (void)setModel:(id)model{
    HAllClassModel *headerModel = model;
    [self.titleLabel configmentfont:[UIFont boldSystemFontOfSize:15] textColor:[UIColor blackColor] backColor:[UIColor whiteColor] textAligement:0 cornerRadius:0 text:headerModel.sectionTitle];
}

@end
