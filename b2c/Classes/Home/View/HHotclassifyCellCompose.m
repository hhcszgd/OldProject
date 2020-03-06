//
//  HHotclassifyCellCompose.m
//  b2c
//
//  Created by wangyuanfei on 16/4/16.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HHotclassifyCellCompose.h"
#import "HCellComposeModel.h"
@interface HHotclassifyCellCompose ()
@property(nonatomic,weak)UIImageView * composeImg ;
/**
 classify_name = 冰箱;
	subtitle = 99元限量秒杀;
 */
//@property(nonatomic,weak)UILabel * classify_name ;//不要标题了
//@property(nonatomic,weak)UILabel * subtitle ;//不要标题了

@end

@implementation HHotclassifyCellCompose
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        UIImageView * composeImg = [[UIImageView alloc]init];
        self.composeImg = composeImg ;
        [self addSubview:self.composeImg];
        
        UILabel * classify_name = [[UILabel alloc]init];
        classify_name.font = [UIFont systemFontOfSize:14*SCALE];
        classify_name.textColor = MainTextColor ;
        
//        self.classify_name= classify_name;
////        classify_name.numberOfLines = 2 ;
//        [self addSubview:self.classify_name];
        
//        UILabel * subtitle = [[UILabel alloc]init];
//        subtitle.textColor = SubTextColor ;
//        subtitle.font = [UIFont systemFontOfSize:12*SCALE];
//        self.subtitle = subtitle;
//        [self addSubview:subtitle];
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
//    CGFloat toScreenMargin = 10*SCALE ;
    CGFloat imgW = self.bounds.size.width;
    CGFloat imgH = imgW;
    CGFloat imgX = 0 ;
    CGFloat imgY = self.bounds.size.height-imgW ;
    self.composeImg.frame = CGRectMake(imgX, imgY, imgW, imgH);
    
//    CGFloat leftHeight = imgY;//剩余的高度
//    CGFloat txtW = self.bounds.size.width-toScreenMargin;
    
//    CGFloat classifyW = txtW;
//    CGFloat classifyH = leftHeight/2;
//    CGFloat classifyX = toScreenMargin ;
//    CGFloat classifyY = toScreenMargin/2 ;
//    self.classify_name.frame = CGRectMake(classifyX, classifyY, classifyW,classifyH);


//    CGFloat subtitleX = classifyX ;
//    CGFloat subtitleY = CGRectGetMaxY(self.classify_name.frame) ;
//    [self.subtitle sizeToFit];
//    CGSize subtitleSize = [self.subtitle.text stringSizeWithFont:12*SCALE];
//
//    self.subtitle.frame = CGRectMake(subtitleX, subtitleY, subtitleSize.width, subtitleSize.height);
}

-(void)setComposeModel:(HCellComposeModel *)composeModel{
    [super setComposeModel:composeModel];
//    [self.composeImg sd_setImageWithURL:[NSURL URLWithString: composeModel.imgStr] placeholderImage:nil options:SDWebImageCacheMemoryOnly|SDWebImageRetryFailed|SDWebImageDelayPlaceholder];

    if ([composeModel.imgStr hasPrefix:@"http"]) {
               [self.composeImg sd_setImageWithURL: [NSURL URLWithString: composeModel.imgStr] placeholderImage:nil options:SDWebImageCacheMemoryOnly|SDWebImageRetryFailed|SDWebImageDelayPlaceholder];
    }else{
    
        [self.composeImg sd_setImageWithURL:ImageUrlWithString(composeModel.imgStr) placeholderImage:nil options:SDWebImageCacheMemoryOnly|SDWebImageRetryFailed|SDWebImageDelayPlaceholder];
    }
    
//    self.classify_name.text = composeModel.classify_name;
//    self.subtitle.text = composeModel.subtitle;
//    self.subtitle.textColor = composeModel.theamColor;
//    
//    if (composeModel.theamtit.length>0) {
//        
//        NSString *contentStr = [NSString stringWithFormat:@"[%@] %@",composeModel.theamtit,composeModel.full_name];
//        NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:contentStr];
//        NSRange rr = [contentStr rangeOfString:[NSString stringWithFormat:@"[%@]",composeModel.theamtit]];
//        //        [str addAttribute:NSForegroundColorAttributeName value:composeModel.theamColor  range:NSMakeRange(0, self.theamTitle.length)];
//        
//        [str addAttribute:NSForegroundColorAttributeName value:composeModel.theamColor  range:rr];
//        self.classify_name.attributedText=str;
//    }
    
    
    
}

@end
