//
//  SCShopHeaderView.m
//  b2c
//
//  Created by wangyuanfei on 16/4/19.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "SCShopHeaderView.h"

#import "SVCShop.h"

@interface SCShopHeaderView ()
/** 选择店铺按钮 */
@property(nonatomic,weak)UIButton * chooseGoodsButton ;
/** 选择店铺按钮的放大点击区域 */
@property(nonatomic,weak)UIButton * chooseButtonPlus ;
@property(nonatomic,weak)UIButton * shopNameButton ;
@property(nonatomic,weak)UIButton * ticketButton ;
@property(nonatomic,assign)NSInteger  section ;

@end

@implementation SCShopHeaderView
-(instancetype)initWithTableView:(UITableView * ) tableView forSection:(NSInteger)section{
    if (self=[super init]) {
        self.section=section;
        self.backgroundColor = [UIColor whiteColor];
        UIButton * chooseGoodsButton = [[UIButton alloc]init];
        [chooseGoodsButton addTarget:self action:@selector(chooseGoodsButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [chooseGoodsButton setImage:[UIImage imageNamed:@"btn_round_nor"] forState:UIControlStateNormal];
        [chooseGoodsButton setImage:[UIImage imageNamed:@"btn_round_sel"] forState:UIControlStateSelected];
//        chooseGoodsButton.backgroundColor = randomColor;
        self.chooseGoodsButton = chooseGoodsButton;
        [self addSubview:self.chooseGoodsButton];
        
        /** 选择店铺按钮的放大点击区域 */
        UIButton * chooseButtonPlus = [[UIButton alloc]init];
        self.chooseButtonPlus = chooseButtonPlus;
        [self addSubview:chooseButtonPlus];
//        chooseButtonPlus.backgroundColor = randomColor;
        [chooseButtonPlus addTarget:self action:@selector(chooseGoodsButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        UIButton * shopNameButton =[[UIButton alloc]init];
        [shopNameButton addTarget:self action:@selector(shopNameButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        self.shopNameButton = shopNameButton;
        [shopNameButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [shopNameButton setTitleColor:MainTextColor forState:UIControlStateNormal];
        shopNameButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self addSubview:shopNameButton];

        
    }
    return self;
}
-(UIButton * )ticketButton{
    if(_ticketButton==nil){
        UIButton * ticketButton =  [[UIButton alloc]init];
        [ticketButton addTarget:self action:@selector(ticketButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        _ticketButton = ticketButton;
        [ticketButton setTitle:@"领券" forState:UIControlStateNormal];
        [ticketButton setTitleColor:MainTextColor forState: UIControlStateNormal];
        [ticketButton.titleLabel setFont:[UIFont systemFontOfSize:14*SCALE]];
        [self addSubview:ticketButton];
    }
    return _ticketButton;
}
-(void)ticketButtonClick:(UIButton*)sender
{
    /**
      -(void)shoppingCell:(ShopCarBaseComposeView * ) header andBtn:(UIButton * )btn andSection:(NSInteger)section;
     */
    if ([self.SCShopHeaderHelegate respondsToSelector:@selector(ticketButtonClickInSCShopHeaderView:section:)]) {
        [self.SCShopHeaderHelegate ticketButtonClickInSCShopHeaderView:self section:self.section];
    }
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"点击领券")//传递按钮和cell(含模型)
}
-(void)chooseGoodsButtonClick:(UIButton*)sender//传递按钮和cell(含模型)
{
    if ([self.SCShopHeaderHelegate respondsToSelector:@selector(chooseShopInSCShopHeaderView:section:)]) {
        [self.SCShopHeaderHelegate chooseShopInSCShopHeaderView:self section:self.section];
    }

}
-(void)shopNameButtonClick:(UIButton*)sender
{
    if ([self.SCShopHeaderHelegate respondsToSelector:@selector(shopNameButtonClickInSCShopHeaderView:section:)]) {
        [self.SCShopHeaderHelegate shopNameButtonClickInSCShopHeaderView:self section:self.section];
    }
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"点击进入店铺")//传递按钮和cell(含模型)
}
-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat leftMargin = 10 ;
    CGFloat chooseToShopName = 11 ;

    
    CGFloat chooseGoodsButtonW = 16 ;
    CGFloat chooseGoodsButtonH =chooseGoodsButtonW;
    CGFloat chooseGoodsButtonX = leftMargin;
    CGFloat chooseGoodsButtonY = (self.bounds.size.height - chooseGoodsButtonH)/2;
    self.chooseGoodsButton.frame = CGRectMake(chooseGoodsButtonX, chooseGoodsButtonY, chooseGoodsButtonW, chooseGoodsButtonH);
    
    CGPoint chooseButtonPlusCenter  = [self.chooseGoodsButton convertPoint:CGPointMake(chooseGoodsButtonW/2, chooseGoodsButtonH/2) toView:self];
    self.chooseButtonPlus.bounds = CGRectMake(0, 0, chooseGoodsButtonW*2 ,chooseGoodsButtonH*2);
    self.chooseButtonPlus.center = chooseButtonPlusCenter;
    
    
    
    
    CGSize ticketSize = [self.ticketButton.currentTitle sizeWithFont:self.ticketButton.titleLabel.font MaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    
    CGFloat rightMargin = 10 ;
    CGFloat nameToTicketMargin  = 10 ;
    CGFloat ticketY = 0 ;
    CGFloat ticketX = self.bounds.size.width - ticketSize.width - rightMargin;
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"此店铺有优惠券")
    if (self.shopModel.coupons.count>0) {
        self.ticketButton.hidden=NO;
        self.ticketButton.frame = CGRectMake(ticketX, ticketY, ticketSize.width, self.bounds.size.height);
    }else{
        self.ticketButton.hidden=YES;
    }
    
    CGFloat shopNameX = CGRectGetMaxX(self.chooseGoodsButton.frame)+ chooseToShopName;
    CGFloat shopNameY = 0  ;
    CGFloat shopNameW =ticketX - shopNameX -  nameToTicketMargin  ;
    CGFloat shopNameH = self.bounds.size.height ;
    self.shopNameButton.frame = CGRectMake(shopNameX, shopNameY, shopNameW, shopNameH);

}

-(void)setShopModel:(SVCShop *)shopModel{
    _shopModel = shopModel;
    [self.shopNameButton setTitle: shopModel.name forState:UIControlStateNormal];
    self.chooseGoodsButton.selected = shopModel.shopSelect;
    
}
@end
