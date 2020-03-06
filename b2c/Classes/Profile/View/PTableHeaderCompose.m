//
//  PTableHeaderCompose.m
//  b2c
//
//  Created by wangyuanfei on 4/9/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "PTableHeaderCompose.h"

@interface  PTableHeaderCompose()
@property(nonatomic,weak)UILabel * bottomTitleLabel ;
@property(nonatomic,weak)UILabel * topTitleLabel ;
//@property(nonatomic,weak)UIImageView * topImageView ;
@property(nonatomic,assign)PTableHeaderComposeStyle  style ;
@property(nonatomic,weak)UIView * container ;


@end

@implementation PTableHeaderCompose

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-initWithStyle:(PTableHeaderComposeStyle)style{
    self.style =style;
    if (self=[super init]) {
        UIView * container = [[UIView alloc]init];
        container.userInteractionEnabled=NO;
        self.container = container;
        [self addSubview:container];
        
        if (style==PTableHeaderComposeImageStyle) {
            UIImageView * topImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_footprint"]];
            topImageView.contentMode = UIViewContentModeScaleAspectFit;
            self.topImageView = topImageView;
//            topImageView.contentMode=     UIViewContentModeCenter ;

            [self.container addSubview:topImageView];
        }else if (style == PTableHeaderComposeNumberStyle){
            UILabel * topTitleLabel =  [[UILabel alloc]init];
            self.topTitleLabel = topTitleLabel;
            topTitleLabel.textAlignment = NSTextAlignmentCenter;
            topTitleLabel.font = [UIFont boldSystemFontOfSize:12*SCALE];
            topTitleLabel.textColor = [UIColor whiteColor];
            [self.container addSubview:topTitleLabel];
        }
        UILabel * bottomTitleLabel = [[UILabel alloc]init];
        bottomTitleLabel.textAlignment = NSTextAlignmentCenter;
        bottomTitleLabel.font = [UIFont boldSystemFontOfSize:12*SCALE];
        bottomTitleLabel.textColor = [UIColor whiteColor];
        [self.container addSubview:bottomTitleLabel];
        self.bottomTitleLabel = bottomTitleLabel;
    }
    return self;
}

-(void)setComposeCount:(NSInteger)composeCount{
    _composeCount = composeCount>0 ? composeCount : 0 ;
    self.topTitleLabel.text = [NSString stringWithFormat:@"%ld",_composeCount];
}
-(void)setComposeTitle:(NSString *)composeTitle{
    _composeTitle = composeTitle;
    self.bottomTitleLabel.text = composeTitle;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat topComposeH = 18* SCALE ;
    CGFloat topComposeW = self.bounds.size.width ;
    
    CGFloat bottomComposeW = self.bounds.size.width ;
    CGSize bottomTitleSize = [self.composeTitle stringSizeWithFont:12*SCALE];
    CGFloat bottomComposeH = bottomTitleSize.height+1 ;
    
    CGFloat topToBottomMargin = 4 ;
    CGFloat containerW = self.bounds.size.width;
    CGFloat containerH = topComposeH + topToBottomMargin + bottomComposeH;
    if (self.style == PTableHeaderComposeNumberStyle) {//布局数量和文字
        self.topTitleLabel.frame =CGRectMake(0, 0, topComposeW, topComposeH);
//        topComposeW = self.bounds.size.width ;
    }else if (self.style == PTableHeaderComposeImageStyle){//布局图片和文字
        topComposeW = self.topImageView.image.size.width ;
         self.topImageView.frame =CGRectMake((containerW - topComposeW)*0.5, 0, topComposeW, topComposeH);
    }
    self.bottomTitleLabel.frame = CGRectMake(0, topComposeH+topToBottomMargin, bottomComposeW, bottomComposeH);
    self.container.bounds = CGRectMake(0, 0, containerW, containerH);
    self.container.center = CGPointMake(self.bounds.size.width*0.5, self.bounds.size.height*0.5);

}
//-(UILabel * )topTitleLabel{
//    if(_topTitleLabel==nil){
//        UILabel * topTitleLabel =  [[UILabel alloc]init];
//        _topTitleLabel = topTitleLabel;
//        [self addSubview:topTitleLabel];
//    }
//    return _topTitleLabel;
//}
//-(UIImageView * )topImageView{
//    if(_topImageView==nil){
//        UIImageView * topImageView = [[UIImageView alloc]init];
//        _topImageView = topImageView;
//        [self addSubview:topImageView];
//    }
//    return _topImageView;
//}
@end
