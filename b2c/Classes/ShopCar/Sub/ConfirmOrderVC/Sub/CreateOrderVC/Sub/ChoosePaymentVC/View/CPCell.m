//
//  CPCell.m
//  b2c
//
//  Created by wangyuanfei on 16/5/24.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "CPCell.h"
#import "CPCellModel.h"

@interface CPCell ()

@property(nonatomic,weak)UIView * bottomLine ;
@property(nonatomic,weak)UIImageView * imgView ;
@property(nonatomic,weak)UILabel * payMentNameLabel ;
@property(nonatomic,weak)UILabel * payMentDescrip ;
@property(nonatomic,weak)UIImageView * arrowImageView ;

@end

@implementation CPCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIView * bottomLine = [[UIView alloc]init];
        self.bottomLine = bottomLine;
        [self.contentView addSubview:self.bottomLine];
        self.bottomLine.backgroundColor = BackgroundGray;
        
        UIImageView * imgView  = [[UIImageView alloc]init];
        self.imgView = imgView;
        [self.contentView addSubview:imgView];
        
        UILabel * payMentNameLabel  = [[UILabel alloc]init];
        self.payMentNameLabel = payMentNameLabel;
        [self.contentView addSubview:payMentNameLabel];
        payMentNameLabel.font = [UIFont systemFontOfSize:14];
        payMentNameLabel.textColor = MainTextColor;
        
        UILabel * payMentDescripLabel  = [[UILabel alloc ]init];
        self.payMentDescrip = payMentDescripLabel;
        [self.contentView addSubview:payMentDescripLabel];
        payMentDescripLabel.font = [UIFont systemFontOfSize:12];
        payMentDescripLabel.textColor = SubTextColor;
        
        UIImageView * arrowImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"jiantou"]];
        self.arrowImageView  = arrowImageView;
        [self.contentView addSubview:arrowImageView];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat margin = 10 ;
    
    CGFloat bottomLineW = self.bounds.size.width ;
    CGFloat bottomLineH = 2 ;
    CGFloat bottomLineX = 0 ;
    CGFloat bottomLineY = self.bounds.size.height-bottomLineH ;
    self.bottomLine.frame = CGRectMake(bottomLineX, bottomLineY, bottomLineW, bottomLineH);
    
    CGFloat imgViewH = self.bounds.size.height- bottomLineH - margin*2 ;
    CGFloat imgViewW =  imgViewH;
    CGFloat imgViewX = margin ;
    CGFloat imgViewY = margin ;
    self.imgView.frame = CGRectMake(imgViewX, imgViewY, imgViewW, imgViewH);
    
    CGFloat arrowImageViewW = 7 ;
    CGFloat arrowImageViewH = 12 ;
    CGFloat arrowImageViewCenterX = self.bounds.size.width - margin - arrowImageViewW/2 ;
    CGFloat arrowImageViewCenterY = CGRectGetMidY(self.imgView.frame) ;
    self.arrowImageView.bounds = CGRectMake(0, 0, arrowImageViewW, arrowImageViewH);
    self.arrowImageView.center = CGPointMake(arrowImageViewCenterX, arrowImageViewCenterY);
    
    CGFloat payMentNameLabelW = CGRectGetMinX(self.arrowImageView.frame) - CGRectGetMaxX(self.imgView.frame) - margin ;
    CGFloat payMentNameLabelH = self.payMentNameLabel.font.lineHeight ;
    CGFloat payMentNameLabelX = CGRectGetMaxX(self.imgView.frame) + margin ;
    CGFloat payMentNameLabelY = CGRectGetMinY(self.imgView.frame)  ;
    self.payMentNameLabel.frame = CGRectMake(payMentNameLabelX, payMentNameLabelY, payMentNameLabelW, payMentNameLabelH);
    
    CGFloat payMentDescripW =  payMentNameLabelW;
    CGFloat payMentDescripH = self.payMentDescrip.font.lineHeight ;
    CGFloat payMentDescripX = CGRectGetMaxX(self.imgView.frame) + margin ;
    CGFloat payMentDescripY = CGRectGetMaxY(self.imgView.frame) - payMentDescripH  ;
    self.payMentDescrip.frame = CGRectMake(payMentDescripX, payMentDescripY, payMentDescripW, payMentDescripH);
    

    
}
-(void)setCellModel:(CPCellModel *)cellModel{
    _cellModel = cellModel;
    self.imgView.image = [UIImage imageNamed:cellModel.imgName];
    self.payMentNameLabel.text = cellModel.payMentName;
    self.payMentDescrip.text = cellModel.payMentDescrip;

}
@end
