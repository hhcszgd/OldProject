//
//  IHHotMarketCellCompose.m
//  b2c
//
//  Created by wangyuanfei on 16/5/5.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "IHHotMarketCellCompose.h"
#import "HCellComposeModel.h"
@interface IHHotMarketCellCompose ()

@property(nonatomic,weak)UIImageView* backImageView ;
//@property(nonatomic,weak)UILabel * titleLabel  ;

@end

@implementation IHHotMarketCellCompose

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame{
    if (self= [super initWithFrame: frame]) {
        UIImageView * backImageView = [[UIImageView alloc]init];
        self.backImageView = backImageView;
        [self addSubview:backImageView];
        
        
//        UILabel * titleLabel =[[UILabel alloc]init];
//        titleLabel.textAlignment = NSTextAlignmentRight;
//        self.titleLabel = titleLabel;
//        [self addSubview:titleLabel];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    //    CGFloat imgX = self.toBorderMargin ;
    //    CGFloat imgY = self.toBorderMargin ;
//    CGFloat imgX = 0 ;
//    CGFloat imgY = 0 ;
//    CGFloat imgW = self.bounds.size.width - 2* imgX ;
//    CGFloat imgH = imgW ;
//    CGRectMake(imgX, imgY, imgW, imgH);
    self.backImageView.frame = self.bounds;
    
//    CGSize titSize = [self.topTitle sizeWithFont:self.titleLabel.font MaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
//    CGFloat txtToBorderMargin = self.bounds.size.width/9.3;
//    CGFloat titW = self.bounds.size.width -  txtToBorderMargin * 2  ;
//    self.titleLabel.font = [UIFont systemFontOfSize:self.bounds.size.width/25+9];
//    CGFloat titH = titSize.height ;
//    CGFloat titX = txtToBorderMargin ;
//    CGFloat titY = txtToBorderMargin  ;
//    self.titleLabel.frame = CGRectMake(titX, titY, titW, titH);
    
}

//-(void)setTitleColor:(UIColor *)titleColor{
//    _titleColor = titleColor ;
//    self.titleLabel.textColor=titleColor;;
//    [self setNeedsLayout];
//
//}
//-(void)setTitleFont:(UIFont *)titleFont{
//    _titleFont = titleFont ;
//    self.titleLabel.font = titleFont;
//    [self setNeedsLayout];
//}

-(void)setBackImage:(UIImage *)backImage{
    _backImage  = backImage;
    self.backImageView.image = backImage;
}
//-(void)setTopTitle:(NSString *)topTitle{
//    _topTitle   =  topTitle;
//    self.titleLabel.text  =  topTitle;
//
//}

-(void)setComposeModel:(HCellComposeModel *)composeModel{
    [super setComposeModel:composeModel];
    self.topTitle   =    composeModel.classify_name;
    [self.backImageView sd_setImageWithURL:ImageUrlWithString(composeModel.imgStr) placeholderImage:nil options:SDWebImageCacheMemoryOnly];
    
}

@end
