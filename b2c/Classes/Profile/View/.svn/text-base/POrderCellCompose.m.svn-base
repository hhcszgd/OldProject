//
//  POrderCellCompose.m
//  b2c
//
//  Created by wangyuanfei on 4/8/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "POrderCellCompose.h"
#import "POrderCellComposeModel.h"
@interface POrderCellCompose ()
@property(nonatomic,weak)UIImageView * topImageView ;
@property(nonatomic,weak)UILabel * bottomTitleLabel ;
@property(nonatomic,weak)UILabel * cornerCountLabel ;
@property(nonatomic,weak)UIView * container ;
@end
@implementation POrderCellCompose

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
//        self.backgroundColor = randomColor;
        UIView * container = [[UIView alloc]init];
        container.userInteractionEnabled = NO;
        self.container =container;
        [self addSubview:container];
        
        UIImageView * topImageView = [[UIImageView alloc]init];
//        topImageView.userInteractionEnabled = NO;
        topImageView.contentMode = UIViewContentModeScaleAspectFit;
        self.topImageView = topImageView;
        [self.container addSubview:topImageView];
//        topImageView.backgroundColor = randomColor;
        
        
        UILabel * bottomTitleLabel = [[UILabel alloc]init];
        bottomTitleLabel.font = [UIFont systemFontOfSize:13*SCALE];
        self.bottomTitleLabel=bottomTitleLabel;
        [self.container addSubview:bottomTitleLabel];
//        bottomTitleLabel.backgroundColor = randomColor;
#pragma mark 这儿
        UILabel * cornerCountLabel =  [[UILabel alloc]init];
        cornerCountLabel.adjustsFontSizeToFitWidth = YES;
        self.cornerCountLabel = cornerCountLabel;
        cornerCountLabel.font = [UIFont systemFontOfSize:10*SCALE];
        cornerCountLabel.textAlignment = NSTextAlignmentCenter;
        cornerCountLabel.textColor  = [UIColor redColor];
        cornerCountLabel.backgroundColor=[UIColor redColor];
        cornerCountLabel.textColor = [UIColor whiteColor];
        [self.topImageView addSubview:cornerCountLabel];
    }
    return self;
    
}

-(void)layoutSubviews{
    [super layoutSubviews];

    CGFloat txtToImgMargin = 7.5*SCALE;
    
    CGFloat topImageViewW = 30*SCALE;
    CGFloat topImageViewH = topImageViewW;
    CGFloat topImageViewY = 0 ;
    CGFloat topImageViewX = 0 ;//待定
    
    CGSize size = [self.bottomTitleLabel.text stringSizeWithFont:13*SCALE];
    
    CGFloat bottomTitleW = size.width+1;
    CGFloat bottomTitleH = size.height+1;
    CGFloat bottomTitleX = 0 ;//待定
    CGFloat bottomTitleY = topImageViewH + txtToImgMargin ;//待定
    CGFloat containerW  = MAX(topImageViewW, bottomTitleW);
    if (topImageViewW > bottomTitleW) {
        topImageViewX = 0 ;
        bottomTitleX = (topImageViewW-bottomTitleW)*0.5;
        bottomTitleY = topImageViewH + txtToImgMargin;
        
    }else{
        topImageViewX = (bottomTitleW - topImageViewW)*0.5;
        bottomTitleX = 0 ;
        bottomTitleY =topImageViewH + txtToImgMargin;
    }
    
    CGSize numSize= [self.cornerCountLabel.text stringSizeWithFont:12*SCALE];
    CGFloat cornerCountLabelW = 0 ;
    CGFloat cornerCountLabelH = 0 ;
    if (numSize.width>numSize.height) {
        cornerCountLabelW = numSize.width ;
        cornerCountLabelH = numSize.height ;
    }else{
        cornerCountLabelH = numSize.height;
        cornerCountLabelW = cornerCountLabelH;
    
    }
    self.cornerCountLabel.bounds = CGRectMake(0, 0, 20, 20);
    self.cornerCountLabel.layer.cornerRadius = cornerCountLabelH*0.5 ;
    self.cornerCountLabel.layer.borderWidth=1.2;
    self.cornerCountLabel.layer.borderColor=[UIColor redColor].CGColor;
    self.cornerCountLabel.layer.masksToBounds = YES;
    
    self.cornerCountLabel.bounds =CGRectMake(0, 0, cornerCountLabelW   , cornerCountLabelH);
    self.cornerCountLabel.center = CGPointMake(self.topImageView.bounds.size.width-2*SCALE, 2*SCALE);
    
    self.topImageView.frame = CGRectMake(topImageViewX, topImageViewY, topImageViewW, topImageViewH);
    self.bottomTitleLabel.frame = CGRectMake(bottomTitleX, bottomTitleY, bottomTitleW, bottomTitleH);
    self.container.bounds = CGRectMake(0, 0, containerW, topImageViewH+txtToImgMargin+bottomTitleH);
    self.container.center = CGPointMake(self.bounds.size.width*0.5, self.bounds.size.height*0.5);
    
    
}

