//
//  PayTypeView.m
//  b2c
//
//  Created by wangyuanfei on 16/4/29.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "PayTypeView.h"
#import "ConfirmOrderNormalCellModel.h"

@interface PayTypeView ()

@property(nonatomic,weak)UILabel * titleLabel ;
@property(nonatomic,weak)UILabel *  subTitleLabel  ;
@property(nonatomic,weak)UILabel * subsubTitleLabel ;
@property(nonatomic,weak)UIView * bottomLine ;

@end

@implementation PayTypeView


-(instancetype)initWithFrame:(CGRect)frame{

    if (self=[super initWithFrame: frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        UILabel * titleLabel  =  [[UILabel alloc]init];
        titleLabel.textColor = MainTextColor;
        titleLabel.font = [UIFont systemFontOfSize:14];
        self.titleLabel = titleLabel;
        [self addSubview:titleLabel];
        
        
        UILabel * subTitleLabel  =  [[UILabel alloc]init];
        subTitleLabel.textColor = MainTextColor;
        self.subTitleLabel = subTitleLabel;
        [self addSubview:subTitleLabel];
        subTitleLabel.textAlignment = NSTextAlignmentRight;
        subTitleLabel.font  = [UIFont systemFontOfSize:12];
        
        UILabel * subsubTitleLabel  =  [[UILabel alloc]init];
        self.subsubTitleLabel = subsubTitleLabel;
        subsubTitleLabel.textColor = MainTextColor;
        subsubTitleLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:subsubTitleLabel];
        subsubTitleLabel.font  = [UIFont systemFontOfSize:12];
        
        UIView * bottomLine = [[UIView alloc]init];
        self.bottomLine = bottomLine;
        [self addSubview:bottomLine];
        bottomLine.backgroundColor = BackgroundGray;;
    }
    return self;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat margin = 10 ;
    
    CGFloat titleLabelW = (self.bounds.size.width-margin*2)/2 ;
    CGFloat titleLabelH = self.bounds.size.height/3 ;
    CGFloat titleLabelX = margin ;
    CGFloat titleLabelY = 0 + margin ;
    self.titleLabel.frame = CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH);
    
    CGFloat subTitleLabelW = (self.bounds.size.width-margin*2)/2 - margin - 8  ;
    CGFloat subTitleLabelH = self.bounds.size.height/3 ;
    CGFloat subTitleLabelX = CGRectGetMaxX(self.titleLabel.frame) ;
    CGFloat subTitleLabelY = self.bounds.size.height/3 - margin ;
    self.subTitleLabel.frame = CGRectMake(subTitleLabelX, subTitleLabelY, subTitleLabelW, subTitleLabelH);
    
    CGFloat subsubTitleLabelW = (self.bounds.size.width-margin*2)/2  - margin - 8 ;
    CGFloat subsubTitleLabelH = self.bounds.size.height/3 ;
    CGFloat subsubTitleLabelX = CGRectGetMaxX(self.titleLabel.frame) ;
    CGFloat subsubTitleLabelY = self.bounds.size.height/3*2-margin ;
    self.subsubTitleLabel.frame = CGRectMake(subsubTitleLabelX, subsubTitleLabelY, subsubTitleLabelW, subsubTitleLabelH);
    
    self.bottomLine.frame = CGRectMake(margin, self.bounds.size.height-1, self.bounds.size.width - margin*2, 1);

}
-(void)setCellModel:(ConfirmOrderNormalCellModel *)cellModel{
    _cellModel = cellModel ;
    self.titleLabel.text = cellModel.title;
    self.subTitleLabel.text = cellModel.subone;
    self.subsubTitleLabel.text = cellModel.subtwo;
    if ([cellModel.items isKindOfClass:[NSArray class] ] && cellModel.items.count>0) {
        for (int i = 0 ; i < cellModel.items.count  ; i++ ) {
            if (i==0) {
                
                self.subTitleLabel.text =[NSString stringWithFormat:@"%@",cellModel.items[i]];
            }else if (i==1){
                self.subsubTitleLabel.text =[NSString stringWithFormat:@"%@",cellModel.items[i]];
            }
        }
    }

}

@end
