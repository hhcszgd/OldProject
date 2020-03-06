//
//  ClassifyCHeader.m
//  b2c
//
//  Created by 0 on 16/4/23.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "ClassifyCHeader.h"
@interface ClassifyCHeader()
/**二级分类*/
@property (nonatomic, strong) UILabel *twoLevelLabel;

@end
@implementation ClassifyCHeader
- (UILabel *)twoLevelLabel{
    if (_twoLevelLabel == nil) {
        _twoLevelLabel = [[UILabel alloc] init];
        [self addSubview:_twoLevelLabel];
    }
    return _twoLevelLabel;
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self.twoLevelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.left.equalTo(self);
            
        }];
        [self.twoLevelLabel configmentfont:[UIFont systemFontOfSize:13] textColor:[UIColor colorWithHexString:twoLevelTextColor] backColor:[UIColor clearColor] textAligement:0 cornerRadius:0 text:@""];
    }
    return self;
}

- (void)setTwoLevelStr:(NSString *)twoLevelStr{
    self.twoLevelLabel.text = twoLevelStr;
    _twoLevelStr = twoLevelStr;
}



@end
