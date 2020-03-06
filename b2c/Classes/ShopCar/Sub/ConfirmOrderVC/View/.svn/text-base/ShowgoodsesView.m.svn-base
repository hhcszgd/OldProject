//
//  ShowgoodsesView.m
//  b2c
//
//  Created by wangyuanfei on 16/4/29.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "ShowgoodsesView.h"
#import "ConfirmOrderNormalCellModel.h"

@interface ShowgoodsesView ()
@property(nonatomic,weak)UIImageView * arrow ;
@property(nonatomic,weak)UILabel * countLabel ;
@property(nonatomic,weak)UIView * imageContainer ;
@property(nonatomic,weak)UIView * bottomLine ;

@end

@implementation ShowgoodsesView
-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self=[super initWithFrame: frame]) {

        self.backgroundColor = [UIColor whiteColor];
        UIImageView * arrow  = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"jiantou"] ];
        [self addSubview:arrow];
        self.arrow = arrow;
        
        UILabel * countLabel =  [[UILabel alloc]init];
        self.countLabel = countLabel;
        countLabel.font = [UIFont systemFontOfSize:12];
        countLabel.textColor = MainTextColor;
        [self addSubview:countLabel];
        countLabel.textAlignment = NSTextAlignmentRight;
//        countLabel.backgroundColor = randomColor;
        
        UIView * imageContainer = [[UIView alloc]init];
        self.imageContainer = imageContainer;
//        imageContainer.backgroundColor = randomColor;
        [self addSubview:imageContainer];
        
        UIView * bottomLine = [[UIView alloc]init];
        self.bottomLine = bottomLine;
        [self addSubview:bottomLine];
        bottomLine.backgroundColor = BackgroundGray;;
        
        
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
    CGFloat margin = 10 ;
    CGFloat arrowW = 8 ;
    CGFloat arrowH = 14 ;
    CGFloat arrowX = self.bounds.size.width - margin - arrowW  ;
    CGFloat arrowY = (self.bounds.size.height- arrowH )/2  ;
    self.arrow.frame = CGRectMake(arrowX, arrowY, arrowW, arrowH);

    CGFloat countLabelW = 60 ;
    CGFloat countLabelH = 29 ;
    CGFloat countLabelX = CGRectGetMinX(self.arrow.frame) - countLabelW - margin  ;
    CGFloat countLabelY = (self.bounds.size.height - countLabelH)/2  ;
    self.countLabel.frame = CGRectMake(countLabelX, countLabelY, countLabelW, countLabelH);
    
    CGFloat imgMargin = 5 ;
    
    
    NSUInteger goodscount = self.imageContainer.subviews.count;
    
    CGFloat imageContainerW = CGRectGetMinX(self.countLabel.frame) - margin ;
    CGFloat imageContainerH = (imageContainerW - imgMargin*(goodscount-1)) /goodscount ;
    
    if (imageContainerH>self.bounds.size.height-margin*2) {
        imageContainerH =self.bounds.size.height-margin*2;
    }
    
    CGFloat imageContainerX = margin  ;
    CGFloat imageContainerY = (self.bounds.size.height - imageContainerH)/2  ;
    self.imageContainer.frame = CGRectMake(imageContainerX, imageContainerY, imageContainerW, imageContainerH);
    
    for (int i = 0 ; i< self.imageContainer.subviews.count ; i ++ ) {
        UIImageView * subImg = self.imageContainer.subviews[i];
        subImg.frame = CGRectMake((imageContainerH+imgMargin)*i, 0, imageContainerH, imageContainerH);
    }
 
    
    
        self.bottomLine.frame = CGRectMake(margin, self.bounds.size.height-1, self.bounds.size.width - margin*2, 1);
}



-(void)setCellModel:(ConfirmOrderNormalCellModel *)cellModel{
    _cellModel = cellModel;
    if ([cellModel.items isKindOfClass:[NSArray class] ] && cellModel.items.count>0) {
//        self.countLabel.text = [NSString stringWithFormat:@"共%ld件",cellModel.items.count];
        
        self.countLabel.text = [NSString stringWithFormat:@"共%@件",cellModel.total];
       
        for (UIView * sub in self.imageContainer.subviews) {
            [sub removeFromSuperview];
        }
        for (int i = 0 ; i < cellModel.items.count  ; i++ ) {

            //创建子空间添加到容器视图
            if (i<4) {
                NSDictionary * subDict = cellModel.items[i];
                NSString * urlStr = subDict[@"img"];
                UIImageView * subImg = [[UIImageView alloc]init];
//                subImg.backgroundColor = randomColor;
                
                [subImg sd_setImageWithURL:ImageUrlWithString(urlStr) placeholderImage:nil options:SDWebImageCacheMemoryOnly];
                [self.imageContainer addSubview:subImg];
                
            }
        }
    }
    
#pragma mark setNeedsLayout

    [self setNeedsLayout];

}
@end
