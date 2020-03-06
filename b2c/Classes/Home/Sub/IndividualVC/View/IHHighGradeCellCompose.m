//
//  IHHighGradeCellCompose.m
//  b2c
//
//  Created by wangyuanfei on 16/5/5.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "IHHighGradeCellCompose.h"
#import "HCellComposeModel.h"
@interface IHHighGradeCellCompose ()
@property(nonatomic,weak)UIImageView* topImageView ;
@property(nonatomic,weak)UILabel * bottomTitleLabel  ;

@end


@implementation IHHighGradeCellCompose

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame{
    if (self= [super initWithFrame: frame]) {
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
    
//    CGFloat imgX = self.toBorderMargin ;
//    CGFloat imgY = self.toBorderMargin ;
    CGFloat imgX = 0 ;
    CGFloat imgY = 0 ;
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


-(void)setComposeModel:(HCellComposeModel *)composeModel{
    [super setComposeModel:composeModel];
//    if ([composeModel.actionKey isEqualToString:@"highGrade"]) {
        composeModel.actionKey = @"HShopVC";//服务器返回字段给的不全,没有actionKey , 就写死吧 -_-!
//    }
    composeModel.keyParamete = @{@"paramete":composeModel.ID};
    if (composeModel.short_name.length>0) {
        self.bottomTitle = composeModel.short_name;
    }else if (composeModel.full_name.length>0){
        self.bottomTitle   =    composeModel.full_name;
    } else{
        self.bottomTitle = @"推荐店铺";
    }
    [self.topImageView sd_setImageWithURL:ImageUrlWithString(composeModel.imgStr) placeholderImage:nil options:SDWebImageCacheMemoryOnly];
    
}
@end
