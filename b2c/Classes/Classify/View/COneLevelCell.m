//
//  COneLevelCell.m
//  b2c
//
//  Created by 0 on 16/4/22.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "COneLevelCell.h"
@interface COneLevelCell()

@end
@implementation COneLevelCell
- (UILabel *)classLabel{
    if (_classLabel == nil) {
        _classLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_classLabel];
//        
    }
    return _classLabel;
}
- (UIView *)leftView{
    if (_leftView == nil) {
        _leftView = [[UIView alloc] init];
        [self.contentView addSubview:_leftView];
        _leftView.backgroundColor = [UIColor colorWithHexString:oneLevelSelectColor];
    }
    return _leftView;
}




- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //注意先后顺序防止leftView不显示
        [self.classLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.equalTo(self.contentView);
        }];
        
        [self.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.equalTo(self.contentView);
            make.width.equalTo(@(3.5));
        }];
        
        
        UIView *lineView = [[UIView alloc] init];
        [self.contentView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(self.contentView);
            make.height.equalTo(@(1));
        }];
        lineView.backgroundColor = BackgroundGray;
        
        
    }
    return self;
}





@end
