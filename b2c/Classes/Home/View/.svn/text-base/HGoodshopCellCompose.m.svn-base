//
//  HGoodshopCellCompose.m
//  b2c
//
//  Created by wangyuanfei on 16/4/16.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HGoodshopCellCompose.h"
#import "HCellComposeModel.h"

@interface HGoodshopCellCompose ()
@property(nonatomic,weak)UIImageView * composeImg ;
@property(nonatomic,weak)UILabel * composeTitle ;

@end
@implementation HGoodshopCellCompose
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        UIImageView * composeImg = [[UIImageView alloc]init];
        self.composeImg = composeImg ;
        [self addSubview:self.composeImg];
        
        UILabel * composeTitle = [[UILabel alloc]init];
        composeTitle.font = [UIFont systemFontOfSize:12*SCALE];
        composeTitle.textAlignment = NSTextAlignmentCenter;
        self.composeTitle= composeTitle;
//        composeTitle.numberOfLines = 2 ;
        [self addSubview:self.composeTitle];
        

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
    CGFloat toScreenMargin = 0;//10*SCALE ;//设计成顶边的
    
    CGFloat imgW = self.bounds.size.width - toScreenMargin*2;
    CGFloat imgH = imgW * 0.5;
    CGFloat imgX = toScreenMargin ;
    CGFloat imgY = toScreenMargin ;
    
//    CGFloat titleX = 0 ;
//    CGFloat titleY = imgH + 5 ;

    CGFloat titleW = self.bounds.size.width;
    CGSize titleSize = [self.composeTitle.text stringSizeWithFont:12*SCALE];
    CGFloat titleH = titleSize.height+1;


    self.composeImg.frame = CGRectMake(imgX, imgY, imgW, imgH);
    self.composeTitle.bounds = CGRectMake(0, 0, titleW, titleH);
    self.composeTitle.center = CGPointMake(self.bounds.size.width/2,(self.bounds.size.height - CGRectGetMaxY(self.composeImg.frame) )/2 + CGRectGetMaxY(self.composeImg.frame));
    
    /** 不要圆环了 */
//    self.composeImg.layer.borderColor = self.composeModel.theamColor.CGColor;
//    self.composeImg.layer.cornerRadius = self.composeImg.bounds.size.width/2;
//    self.composeImg.layer.borderWidth = 2*SCALE ;
//    self.composeImg.layer.masksToBounds=YES;
    
}

-(void)setComposeModel:(HCellComposeModel *)composeModel{
    [super setComposeModel:composeModel];

    [self.composeImg sd_setImageWithURL:ImageUrlWithString(composeModel.imgStr) placeholderImage:nil options:SDWebImageCacheMemoryOnly|SDWebImageRetryFailed|SDWebImageDelayPlaceholder];
    self.composeTitle.text = composeModel.short_name;

    if (composeModel.theamColor) {
        self.composeTitle.textColor = composeModel.theamColor;

    }
    
    
    
}

@end