//-(void)layoutSubviews{
//    [super layoutSubviews];

//    CGFloat txtToImgMargin = 7.5*SCALE;
//    
//    CGFloat topImageViewW = 30*SCALE;
//    CGFloat topImageViewH = topImageViewW;
//    CGFloat topImageViewY = 0 ;
//    CGFloat topImageViewX = 0 ;//待定
//    
//    CGSize size = [self.bottomTitle stringSizeWithFont:13*SCALE];
//    
//    CGFloat bottomTitleW = size.width+1;
//    CGFloat bottomTitleH = size.height+1;
//    CGFloat bottomTitleX = 0 ;//待定
//    CGFloat bottomTitleY = topImageViewH + txtToImgMargin ;//待定
//    CGFloat containerW  = MAX(topImageViewW, bottomTitleW);
//    if (topImageViewW > bottomTitleW) {
//        topImageViewX = 0 ;
//        bottomTitleX = (topImageViewW-bottomTitleW)*0.5;
//        bottomTitleY = topImageViewH + txtToImgMargin;
//        
//    }else{
//        topImageViewX = (bottomTitleW - topImageViewW)*0.5;
//        bottomTitleX = 0 ;
//        bottomTitleY =topImageViewH + txtToImgMargin;
//    }
//    
//    self.topImageView.frame = CGRectMake(topImageViewX, topImageViewY, topImageViewW, topImageViewH);
//    self.bottomTitleLabel.frame = CGRectMake(bottomTitleX, bottomTitleY, bottomTitleW, bottomTitleH);
//    self.containerMark.bounds = CGRectMake(0, 0, 30, 30);
//    self.containerMark.center = self.center;
//    self.containerMark.frame = CGRectMake(10, 10, 49, 49);
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,NSStringFromCGPoint(self.center))
    
    
//}
//-(void)setCornerCount:(NSInteger)cornerCount{
//    _cornerCount = cornerCount;
//    if (cornerCount<0 || self.cornerCount==0) {
//        self.cornerCountLabel.hidden = YES;
//    }else if (cornerCount<10){
//        self.cornerCountLabel.hidden = NO;
//        self.cornerCountLabel.text = [NSString stringWithFormat:@"%ld",cornerCount];
//        
//    }else{
//        self.cornerCountLabel.hidden = NO;
//        self.cornerCountLabel.text = [NSString stringWithFormat:@"9+"];
//    }
//}
//
//-(void)setBottomTitle:(NSString *)bottomTitle{
//    _bottomTitle=bottomTitle;
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,bottomTitle);
//    self.bottomTitleLabel.text = bottomTitle;
//}
//-(void)setTopImage:(UIImage *)topImage {
//    _topImage  = topImage ;
//    self.topImageView.image = topImage;
//
//}
-(void)setOrderComposeModel:(POrderCellComposeModel *)orderComposeModel{
    _orderComposeModel = orderComposeModel;
//    self.topImage = orderComposeModel.topImage;
    self.topImageView.image = orderComposeModel.topImage;

//    self.bottomTitle=orderComposeModel.title;
    self.bottomTitleLabel.text = orderComposeModel.title;
    LOG(@"_%@_%d_9999999999999999999999999999%@",[self class] , __LINE__,orderComposeModel.title);
    
//    self.cornerCount = [orderComposeModel.number integerValue];
    if ([orderComposeModel.number integerValue]<0 || [orderComposeModel.number integerValue]==0) {
        self.cornerCountLabel.hidden = YES;
    }else if ([orderComposeModel.number integerValue]<10){
        self.cornerCountLabel.hidden = NO;
        self.cornerCountLabel.text = [NSString stringWithFormat:@"%ld",[orderComposeModel.number integerValue]];
        
    }else{
        self.cornerCountLabel.hidden = NO;
        self.cornerCountLabel.text = [NSString stringWithFormat:@"9+"];
    }
    
    [self setNeedsLayout];
}
@end
