//
//  CollectionHeader.m
//  TTmall
//
//  Created by 0 on 16/1/28.
//  Copyright © 2016年 Footway tech. All rights reserved.
//

#import "HSelectSpecHeader.h"

@interface HSelectSpecHeader()
@property (nonatomic, strong) UILabel *headerTirle;
@end
@implementation HSelectSpecHeader
- (UILabel *)headerTirle{
    if (_headerTirle == nil) {
        _headerTirle = [[UILabel alloc] init];
        [self addSubview:_headerTirle];
        [_headerTirle configmentfont:[UIFont systemFontOfSize:13 * zkqScale] textColor:[UIColor blackColor] backColor:[UIColor whiteColor] textAligement:0 cornerRadius:0 text:@""];
    }
    return _headerTirle;
}



- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        [self.headerTirle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(0);
            make.left.equalTo(self.mas_left).offset(10);
            make.bottom.equalTo(self.mas_bottom).offset(0);
            make.width.equalTo(@(screenW - 20));
        }];
        
        
    }
    return self;
}
- (void)setTitle:(NSString *)title{
    self.headerTirle.text = title;
}
@end
