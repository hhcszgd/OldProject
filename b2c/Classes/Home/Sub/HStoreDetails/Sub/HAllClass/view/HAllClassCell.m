//
//  HAllClassCell.m
//  b2c
//
//  Created by 0 on 16/3/31.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HAllClassCell.h"
#import "HAllClassModel.h"
@interface HAllClassCell()

@end
@interface HAllClassCell()
@end
@implementation HAllClassCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self configmentUI];
        
    }
    return self;
}
- (UILabel *)classLabel{
    if (_classLabel == nil) {
        _classLabel = [[UILabel alloc] init];
        
        [self.contentView addSubview:_classLabel];
    }
    return _classLabel;
}
- (void)configmentUI{
    [self.classLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.contentView);
    }];
    
}
-(void)setSelected:(BOOL)selected{
    if (selected) {
        self.classLabel.backgroundColor = [UIColor redColor];
        self.classLabel.textColor = [UIColor whiteColor];
        
    }else{
        self.classLabel.textColor = [UIColor blackColor];
        self.classLabel.backgroundColor =[UIColor lightGrayColor];
    }
    
}

@end
