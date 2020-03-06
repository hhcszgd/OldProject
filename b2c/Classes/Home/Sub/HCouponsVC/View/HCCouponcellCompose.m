//
//  HCCouponcellCompose.m
//  b2c
//
//  Created by wangyuanfei on 16/5/4.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HCCouponcellCompose.h"

@interface HCCouponcellCompose ()
@property(nonatomic,weak)UIImageView * topImageView ;
@property(nonatomic,weak)UILabel * bottomTitleLabel ;
@property(nonatomic,assign)CGFloat  toBorderMargin ;
@end

@implementation HCCouponcellCompose

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(instancetype)initWithFrame:(CGRect)frame andToBorderMargin:(CGFloat)margin{
    if (self=[super initWithFrame: frame]) {
        self.toBorderMargin = margin;
        
        UIImageView * topImageView = [[UIImageView alloc]init];
        self.topImageView = topImageView;
        [self addSubview:topImageView];
        
        
        UILabel * bottomTitleLabel =[[UILabel alloc]init];
        bottomTitleLabel.textAlignment = NSTextAlignmentCenter;
        self.bottomTitleLabel = bottomTitleLabel;
        [self addSubview:bottomTitleLabel];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat imgX = self.toBorderMargin ;
    CGFloat imgY = self.toBorderMargin ;
    CGFloat imgW = self.bounds.size.width - 2* imgX ;
    CGFloat imgH = imgW ;
    self.topImageView.frame = CGRectMake(imgX, imgY, imgW, imgH);
    
    CGSize titSize = [self.bottomTitle sizeWithFont:self.bottomTitleLabel.font MaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    
    CGFloat titW = self.bounds.size.width ;
    
    CGFloat titH = titSize.height ;
    CGFloat titX = 0 ;
    CGFloat titY = CGRectGetMaxY(self.topImageView.frame) + titH/4 ;
    self.bottomTitleLabel.frame = CGRectMake(titX, titY, titW, titH);

}

-(void)setBottomTitleColor:(UIColor *)bottomTitleColor{
    _bottomTitleColor = bottomTitleColor;
    self.bottomTitleLabel.textColor=bottomTitleColor;
    [self setNeedsLayout];
}
-(void)setBottomTitleFont:(UIFont *)bottomTitleFont{
    _bottomTitleFont = bottomTitleFont;
    self.bottomTitleLabel.font = bottomTitleFont;
    [self setNeedsLayout];

}
-(void)setTopImage:(UIImage *)topImage{
    _topImage = topImage ;
    self.topImageView.image = topImage;
}
-(void)setBottomTitle:(NSString *)bottomTitle{
    _bottomTitle  = bottomTitle ;
    self.bottomTitleLabel.text  =  bottomTitle;
}
@end
