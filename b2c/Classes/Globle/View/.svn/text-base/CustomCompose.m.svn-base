//
//  CustomCompose.m
//  b2c
//
//  Created by wangyuanfei on 4/8/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "CustomCompose.h"

@interface CustomCompose ()
@property(nonatomic,weak)UIImageView * topImageView ;
@property(nonatomic,weak)UILabel * bottomTitleLabel ;
@property(nonatomic,weak)UILabel * cornerCountLabel ;
@end

@implementation CustomCompose

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        
    }
    return self;

}
-(UIImageView * )topImageView{
    if(_topImageView==nil){
        UIImageView * topImageView = [[UIImageView alloc]init];
        _topImageView = topImageView;
        [self addSubview:topImageView];
    }
    return _topImageView;
}
-(UILabel * )bottomTitleLabel{
    if(_bottomTitleLabel==nil){
        UILabel * bottomTitleLabel = [[UILabel alloc]init];
        _bottomTitleLabel=bottomTitleLabel;
        [self addSubview:bottomTitleLabel];
    }
    return _bottomTitleLabel;
}
-(UILabel * )cornerCountLabel{
    if(_cornerCountLabel==nil){
        UILabel * cornerCountLabel =  [[UILabel alloc]init];
        _cornerCountLabel = cornerCountLabel;
        [self addSubview:cornerCountLabel];
    }
    return _cornerCountLabel;
}
-(void)layoutSubviews{
    [super layoutSubviews];

//    CGFloat topImageViewW = 30*SCALE;
//    CGFloat topImageViewH = topImageViewW;
//    CGFloat bottomTitle = 0;

}

-(void)setCornerCount:(NSInteger)cornerCount{
    _cornerCount = cornerCount;
    if (cornerCount<0 || self.cornerCount==0) {
        self.cornerCountLabel.hidden = YES;
    }else if (cornerCount<10){
        self.cornerCountLabel.hidden = NO;
        self.cornerCountLabel.text = [NSString stringWithFormat:@"%ld",cornerCount];
        
    }else{
        self.cornerCountLabel.hidden = NO;
        self.cornerCountLabel.text = [NSString stringWithFormat:@"9+"];
    }
}
@end
