//
//  CellTitleView.m
//  b2c
//
//  Created by wangyuanfei on 16/5/5.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "CellTitleView.h"

@interface CellTitleView ()

@property(nonatomic,weak )UILabel   *  titleStrLabel ;
@property(nonatomic,weak)UIView * colorView ;

@end

@implementation CellTitleView
//
//-(instancetype)initWithStyle:(CellTitleViewType)style {
//    if (self=[super init]) {
//        self.currentType = style;
//        UIImageView * backImageView   =  [[UIImageView alloc]init];
//        self.backImageView
//    }
//    return self;
//}


 
 

-(UILabel * )titleStrLabel{
    if(_titleStrLabel==nil){
        UILabel * titleStrLabel = [[UILabel alloc]init];
        _titleStrLabel = titleStrLabel;
        _titleStrLabel.font = [UIFont boldSystemFontOfSize:15*SCALE];
        [self addSubview:titleStrLabel];
    }
    return _titleStrLabel;
}

 -(UIView * )colorView{
     
     if(_colorView==nil){
         UIView * colorView = [[UIView alloc]init];
         [self addSubview:colorView];
//        colorView.backgroundColor=[UIColor colorWithHexString:@"2b912b"];
         _colorView = colorView;
     }
     return _colorView;
 }

-(void)setTitleStrColor:(UIColor *)titleStrColor{
    _titleStrColor=titleStrColor;
    self.titleStrLabel.textColor=titleStrColor;
    self.colorView.backgroundColor = titleStrColor;
}

-(void)setTitleStr:(NSString *)titleStr{
    _titleStr = titleStr.copy;
    self.titleStrLabel.text = _titleStr;
}



-(void)layoutSubviews{
    CGFloat txtToImgMargin = 10*SCALE ;
    //左侧布局
    //    CGFloat leftToScreenMargin = 10*SCALE ;
    CGFloat leftImageX = 0;
    CGFloat leftImageY = 0 ;
    CGFloat leftImageW = 4.5;
    CGFloat leftImageH = self.bounds.size.height;
    self.colorView.frame = CGRectMake(leftImageX, leftImageY, leftImageW, leftImageH);
    
    CGFloat leftTitleX = CGRectGetMaxX(self.colorView.frame)+txtToImgMargin;
    CGFloat leftTitleY = 0 ;
    CGFloat leftTitleW = self.bounds.size.width*0.5;
    CGFloat leftTitleH = self.bounds.size.height;
    self.titleStrLabel.frame = CGRectMake(leftTitleX, leftTitleY, leftTitleW, leftTitleH);
   }
@end
