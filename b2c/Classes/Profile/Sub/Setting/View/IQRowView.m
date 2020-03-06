//
//  IQRowView.m
//  b2c
//
//  Created by wangyuanfei on 6/15/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "IQRowView.h"

@interface IQRowView ()

@property(nonatomic,weak)UILabel * tipsLabel ;
@property(nonatomic,weak)UIImageView * selectedImg ;
@property(nonatomic,weak)UIView * bottomLine ;

@end

@implementation IQRowView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor   =   [UIColor whiteColor];
        
        UILabel * tipsLabel = [[UILabel alloc]init];
        self.tipsLabel = tipsLabel;
        [self addSubview:tipsLabel];
        tipsLabel.textColor  =  MainTextColor;
        tipsLabel.font = [UIFont systemFontOfSize:14];
        
        
        UIImageView * selectedImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"collect_item_selected"]];
        self.selectedImg = selectedImg;
        [self addSubview:selectedImg];
        
        UIView * bottomLine = [[UIView alloc]init];
        self.bottomLine =  bottomLine ;
        [self addSubview:bottomLine];
        bottomLine.backgroundColor = BackgroundGray;
        
        
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat bottomLineH = 2 ;
    CGFloat margin = 10 ;
    
    CGFloat bottomLineX = 0 ;
    CGFloat bottomLineW = self.bounds.size.width;
    CGFloat bottomLineY = self.bounds.size.height - bottomLineH;
    
    self.bottomLine.frame = CGRectMake(bottomLineX, bottomLineY, bottomLineW, bottomLineH);
    
    CGFloat imgW = 28 ;
    CGFloat imgH = 28 ;
    CGFloat imgX = self.bounds.size.width-margin - imgW;
    CGFloat imgY = (self.bounds.size.height-imgH - bottomLineH)/2;
    
    CGFloat tipsLabelX = margin;
    CGFloat tipsLabelY = 0 ;
    CGFloat tipsLabelW = imgX - margin;
    CGFloat tipsLabelH = self.bounds.size.height - bottomLineH;
    
    self.tipsLabel.frame = CGRectMake(tipsLabelX, tipsLabelY, tipsLabelW, tipsLabelH);
    self.selectedImg.frame = CGRectMake(imgX, imgY, imgW, imgH);
    
}


-(void)setTipsStr:(NSString *)tipsStr{
    _tipsStr=tipsStr.copy;
    self.tipsLabel.text = _tipsStr;
}
-(void)setIsSelect:(BOOL)isSelect{
    _isSelect = isSelect;
    self.selectedImg.hidden = !_isSelect;

}

@end
