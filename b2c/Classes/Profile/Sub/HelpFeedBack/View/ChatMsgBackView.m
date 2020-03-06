//
//  ChatMsgBackView.m
//  b2c
//
//  Created by wangyuanfei on 6/28/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "ChatMsgBackView.h"

@interface ChatMsgBackView ()
@property(nonatomic,weak)UIImageView * arrowImgView ;
@property(nonatomic,weak)UILabel * textLabel ;

@end

@implementation ChatMsgBackView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.layer.cornerRadius = 5 ;
        self.layer.masksToBounds = YES;
        UIImageView * arrowImgView =  [[UIImageView alloc]init];
        self.arrowImgView  = arrowImgView;
        [self addSubview:arrowImgView];
        
        
        UILabel * textLabel = [[UILabel alloc]init];
        textLabel.numberOfLines = 0 ;
        self.textLabel = textLabel ;
        [self addSubview:textLabel];
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
//-(void)drawRect:(CGRect)rect
//{
//    //首先画一个形状图
//    UIImage *imageD = [UIImage imageNamed:@"yiluliaodp"];
//    [imageD drawInRect:rect];
//    
//    //把原图换到目标图上
//    UIImage *imageS = [UIImage imageNamed:@"zhekouqu"];
//    [imageS drawInRect:rect blendMode:kCGBlendModeSourceIn alpha:1.0];
//}
@end
