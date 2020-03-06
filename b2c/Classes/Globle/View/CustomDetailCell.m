//
//  CustomDetailCell.m
//  b2c
//
//  Created by wangyuanfei on 4/8/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
/**
    子控件离左屏幕边缘  和   右屏幕边缘都为10   ; 
    文字和图片的间距都为 5 ;
 */

#import "CustomDetailCell.h"
#import "CustomDetailCellModel.h"
@interface CustomDetailCell()
@property(nonatomic,weak)UIImageView * leftImageView ;
@property(nonatomic,weak)UILabel * leftTitleLabel ;
@property(nonatomic,weak)UILabel * rightDetailTitleLabel ;
@property(nonatomic,weak)UIImageView * rightImageView ;
@property(nonatomic,weak)UIImageView * arrowToRight ;
@property(nonatomic,weak)UIView * bottomLine ;


@end


@implementation CustomDetailCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        //        UIImageView * leftImageView = [[UIImageView alloc]init];
        //        self.leftImageView = leftImageView;
        //        [self addSubview:self.leftImageView];
        //        self.leftImageView.backgroundColor=randomColor;
        
        //        UILabel * leftTitleLabel = [[UILabel alloc]init];
        //        self.leftTitleLabel = leftTitleLabel;
        //        [self addSubview:self.leftTitleLabel];
        //        self.leftTitleLabel.backgroundColor=randomColor;
        
        //        UILabel * rightDetailTitleLabel = [[UILabel alloc]init];
        //        self.rightDetailTitleLabel = rightDetailTitleLabel;
        //        [self addSubview:self.rightDetailTitleLabel];
        //        self.rightDetailTitleLabel.backgroundColor= randomColor;
        
        //        UIImageView * rightImageView = [[UIImageView alloc]init];
        //        self.rightImageView = rightImageView;
        //        [self addSubview:self.rightImageView];
        //        self.rightImageView.backgroundColor=randomColor;
        
        //        UIImageView * arrowToRight = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"jiantou"]];
        //        self.arrowToRight = arrowToRight;
        //        [self addSubview:self.arrowToRight];
        //        self.arrowToRight.backgroundColor=randomColor;
        
        
//        [self addTarget:self action:@selector(sectionHeaderClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

//-(void)sectionHeaderClick:(CustomDetailCell*)sender
//{
//    if ([self.CustomDetailCellDelegate respondsToSelector:@selector(customDetailCellClickWith:)]) {
//        [self.CustomDetailCellDelegate customDetailCellClickWith:self];
//    }
//}

-(UIImageView *)customBackgroundImageView{
    if (_customBackgroundImageView==nil) {
        UIImageView * customBackgroundImageView = [[UIImageView alloc]init];
        _customBackgroundImageView = customBackgroundImageView;
        customBackgroundImageView.contentMode =   UIViewContentModeScaleToFill;
        [self addSubview:customBackgroundImageView];
    }
    return _customBackgroundImageView;
}

-(UIView * )bottomLine{
    if(_bottomLine==nil){
        UIView * bottomLine =  [[UIView alloc]init];
        _bottomLine = bottomLine;
        bottomLine.backgroundColor=BackgroundGray;
        [self addSubview:bottomLine];
    }
    return _bottomLine  ;
}
-(UIImageView * )arrowToRight{
    if(_arrowToRight==nil){
        UIImageView * arrowToRight = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"jiantou"]];
        [self addSubview:arrowToRight];
//        arrowToRight.backgroundColor=randomColor;
        
        _arrowToRight = arrowToRight;
    }
    return _arrowToRight;
}

-(UIImageView * )rightImageView{
    if(_rightImageView==nil){
        UIImageView * rightImageView = [[UIImageView alloc]init];
        [self addSubview:rightImageView];
//        rightImageView.backgroundColor=randomColor;
        _rightImageView = rightImageView;
    }
    return _rightImageView;
}

-(UILabel * )rightDetailTitleLabel{
    if(_rightDetailTitleLabel==nil){
        UILabel * rightDetailTitleLabel = [[UILabel alloc]init];
        rightDetailTitleLabel.textAlignment  = NSTextAlignmentRight;
        rightDetailTitleLabel.font = [UIFont systemFontOfSize:12*SCALE];
        rightDetailTitleLabel.textColor = [UIColor lightGrayColor];
        [self addSubview:rightDetailTitleLabel];
//        rightDetailTitleLabel.backgroundColor= randomColor;
        _rightDetailTitleLabel = rightDetailTitleLabel;
    }
    return _rightDetailTitleLabel;
}

-(UILabel * )leftTitleLabel{
    if(_leftTitleLabel==nil){
        UILabel * leftTitleLabel = [[UILabel alloc]init];
        [self addSubview:leftTitleLabel];
        _leftTitleLabel = leftTitleLabel;
        _leftTitleLabel.font = [UIFont systemFontOfSize:15*SCALE];
    }
    return _leftTitleLabel;
}

