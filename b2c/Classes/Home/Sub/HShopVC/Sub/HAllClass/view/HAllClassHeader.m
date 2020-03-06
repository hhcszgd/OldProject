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
@property (nonatomic, strong) HAllClassBaseModel *saveModel;

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
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
        [self addGestureRecognizer:tap];
        self.userInteractionEnabled = YES;
        
    }
    return self;
}
- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        [self addSubview:_titleLabel];
        [_titleLabel configmentfont:[UIFont boldSystemFontOfSize:15] textColor:[UIColor blackColor] backColor:[UIColor whiteColor] textAligement:0 cornerRadius:0 text:@""];
    }
    return _titleLabel;
}

-(void)setBaseModel:(HAllClassBaseModel *)baseModel{
    _titleLabel.text = baseModel.classify_name;
    self.saveModel = baseModel;
}

- (void)tapClick:(UITapGestureRecognizer *)tap{
    if ([self.delegate respondsToSelector:@selector(clickToSearchWith:)]) {
        [self.delegate performSelector:@selector(clickToSearchWith:) withObject:self.saveModel];
    }
}
@end
