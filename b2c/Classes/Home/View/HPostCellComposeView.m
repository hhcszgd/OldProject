//
//  HPostCellComposeView.m
//  b2c
//
//  Created by wangyuanfei on 16/4/15.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HPostCellComposeView.h"
#import "HCellComposeModel.h"
@interface HPostCellComposeView ()
@property(nonatomic,weak)UIImageView * composeImg ;
@property(nonatomic,weak)UILabel * composeTitle ;
@property(nonatomic,weak)UILabel * composePrice ;
@end

@implementation HPostCellComposeView


-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        UIImageView * composeImg = [[UIImageView alloc]init];
        self.composeImg = composeImg ;
        [self addSubview:self.composeImg];
        
        UILabel * composeTitle = [[UILabel alloc]init];
//        composeTitle.lineBreakMode = NSLineBreakByCharWrapping;
        composeTitle.lineBreakMode = NSLineBreakByTruncatingTail;

        
        //        composeTitle.contentMode=UIViewContentModeTopLeft;
        composeTitle.font = [UIFont systemFontOfSize:11*SCALE];
        self.composeTitle= composeTitle;
        composeTitle.numberOfLines = 2 ;
        [self addSubview:self.composeTitle];
        
        UILabel * composePrice = [[UILabel alloc]init];
        composePrice.font = [UIFont systemFontOfSize:11*SCALE];
        self.composePrice = composePrice;
        [self addSubview:composePrice];
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
    CGFloat toScreenMargin = 10*SCALE ;
    
    CGFloat imgW = self.bounds.size.width;
    CGFloat imgH = imgW;
    CGFloat imgX = 0 ;
    CGFloat imgY = 0 ;
    
    CGFloat titleX = toScreenMargin ;
    CGFloat titleY = imgH + 5 ;
    CGFloat titleW = self.bounds.size.width-toScreenMargin*2;
//    CGSize titleSize = [self.composeTitle.text sizeWithFont:[UIFont systemFontOfSize:11+1] MaxSize:CGSizeMake(titleW, self.bounds.size.height-imgW/2)];
    CGSize titleSize = [self.composeTitle.text stringSizeWithFont:12*SCALE];
    CGFloat titleH = 0;

    if (titleSize.width>titleW) {
        titleH = titleSize.height*2;
    }else{
         titleH = titleSize.height;
    }
    
//    CGFloat priceX = titleX;
//    CGFloat priceY
    CGFloat priceW = titleW ;
    CGFloat priceH = titleH ;
    CGFloat centerX = self.bounds.size.width/2 ;
    CGFloat centerY = (self.bounds.size.height - imgH- titleSize.height*2 )/2+ imgH+ titleSize.height*2 ;
    
    self.composeImg.frame = CGRectMake(imgX, imgY, imgW, imgH);
    self.composeTitle.frame = CGRectMake(titleX, titleY, titleW, titleH);
     self.composePrice.bounds = CGRectMake(0, 0, priceW, priceH);
    self.composePrice.center = CGPointMake(centerX, centerY);
}

-(void)setComposeModel:(HCellComposeModel *)composeModel{
    [super setComposeModel:composeModel];
    if (composeModel.isRefreshImageCached) {
        [self.composeImg sd_setImageWithURL:ImageUrlWithString(composeModel.imgStr) placeholderImage:nil options:SDWebImageRefreshCached|SDWebImageRetryFailed];
    } else {
        [self.composeImg sd_setImageWithURL:ImageUrlWithString(composeModel.imgStr) placeholderImage:nil options:SDWebImageRetryFailed];
    }
    
    self.composeTitle.text = composeModel.full_name;
//    NSString * tempPrice  = @"¥ 100";
//    self.composePrice.text = tempPrice;
//    self.composePrice.text = composeModel.price;
    
        self.composePrice.text =  [NSString stringWithFormat:@"¥ %@",composeModel.showPrice];

    
    self.composePrice.textColor = composeModel.theamColor;
    
    if (composeModel.theamtit.length>0) {
        
        NSString *contentStr = [NSString stringWithFormat:@"[%@] %@",composeModel.theamtit,composeModel.short_name];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:contentStr];
        NSRange rr = [contentStr rangeOfString:[NSString stringWithFormat:@"[%@]",composeModel.theamtit]];
//        [str addAttribute:NSForegroundColorAttributeName value:composeModel.theamColor  range:NSMakeRange(0, self.theamTitle.length)];

        [str addAttribute:NSForegroundColorAttributeName value:composeModel.theamColor  range:rr];
        self.composeTitle.attributedText=str;
    }
    
    
    
}


@end
