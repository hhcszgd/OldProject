//
//  SCBottomMenuBar.m
//  b2c
//
//  Created by wangyuanfei on 16/4/20.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "SCBottomMenuBar.h"
#import "SCBottomMenuBarModel.h"

@interface SCBottomMenuBar()

/** 全选按钮 */
//@property(nonatomic,weak)   UIButton * chooseAllButton ;
/** 全选按钮放大区域按钮 */
@property(nonatomic,weak)UIButton * chooseAllButtonPlus ;
@property(nonatomic,weak)   UILabel * chooseAllLabel ;
@property(nonatomic,weak)   UILabel * totalMoneyLabel ;
@property(nonatomic,weak)   UIButton * goodsCountBeChoosedButton ;

@end


@implementation SCBottomMenuBar
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        UIButton * chooseAllButton =[[UIButton alloc]init];
        [chooseAllButton setImage:[UIImage imageNamed:@"btn_round_nor"] forState:UIControlStateNormal];
        [chooseAllButton setImage:[UIImage imageNamed:@"btn_round_sel"] forState:UIControlStateSelected];
        self.chooseAllButton = chooseAllButton;
        [self addSubview:chooseAllButton];
        [chooseAllButton addTarget:self action:@selector(chooseAllButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        UILabel * chooseAllLabel =[[UILabel alloc]init];
        self.chooseAllLabel = chooseAllLabel;
        chooseAllLabel.text = @"全选";
        chooseAllLabel.textColor = MainTextColor;
        [self addSubview:chooseAllLabel];
        
        UILabel * totalMoneyLabel =[[UILabel alloc]init];
        totalMoneyLabel.textAlignment=NSTextAlignmentRight;
        self.totalMoneyLabel = totalMoneyLabel;
        [self addSubview:totalMoneyLabel];
        
        
        UIButton * goodsCountBeChoosedButton =[[UIButton alloc ]init];
        goodsCountBeChoosedButton.backgroundColor=THEMECOLOR;
        self.goodsCountBeChoosedButton = goodsCountBeChoosedButton;
        [self addSubview:goodsCountBeChoosedButton];
        [goodsCountBeChoosedButton addTarget:self action:@selector(settleMoneyClick:) forControlEvents:UIControlEventTouchUpInside];

        
        /** 全选按钮放大区域按钮 */
        UIButton * chooseAllButtonPlus = [[UIButton alloc]init];
        self.chooseAllButtonPlus = chooseAllButtonPlus;
        [self addSubview:chooseAllButtonPlus];
//        chooseAllButtonPlus.backgroundColor = randomColor;
        
        
        [chooseAllButtonPlus addTarget:self action:@selector(chooseAllButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews ];
    CGFloat leftMargin = 10 ;
    
    CGFloat chooseAllButtonW = 16 ;
    CGFloat chooseAllButtonH = chooseAllButtonW ;
    CGFloat chooseAllButtonX = leftMargin ;
    CGFloat chooseAllButtonY = (self.bounds.size.height-chooseAllButtonW)/2 ;
    
    self.chooseAllButton.frame = CGRectMake(chooseAllButtonX, chooseAllButtonY, chooseAllButtonW, chooseAllButtonH);
    
    CGPoint chooseAllButtonPlusCenter = [self.chooseAllButton convertPoint:CGPointMake(chooseAllButtonW/2, chooseAllButtonH/2) toView:self];
    self.chooseAllButtonPlus.bounds = CGRectMake(0, 0, chooseAllButtonW*2, chooseAllButtonW*2);
    self.chooseAllButtonPlus.center = chooseAllButtonPlusCenter;
    
    
    CGFloat chooseBtnToLbl = 10 ;
    
    CGSize chooseTxtSixe = [self.chooseAllLabel.text sizeWithFont:self.chooseAllLabel.font MaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT) ];
    CGFloat chooseAllLabelX = CGRectGetMaxX(self.chooseAllButton.frame)+chooseBtnToLbl ;
    CGFloat chooseAllLabelY = 0 ;
    CGFloat chooseAllLabelW = chooseTxtSixe.width ;
    CGFloat chooseAllLabelH = self.bounds.size.height ;
    self.chooseAllLabel.frame = CGRectMake(chooseAllLabelX, chooseAllLabelY, chooseAllLabelW, chooseAllLabelH);
    
    
    CGFloat goodsCountBeChoosedButtonW = 103 *SCALE;
    CGFloat goodsCountBeChoosedButtonH = self.bounds.size.height ;
    CGFloat goodsCountBeChoosedButtonX = self.bounds.size.width-goodsCountBeChoosedButtonW ;
    CGFloat goodsCountBeChoosedButtonY = 0 ;
    self.goodsCountBeChoosedButton.frame = CGRectMake(goodsCountBeChoosedButtonX, goodsCountBeChoosedButtonY, goodsCountBeChoosedButtonW, goodsCountBeChoosedButtonH);
    
    
    CGFloat margin = 10 ;
    CGFloat totalMoneyLabelX = CGRectGetMaxX(self.chooseAllLabel.frame)  +margin;
    CGFloat totalMoneyLabelY = 0 ;
    CGFloat totalMoneyLabelW = CGRectGetMinX(self.goodsCountBeChoosedButton.frame) - CGRectGetMaxX(self.chooseAllLabel.frame) - margin*2 ;
    CGFloat totalMoneyLabelH = self.bounds.size.height ;
    self.totalMoneyLabel.frame = CGRectMake(totalMoneyLabelX, totalMoneyLabelY, totalMoneyLabelW, totalMoneyLabelH);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)setBottomMenuBarModel:(SCBottomMenuBarModel *)bottomMenuBarModel{
    _bottomMenuBarModel = bottomMenuBarModel;
//    bottomMenuBarModel.totalGoodsCount = 3 ;
//    bottomMenuBarModel.totalMoney = 31;
    self.chooseAllButton.selected = bottomMenuBarModel.isAllShopSecect;
    [self.goodsCountBeChoosedButton setTitle:[NSString stringWithFormat:@"去结算(%ld)",bottomMenuBarModel.totalGoodsCount] forState:UIControlStateNormal];
    
        NSString *contentStr = [NSString stringWithFormat:@"合计:¥ %.2lf",bottomMenuBarModel.totalMoney/100.0];
//        NSString *contentStr = nil ;
//    LOG(@"_%@_%d_总价单位是分%d",[self class] , __LINE__,bottomMenuBarModel.totalMoney);
//    if (bottomMenuBarModel.totalMoney%10==0) {
//        
//        if (bottomMenuBarModel.totalMoney%100==0) {
//            contentStr  =[NSString stringWithFormat:@"合计:¥%d",bottomMenuBarModel.totalMoney/100];
//        }else{
//            contentStr  =[NSString stringWithFormat:@"合计:¥%.01lf",bottomMenuBarModel.totalMoney/100.0];
//        }
//    }else{
//        contentStr  =[NSString stringWithFormat:@"合计:¥%.02lf",bottomMenuBarModel.totalMoney/100.0];
//    }
    LOG(@"_%@_%d_总价单位是元%@",[self class] , __LINE__,contentStr);
    
    

    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:contentStr];
    NSString * ss = [contentStr substringFromIndex:3];
    NSRange rr = [contentStr rangeOfString:ss];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:rr];
    [self.totalMoneyLabel setAttributedText:str];
    

}
-(void)chooseAllButtonClick:(UIButton*)sender
{
   
    if ([self.delegate respondsToSelector:@selector(chooseAllButtonClickInMenuBar:chooseAllButton:)]) {
        [self.delegate chooseAllButtonClickInMenuBar:self chooseAllButton:sender];
    }
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"点击全选")
}
-(void)settleMoneyClick:(UIButton*)sender
{
    if ([self.delegate respondsToSelector:@selector(settleMoneyClickInMenuBar:chooseAllButton:)]) {
        [self.delegate settleMoneyClickInMenuBar:self chooseAllButton:sender];
    }

}
@end