-(UIImageView * )leftImageView{
    if(_leftImageView==nil){
        UIImageView * leftImageView = [[UIImageView alloc]init];
        [self addSubview:leftImageView];
        leftImageView.contentMode=UIViewContentModeScaleAspectFit;
//        leftImageView.backgroundColor=randomColor;
        _leftImageView = leftImageView;
    }
    return _leftImageView;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat txtToImgMargin = 5*SCALE ;
    //左侧布局
//    CGFloat leftToScreenMargin = 10*SCALE ;
    CGFloat leftImageX = 0;
    CGFloat leftImageY = 0 ;
    CGFloat leftImageW = 20*SCALE;
    CGFloat leftImageH = leftImageW;
    
    CGFloat leftTitleX = 0;
    CGFloat leftTitleY = 0 ;
    CGFloat leftTitleW = self.bounds.size.width*0.5;
    CGFloat leftTitleH = self.bounds.size.height;
    if (self.leftTitle.length>0 && self.leftImage) {//有图有字
        leftImageX = 10*SCALE;
        leftImageY = (self.bounds.size.height-leftImageH)*0.5;
        leftTitleX = leftImageX + leftImageW + txtToImgMargin ;
        self.leftImageView.frame = CGRectMake(leftImageX, leftImageY, leftImageW, leftImageH);
        self.leftTitleLabel.frame = CGRectMake(leftTitleX, leftTitleY, leftTitleW, leftTitleH);
        
    }else if (self.leftImage){//只有图
        leftImageX = 10*SCALE;
        leftImageY = (self.bounds.size.height-leftImageH)*0.5;
        self.leftImageView.frame = CGRectMake(leftImageX, leftImageY, leftImageW, leftImageH);
    }else if (self.leftTitle.length>0){//只有字
        leftTitleX = 10*SCALE;
        self.leftTitleLabel.frame = CGRectMake(leftTitleX, leftTitleY, leftTitleW, leftTitleH);
    
    }
    
    
    //右侧布局
    CGFloat rightToScreenMargin = 10 * SCALE ;
    
    CGFloat rightDetailTitleX = 0;
    CGFloat rightDetailTitleY = 0 ;
    CGFloat rightDetailTitleW = 0;
    CGFloat rightDetailTitleH = 0;
    
    CGFloat rightImageX = 0;
    CGFloat rightImageY = 0 ;
    CGFloat rightImageW = 0;
    CGFloat rightImageH = 0;
    
    CGFloat arrowX = 0 ;
    CGFloat arrowY = 0 ;
    CGFloat arrowW = 6*SCALE ;
    CGFloat arrowH = 11*SCALE ;
    if (self.arrowHidden) {//箭头隐藏
        self.arrowToRight.hidden=YES;
        if (self.rightImage) {//只有图片
            
            CGFloat imageToTopMargin = 5*SCALE ;
            rightImageY = imageToTopMargin ;
            rightImageW = self.bounds.size.height  - imageToTopMargin * 2 ;
            rightImageH = rightImageW ;
            rightImageX = self.bounds.size.width - txtToImgMargin - rightImageW ;
            self.rightImageView.frame = CGRectMake(rightImageX , rightImageY, rightImageW, rightImageH);
            self.rightImageView.layer.cornerRadius = self.rightImageView.bounds.size.width*0.5;
            self.rightImageView.layer.masksToBounds=YES;
        }else if (self.rightDetailTitle.length>0){//只有文字
            
            rightDetailTitleW = self.bounds.size.width * 0.5  - rightToScreenMargin ;
            rightDetailTitleH = self.bounds.size.height ;
            rightDetailTitleX = self.bounds.size.width * 0.5 ;
            rightDetailTitleY = 0 ;
            self.rightDetailTitleLabel.frame = CGRectMake(rightDetailTitleX , rightDetailTitleY, rightDetailTitleW, rightDetailTitleH);
        }
        
    }else{//箭头显示
        self.arrowToRight.hidden=NO;
        arrowX = self.bounds.size.width - rightToScreenMargin - arrowW ;
        arrowY = (self.bounds.size.height - arrowH)*0.5 ;
        self.arrowToRight.frame = CGRectMake(arrowX, arrowY, arrowW, arrowH);
        if (self.rightImage) {//只有图片
            CGFloat imageToTopMargin = 5*SCALE ;
            rightImageY = imageToTopMargin ;
            rightImageW = self.bounds.size.height  - imageToTopMargin * 2 ;
            rightImageH = rightImageW ;
            rightImageX = arrowX - txtToImgMargin - rightImageW ;
            self.rightImageView.frame = CGRectMake(rightImageX , rightImageY, rightImageW, rightImageH);
            self.rightImageView.layer.cornerRadius = self.rightImageView.bounds.size.width*0.5;
            self.rightImageView.layer.masksToBounds=YES;
            
            
        }else if (self.rightDetailTitle.length>0){//只有文字
            rightDetailTitleW = self.bounds.size.width * 0.5 - arrowW - rightToScreenMargin- txtToImgMargin ;
            rightDetailTitleH = self.bounds.size.height ;
            rightDetailTitleX = self.bounds.size.width * 0.5 ;
            rightDetailTitleY = 0 ;
            self.rightDetailTitleLabel.frame = CGRectMake(rightDetailTitleX , rightDetailTitleY, rightDetailTitleW, rightDetailTitleH);
        }
    }
 
    if (self.showBottomLine) {
        self.bottomLine.frame = CGRectMake(0, self.bounds.size.height-1, self.bounds.size.width, 1);
    }else{
        [self.bottomLine removeFromSuperview];
        self.bottomLine=nil;
    }
    
    if (_customBackgroundImageView) {
        self.customBackgroundImageView.frame = self.bounds;
    }
}

