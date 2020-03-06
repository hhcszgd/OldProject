//
//  MainTabBarButton.m
//  b2c
//
//  Created by wangyuanfei on 3/23/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "MainTabBarButton.h"

@interface MainTabBarButton()
@property(nonatomic,weak)UILabel * countLabel ;
@end

@implementation MainTabBarButton

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        //        [self setBackgroundColor:randomColor];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        //        self.titleLabel.textColor = [UIColor blueColor];
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        self.titleLabel.font =[UIFont systemFontOfSize:11];
        
        UILabel * countLabel = [[UILabel alloc]init];
        countLabel.hidden=YES;
        [self addSubview:countLabel];
        countLabel.backgroundColor= [UIColor redColor];
        self.countLabel= countLabel;
        
    }
    return  self;
}
-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat txtToImgMargin =  2;
    CGFloat titX=0 ;
    CGFloat titY = 0 ;
    CGFloat titW = 0 ;
    CGFloat titH = 0 ;
//    CGFloat margin = contentRect.size.height/4;
    titY = 6.5+24+txtToImgMargin ;
    titW = contentRect.size.width;
    CGFloat H = [self.currentTitle stringSizeWithFont:12].height;
    titH = H ;
    return CGRectMake(titX, titY, titW, titH);
}
-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat imgX = 0 ;
    CGFloat imgY = 0;
    CGFloat imgW = 0 ;
    CGFloat imgH = 0 ;
    if (self.tag == 2) {
        imgW = 50;
        imgH = 103/2.0;
        imgY = -39/2.0;
        imgX = (contentRect.size.width - imgW)/2.0;
        return CGRectMake(imgX, imgY, imgW, imgH);
    }
    imgW = 22.0 ;
    imgH = imgW ;
    imgX = (contentRect.size.width-imgW)/2 ;
    imgY = 6.5;
    return CGRectMake(imgX, imgY, imgW, imgH);
}
-(void)setRedPointShow:(BOOL)redPointShow{
    _redPointShow= redPointShow;
    self.countLabel.hidden = !redPointShow;

}
-(void)layoutSubviews{
    [super layoutSubviews];
//    CGFloat countLabelW = 10.0;
//    CGFloat countLabelH = 10.0;
//    CGFloat countLabelCenterX =self.imageView.bounds.size.width-countLabelW*0.5;
//    CGFloat countLabelCenterY = countLabelH*0.5;
//    self.countLabel.layer.cornerRadius= countLabelW*0.5;
//    self.countLabel.layer.masksToBounds = YES;
//    self.countLabel.backgroundColor = [UIColor redColor];
//    self.countLabel.bounds= CGRectMake(0, 0, countLabelW    , countLabelH);
//    self.countLabel.center = CGPointMake(countLabelCenterX  , countLabelCenterY);

    
    CGFloat countLabelW = 6.0;
    CGFloat countLabelH = 6.0;
    CGFloat countLabelCenterX =CGRectGetMaxX(self.imageView.frame)+countLabelW*0.5;
    CGFloat countLabelCenterY = CGRectGetMinY(self.imageView.frame);
    self.countLabel.layer.cornerRadius= countLabelW*0.5;
    self.countLabel.layer.masksToBounds = YES;
    self.countLabel.backgroundColor = [UIColor redColor];
    self.countLabel.bounds= CGRectMake(0, 0, countLabelW    , countLabelH);
    self.countLabel.center = CGPointMake(countLabelCenterX  , countLabelCenterY);
}
- (void)setHighlighted:(BOOL)highlighted
{
    
}
-(void)dealloc{
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"this button dead")
    
}

@end
