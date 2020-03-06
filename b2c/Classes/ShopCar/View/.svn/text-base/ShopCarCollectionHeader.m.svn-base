//
//  ShopCarCollectionHeader.m
//  b2c
//
//  Created by wangyuanfei on 16/4/18.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "ShopCarCollectionHeader.h"


#import "HCellBaseComposeView.h"//用这个替换按钮,待定义,也可以不定义, 直接在这儿通知


@interface ShopCarCollectionHeader()
@property(nonatomic,weak)UIView * topContainer ;
@property(nonatomic,weak)   UIView * bottomContainer  ;
@property(nonatomic,weak)UIImageView * emptyImageView;
@property(nonatomic,weak)UILabel * emptyTitleLabel ;
@property(nonatomic,weak)UIButton * seeMoreButton ;
@property(nonatomic,weak)UIImageView * bottomImg ;
@end

@implementation ShopCarCollectionHeader
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UIView  * topContainer = [[UIView alloc]init];
//    [UIColor colorwithhe]
        [self addSubview : topContainer];
//        container.backgroundColor = [UIColor colorWithHexString:@"e95513"];//[UIColor yellowColor];
        topContainer.backgroundColor=[UIColor whiteColor];
        self.topContainer = topContainer;
       UIImageView * emptyImageView = [[UIImageView alloc]init];
        emptyImageView.image = [UIImage imageNamed:@"shopCarEmpty"];
        self.emptyImageView = emptyImageView ;
        [self addSubview:self.emptyImageView];
        
        
        UILabel * emptyTitleLabel= [[UILabel alloc]init] ;
        emptyTitleLabel.text = @"购物车很空，快去挑选商品吧！";
        emptyTitleLabel.textColor = SubTextColor;
        self.emptyTitleLabel = emptyTitleLabel;
        emptyTitleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.emptyTitleLabel];
        
        UIButton * seeMoreButton =[[UIButton alloc]init];
        self.seeMoreButton = seeMoreButton;
        [self addSubview:self.seeMoreButton];
        [seeMoreButton setTitle:@"去逛逛" forState:UIControlStateNormal];
        [seeMoreButton addTarget:self action:@selector(seeMore:) forControlEvents:UIControlEventTouchUpInside];
        [seeMoreButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        seeMoreButton.backgroundColor = [UIColor colorWithHexString:@"cccccc"];
        seeMoreButton.layer.borderColor = [UIColor colorWithHexString:@"cccccc"].CGColor;
        seeMoreButton.layer.borderWidth = 1 ;
        seeMoreButton.layer.cornerRadius = 10 ;
        seeMoreButton.layer.masksToBounds=YES;
        seeMoreButton.titleLabel.font = [UIFont systemFontOfSize:14*SCALE];
        
        
        UIView * bottomContainer = [[UIView alloc]init];
        self.bottomContainer = bottomContainer;
        [self addSubview:bottomContainer];
        UIImageView * bottomImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"title_Guess you like"]];
        self.bottomImg = bottomImg;
        bottomImg.contentMode = 1 ;
        [bottomContainer addSubview:bottomImg ];
        
    }
    return self;
}

-(void)seeMore:(UIButton*)sender
{
    if ([self.delegate respondsToSelector:@selector(seeMoreWithHeader:)]) {
        [self.delegate seeMoreWithHeader:self];
    }
//    [[NSNotificationCenter defaultCenter]  postNotificationName:@"FromShopCarEmptyVCToRootVC" object:nil];
//     [[KeyVC shareKeyVC] skipToTabbarItemWithIndex:0];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat bottomContainerH = 30 ;
    CGFloat topContainerH = self.bounds.size.height - bottomContainerH;
    
    
    self.topContainer.frame = CGRectMake(0, 0, self.bounds.size.width, topContainerH);
    self.bottomContainer.frame = CGRectMake(0,topContainerH, self.bounds.size.width, bottomContainerH);
    CGFloat bottomImgH = 14 ;
    CGFloat bottomImgY = (self.bottomContainer.bounds.size.height-bottomImgH)/2;
    self.bottomImg.frame = CGRectMake(0,bottomImgY, self.bottomContainer.bounds.size.width, bottomImgH);
    CGFloat topMargin = 5 ;
    CGFloat imgW = 88;
    CGFloat imgH = 88;
    CGFloat imgX = (self.bounds.size.width-imgW)/2;
    CGFloat imgY = topMargin;
    
    self.emptyImageView.frame = CGRectMake(imgX, imgY, imgW , imgH);
    CGFloat titW = self.bounds.size.width - 30 ;
    CGFloat titH = 30 ;
    CGFloat titX = (self.bounds.size.width-titW)/2;
    CGFloat titY = imgH + topMargin;
    self.emptyTitleLabel.frame = CGRectMake(titX,titY,titW,titH);
    CGFloat seeW= 100 ;
    CGFloat seeH = 28 ;
    CGFloat seeX = (self.bounds.size.width - seeW)/2;
    CGFloat seeY = CGRectGetMaxY(self.emptyTitleLabel.frame)+topMargin
    ;
    self.seeMoreButton.frame = CGRectMake(seeX,seeY,seeW,seeH);

}
@end
