//
//  GOHeaderView.m
//  b2c
//
//  Created by wangyuanfei on 16/5/17.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "GOHeaderView.h"
#import "GOHeaderModel.h"
@interface GOHeaderView ()

@property(nonatomic,weak)UILabel * shopNameLabel ;
@property(nonatomic,weak) UILabel * freightLabel ;
@property(nonatomic,weak)UIView * bottomLine ;

@end


@implementation GOHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UILabel * shopNameLabel = [[UILabel alloc]init];
        shopNameLabel.textColor = MainTextColor;
        self.shopNameLabel =  shopNameLabel;
        [self addSubview:self.shopNameLabel];
        self.shopNameLabel.font= [UIFont systemFontOfSize:14];
        
        UILabel * freightLabel = [[UILabel alloc]init];
        freightLabel.textColor = SubTextColor;
        self.freightLabel  = freightLabel;
        [self addSubview:freightLabel];
        self.freightLabel.font = [UIFont systemFontOfSize:12];
        
        UIView * bottomLine = [[UIView alloc]init];
        bottomLine.backgroundColor=BackgroundGray;
        [self addSubview:bottomLine];
        self.bottomLine = bottomLine;

    }
    return self;

}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat borderMargin = 10 ;
    
    CGSize freightSize = [self.freightLabel.text sizeWithFont:self.freightLabel.font MaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    CGFloat freightW = freightSize.width+1 ;
    CGFloat freightH = self.bounds.size.height ;
    CGFloat freightX = self.bounds.size.width - borderMargin - freightW  ;
    CGFloat freightY = 0 ;
    self.freightLabel.frame = CGRectMake(freightX, freightY, freightW, freightH);
    
    
    
    
    
    CGFloat shopNameW = CGRectGetMinX(self.freightLabel.frame) - borderMargin*2 ;
    CGFloat shopNameH = self.bounds.size.height ;
    CGFloat shopNameX = borderMargin ;
    CGFloat shopNameY = 0 ;
    self.shopNameLabel.frame = CGRectMake(shopNameX, shopNameY, shopNameW, shopNameH);
    

    
    self.bottomLine.frame = CGRectMake(0, self.bounds.size.height-3, self.bounds.size.width, 3);
    

}

-(void)setHeaderModel:(GOHeaderModel *)headerModel{
    _headerModel = headerModel;
    self.shopNameLabel.text = headerModel.name;
    NSString * contentStr = nil;
    NSString * str = nil;
    if ([headerModel.shopFreight floatValue]>0.0000001) {//有运费
        contentStr = [[NSString stringWithFormat:@"%@",headerModel.shopFreight] convertToYuan];
        str = [NSString stringWithFormat:@"运费:共%@元",contentStr  ];
        NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc]initWithString:str];
        NSRange  targetRange= [str rangeOfString:contentStr];
        [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:targetRange];
        self.freightLabel.attributedText=attStr;
        
    }else{//免运费
        str = @"免运费";
        self.freightLabel.text = str;
    }
    
    
    
    
    
}
@end
