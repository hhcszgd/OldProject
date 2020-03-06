//
//  HGSubMenuCell.m
//  b2c
//
//  Created by 0 on 16/5/18.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HGSubMenuCell.h"

@implementation HGSubMenuCell
- (UILabel *)menuTitle{
    if (_menuTitle == nil) {
        _menuTitle = [[UILabel alloc] init];
        [self.contentView addSubview:_menuTitle];
        [_menuTitle configmentfont:[UIFont systemFontOfSize:14 * zkqScale] textColor:[UIColor colorWithHexString:@"ffffff"] backColor:[[UIColor colorWithHexString:@"000000"] colorWithAlphaComponent:0.6] textAligement:1 cornerRadius:0 text:@""];
    }
    return _menuTitle;
}
- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        [self.contentView addSubview:_lineView];
        _lineView.backgroundColor = [UIColor clearColor];
    }
    return _lineView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        
        [self.menuTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self.contentView);
            make.bottom.equalTo(self.lineView.mas_top).offset(0);
        }];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
            make.height.equalTo(@(1));
        }];
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
           make.top.equalTo(self).offset(0);
            make.bottom.equalTo(self).offset(0);
        }];
        
            
        
        
    }
    return self;
}
- (void)layoutSubviews{
    
    
}

@end