/**
 @property(nonatomic,strong)UIImage * leftImage ;
 @property(nonatomic,copy)NSString * leftTitle ;
 @property(nonatomic,copy)NSString * rightDetailTitle ;
 @property(nonatomic,strong)UIImage * rightImage ;
 */
-(void)setLeftImage:(UIImage *)leftImage{
    _leftImage = leftImage ;
    self.leftImageView.image=leftImage;
}
-(void)setLeftTitle:(NSString *)leftTitle{
    _leftTitle = leftTitle;
    self.leftTitleLabel.text =leftTitle;
}
-(void)setRightImage:(UIImage *)rightImage{
    _rightImage = rightImage;
    self.rightImageView.image = rightImage;
}
-(void)setRightDetailTitle:(NSString *)rightDetailTitle{
    if ([rightDetailTitle isKindOfClass:[NSString class]]) {
        _rightDetailTitle = rightDetailTitle;
        
    }else if ([rightDetailTitle isKindOfClass:[NSNumber class]]){
        _rightDetailTitle = [NSString stringWithFormat:@"%@",rightDetailTitle];
    }
    self.rightDetailTitleLabel.text = rightDetailTitle;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

/**
 @property(nonatomic,strong)CustomDetailCellModel * customDetailCellModel ;
 @property(nonatomic,assign)BOOL arrowHidden ;
 
 @property(nonatomic,strong)UIImage * leftImage ;
 @property(nonatomic,copy)NSString * leftTitle ;
 @property(nonatomic,copy)NSString * rightDetailTitle ;
 @property(nonatomic,strong)UIImage * rightImage ;
 @property(nonatomic,strong)UIFont * leftTitleFont ;
 @property(nonatomic,strong)UIFont * rightDetailTitleFont ;
 @property(nonatomic,strong)UIColor * rightDetailTitleColor ;
 @property(nonatomic,assign)BOOL  showBottomLine ;
 */
/**
 @property(nonatomic,strong)UIFont * leftTitleFont ;
 @property(nonatomic,strong)UIFont * rightDetailTitleFont ;
 @property(nonatomic,strong)UIColor * rightDetailTitleColor ;
 */

-(void)setCustomDetailCellModel:(CustomDetailCellModel *)customDetailCellModel{
    _customDetailCellModel = customDetailCellModel ;
    self.arrowHidden = customDetailCellModel.arrowHidden;
    self.leftImage = customDetailCellModel.leftImage ;
    self.leftTitle = customDetailCellModel.leftTitle;
    self.rightDetailTitle = customDetailCellModel.rightDetailTitle;
    self.rightImage = customDetailCellModel.rightImage;
    self.leftTitleFont = customDetailCellModel.leftTitleFont;
    self.rightDetailTitleFont = customDetailCellModel.rightDetailTitleFont;
    self.rightDetailTitleColor = customDetailCellModel.rightDetailTitleColor;
    self.showBottomLine = customDetailCellModel.showBottomLine;
    

}
-(void)setLeftTitleFont:(UIFont *)leftTitleFont{
    _leftTitleFont = leftTitleFont;
    if (leftTitleFont) {
        self.leftTitleLabel.font = leftTitleFont;
        
    }
}
-(void)setRightDetailTitleFont:(UIFont *)rightDetailTitleFont{
    _rightDetailTitleFont = rightDetailTitleFont;

    if (rightDetailTitleFont) {
        
        self.rightDetailTitleLabel.font = rightDetailTitleFont;
    }
}
-(void)setRightDetailTitleColor:(UIColor *)rightDetailTitleColor{
    _rightDetailTitleColor=rightDetailTitleColor;
    if (rightDetailTitleColor) {
        
        self.rightDetailTitleLabel.textColor = rightDetailTitleColor;
    }

}
-(void)setLeftTitleColor:(UIColor *)leftTitleColor{
    _leftTitleColor = leftTitleColor;

    if (leftTitleColor) {
        
        self.leftTitleLabel.textColor = leftTitleColor;
    }

}
@end
