//
//  ArrowToRight.m
//  b2c
//
//  Created by wangyuanfei on 4/7/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "ArrowToRight.h"

@interface ArrowToRight()

@property(nonatomic,weak)UIImageView * arrowImg ;

@end


@implementation ArrowToRight

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        UIImageView * img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"jiantou"]];
        self.arrowImg = img;
        [self addSubview:img];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGRect newSelfFrame = CGRectMake(self.frame.origin.x, self.frame.origin.y, (7+6+10)*SCALE, self.frame.size.height);
    self.frame = newSelfFrame;
    CGFloat imgW = 6*SCALE;
    CGFloat imgH = 11*SCALE;
    CGFloat imgX = 7;
    CGFloat imgY = (self.bounds.size.height - imgH)*0.5;
    
    self.arrowImg.frame = CGRectMake(imgX,imgY,imgW,imgH);
}

@end
