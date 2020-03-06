//
//  SCShopFooterView.m
//  b2c
//
//  Created by wangyuanfei on 16/4/19.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "SCShopFooterView.h"

@interface SCShopFooterView ()
@property(nonatomic,weak)UIView * topContainer ;
@property(nonatomic,weak)UILabel * activityLogo ;
@property(nonatomic,weak)UILabel * activityDescrip ;
@property(nonatomic,weak)UIImageView * arrowImg ;

@end


@implementation SCShopFooterView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        
        UIView * topContainer = [[UIView alloc]init];
        topContainer.userInteractionEnabled = NO;
        topContainer.backgroundColor=[UIColor whiteColor];
        self.topContainer=topContainer;
        [self addSubview:topContainer];
        
        UILabel * activityLogo = [[UILabel alloc]init];
        self.activityLogo = activityLogo;
        [self.topContainer addSubview:self.activityLogo];
//        activityLogo.backgroundColor = randomColor;
        activityLogo.layer.borderWidth=1 ;
        activityLogo.layer.borderColor = THEMECOLOR.CGColor;
        activityLogo.layer.cornerRadius = 5 ;
        activityLogo.layer.masksToBounds = YES;
        activityLogo.font = [UIFont systemFontOfSize: 9.5];
        activityLogo.text = @"满减" ;
        activityLogo.textColor = THEMECOLOR;
        activityLogo.textAlignment = NSTextAlignmentCenter;
        
        UILabel * activityDescrip =[[UILabel alloc]init];
        self.activityDescrip = activityDescrip;
        [self.topContainer addSubview:activityDescrip];
//        activityDescrip.backgroundColor = randomColor;
        activityDescrip.text = @"满100 减100 多买多减 不买也减 ";
        activityDescrip.textColor = MainTextColor;
        activityDescrip.font = [UIFont systemFontOfSize:12];
        UIImageView * img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"jiantou"]];
        self.arrowImg = img;
        [self.topContainer addSubview:img];
        
        
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat toRightScreenMargin = 10 ;
    CGFloat toLeftScreenMargin = 31 * SCALE ;
//    CGFloat bottomMargin = 10 ;
    self.topContainer.frame = CGRectMake(0, 0, self.bounds.size.width, 38*SCALE);
    
    
    
    
    CGFloat imgW = 6*SCALE;
    CGFloat imgH = 11*SCALE;
    CGFloat imgX = self.topContainer.bounds.size.width - toRightScreenMargin - imgW;
    CGFloat imgY = (self.topContainer.bounds.size.height - imgH)*0.5;
    
    self.arrowImg.frame = CGRectMake(imgX,imgY,imgW,imgH);
    
    CGFloat activityLogoW = 34*SCALE;
    CGFloat activityLogoH = 14*SCALE;
    CGFloat activityLogoX = toLeftScreenMargin;
    CGFloat activityLogoY = (self.topContainer.bounds.size.height - activityLogoH)/2;
    
    self.activityLogo.frame = CGRectMake(activityLogoX,activityLogoY,activityLogoW,activityLogoH);
    CGFloat logoToDescrip = 5 ;
    CGFloat descripToArrow = 10 ;
    
    
    CGFloat activityDescripW = CGRectGetMinX(self.arrowImg.frame) - CGRectGetMaxX(self.activityLogo.frame) - logoToDescrip - descripToArrow ;
    CGFloat activityDescripH = self.topContainer.bounds.size.height;
    CGFloat activityDescripX =CGRectGetMaxX(self.activityLogo.frame) + logoToDescrip;
    CGFloat activityDescripY = 0;
    
    self.activityDescrip.frame = CGRectMake(activityDescripX,activityDescripY,activityDescripW,activityDescripH);
    
    


}
@end
