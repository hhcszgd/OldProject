//
//  HPromptCell.m
//  b2c
//
//  Created by 张凯强 on 16/7/12.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HPromptCell.h"
@interface HPromptCell ()
@property (strong , nonatomic) UILabel *promptLabel;
@end
@implementation HPromptCell
- (UILabel *)promptLabel{
    if (_promptLabel == nil) {
        _promptLabel =[[UILabel alloc] init];
        [self.contentView addSubview:_promptLabel];
        [_promptLabel configmentfont:[UIFont systemFontOfSize:14 * SCALE] textColor:[UIColor colorWithHexString:@"999999"] backColor:[UIColor colorWithHexString:@"ffffff"] textAligement:1 cornerRadius:0 text:@"啊哦~该店铺还没有商品，再等等吧！"];
    }
    return _promptLabel;
}



- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self.promptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.equalTo(self.contentView);
        }];
    }
    return self;
}
- (void)setBaseModel:(HStoreDetailModel *)baseModel{
    
}



@end
