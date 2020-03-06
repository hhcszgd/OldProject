//
//  CPTableHeader.m
//  b2c
//
//  Created by wangyuanfei on 16/5/24.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "CPTableHeader.h"

@interface CPTableHeader ()
@property(nonatomic,weak)UIView * topContainer ;
@property(nonatomic,weak)UILabel * orderMoneyLabel ;
@property(nonatomic,weak)UILabel * moneyLabel ;

@end

@implementation CPTableHeader

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        
        
        
        UIView * topContainer = [[UIView alloc]init];
        self.topContainer = topContainer;
        [self addSubview:topContainer];
        
        UILabel * orderMoneyLabel  = [[UILabel alloc]init];
        orderMoneyLabel.textColor = MainTextColor;
        orderMoneyLabel.text=@"订单金额";
        self.orderMoneyLabel = orderMoneyLabel;
        [self.topContainer addSubview:orderMoneyLabel];
        
        UILabel * moneyLabel  = [[UILabel alloc]init];
        moneyLabel.textAlignment = NSTextAlignmentRight;
        self.moneyLabel = moneyLabel;
        [self.topContainer addSubview:moneyLabel];
        moneyLabel.textColor = [UIColor redColor];
        
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat margin = 10 ;
    
//    CGFloat bottomW = self.bounds.size.width ;
//    CGFloat bottomH = margin ;
//    CGFloat bottomX = 0 ;
//    CGFloat bottomY = self.bounds.size.height - bottomH ;
//    self.bottomLine.frame = CGRectMake(bottomX, bottomY, bottomW, bottomH);
    CGFloat topContainerW =  self.bounds.size.width;
    CGFloat topContainerH = self.bounds.size.height-margin ;
    CGFloat topContainerX = 0 ;
    CGFloat topContainerY = 0 ;
    self.topContainer.backgroundColor = [UIColor whiteColor];
    self.topContainer.frame  = CGRectMake(topContainerX, topContainerY, topContainerW, topContainerH);
    
    
    CGFloat orderMoneyLabelW = (self.bounds.size.width - margin*2)/2 ;
    CGFloat orderMoneyLabelH = topContainerH ;
    CGFloat orderMoneyLabelX = margin ;
    CGFloat orderMoneyLabelY = 0 ;
    self.orderMoneyLabel.frame = CGRectMake(orderMoneyLabelX, orderMoneyLabelY, orderMoneyLabelW, orderMoneyLabelH);
    
    CGFloat moneyLabelW = orderMoneyLabelW ;
    CGFloat moneyLabelH = orderMoneyLabelH ;
    CGFloat moneyLabelX = CGRectGetMaxX(self.orderMoneyLabel.frame) ;
    CGFloat moneyLabelY = 0 ;
    self.moneyLabel.frame = CGRectMake(moneyLabelX, moneyLabelY, moneyLabelW, moneyLabelH);
    

}

-(void)setMoney:(NSString *)money{
    _money = money.copy;
    
    self.moneyLabel.text = [NSString stringWithFormat:@"%.02f元",[_money integerValue]/100.0];

}
@end
