//
//  ConfirmOrderBar.m
//  b2c
//
//  Created by wangyuanfei on 16/4/28.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "ConfirmOrderBar.h"

#import "ConfirmOrderNormalCellModel.h"

@interface ConfirmOrderBar ()
@property(nonatomic,weak)UILabel * titleLabel ;
@property(nonatomic,weak)UIButton * confirmOrderButton ;
@end


@implementation ConfirmOrderBar
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        UILabel * titleLabel = [[UILabel alloc]init];
        titleLabel.font = [UIFont systemFontOfSize:14];
        self.titleLabel = titleLabel;
        
        [self addSubview:titleLabel];
        titleLabel.textAlignment = NSTextAlignmentRight;
        
        UIButton * confirmOrderButton    =  [[UIButton alloc]init ];
        [confirmOrderButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [confirmOrderButton addTarget:self action:@selector(confirmOrderButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        self.confirmOrderButton = confirmOrderButton;
        [confirmOrderButton setTitle:@"立即下单" forState:UIControlStateNormal];
        confirmOrderButton.backgroundColor = [UIColor colorWithRed:233/256.0 green:85/256.0 blue:19/256.0 alpha:1];
        [self addSubview:confirmOrderButton];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat confirmOrderButtonW = 100 ;
    CGFloat confirmOrderButtonH = self.bounds.size.height ;
    CGFloat confirmOrderButtonX = self.bounds.size.width - confirmOrderButtonW ;
    CGFloat confirmOrderButtonY = 0 ;
    self.confirmOrderButton.frame = CGRectMake(confirmOrderButtonX, confirmOrderButtonY, confirmOrderButtonW, confirmOrderButtonH);
    
    
    CGFloat margin = 10 ;
    CGFloat titleLabelW = self.bounds.size.width - confirmOrderButtonW -  margin;
    CGFloat titleLabelH = self.bounds.size.height ;
    CGFloat titleLabelX = 0 ;
    CGFloat titleLabelY = 0 ;
    self.titleLabel.frame = CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH);

}
-(void)setOrderBarModel:(ConfirmOrderNormalCellModel *)orderBarModel{
    _orderBarModel = orderBarModel;
    self.titleLabel.text = orderBarModel.title;
    LOG(@"_%@_%d_总价赋值的地方的打印   --->> %@",[self class] , __LINE__,orderBarModel.subtitle);
    NSString *contentStr = [NSString stringWithFormat:@"合计: %@元",orderBarModel.subtitle];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:contentStr];
    NSString * numStr = [contentStr substringFromIndex:3];
    NSString * txt = [contentStr substringToIndex:3];
    NSRange txtRange = [contentStr rangeOfString:txt];
    NSRange numRange = [contentStr rangeOfString:numStr];
    [str addAttribute:NSForegroundColorAttributeName value:MainTextColor range:txtRange];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:233/256.0 green:85/256.0 blue:19/256.0 alpha:1] range:numRange];
    
    [self.titleLabel setAttributedText:str];
    
    
}


-(void)confirmOrderButtonClick:(UIButton*)sender
{
    if ([self.delegate respondsToSelector:@selector(creatOrderClickWithConfirmOrderBar:)]) {
        [self.delegate creatOrderClickWithConfirmOrderBar:self];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
