//
//  HStroyCellCollectComposeView.m
//  b2c
//
//  Created by wangyuanfei on 16/4/14.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HStroyCellCollectComposeView.h"

#import "HCellComposeModel.h"

@interface HStroyCellCollectComposeView()

@property(nonatomic,weak)UILabel * composeLabel ;

@end

@implementation HStroyCellCollectComposeView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        UILabel * composeLabel  = [[UILabel alloc] init];
        composeLabel.textColor = [UIColor colorWithRed:51/256.0 green:51/256.0 blue:51/256.0 alpha:1];
        composeLabel.font = [UIFont systemFontOfSize:13*SCALE];
        self.composeLabel = composeLabel;
        [self addSubview:composeLabel];
    
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.composeLabel.frame=  CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);

}
-(void)setComposeModel:(HCellComposeModel *)composeModel{
    [super setComposeModel:composeModel];
    self.composeLabel.text = composeModel.title;

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
