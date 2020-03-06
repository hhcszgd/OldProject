//
//  SeachSectionHeader.m
//  b2c
//
//  Created by wangyuanfei on 16/5/9.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "SeachHeaderView.h"

@interface SeachHeaderView ()

@property(nonatomic,weak)UILabel * titleLabel ;
@property(nonatomic,weak)UILabel  * noHistoryView ;

@end

@implementation SeachHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        
        
        
        UILabel * titlelabel = [[UILabel alloc]init];
        titlelabel.textColor  = MainTextColor;
        self.titleLabel=titlelabel;
        [self addSubview:titlelabel];
        
        ActionBaseView * actionView =    [[ActionBaseView alloc]init];
        actionView.img = [UIImage imageNamed:@"bg_supermarket"];
//        self.actionView  = actionView; //暂时注销清楚搜索历史功能
        [self addSubview:actionView];
        [actionView addTarget:self action:@selector(actionViewClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel * noHistoryView = [[UILabel alloc]init];
        noHistoryView.textAlignment = NSTextAlignmentCenter;
        noHistoryView.text= @"暂无搜索历史";
        self.noHistoryView = noHistoryView;
        [self addSubview:noHistoryView];
        

    }
    return self;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    self.titleLabel.frame = CGRectMake(10, 0, self.bounds.size.width - 10 * 2 , self.bounds.size.height);
    CGFloat margin = 2 ;
    CGFloat actionViewH = (self.bounds.size.height - margin*2)/2 ;
    CGFloat actionViewW =actionViewH  ;
    CGFloat actionViewCenterX = self.bounds.size.width - 10 - actionViewW/2 ;
    CGFloat actionViewCenterY = CGRectGetMidY(self.titleLabel.frame) ;
    self.actionView.bounds = CGRectMake(0, 0, actionViewW, actionViewH);
    self.actionView.center = CGPointMake(actionViewCenterX, actionViewCenterY);
    
    self.noHistoryView.frame = CGRectMake(0, self.bounds.size.height, self.bounds.size.width, self.bounds.size.height);
    self.noHistoryView.hidden = !self.showNoHistoryView;
    self.actionView.hidden =  !self.showActionView;

}
-(void)setHeaderTitle:(NSString *)headerTitle{
    _headerTitle = headerTitle.copy;
    if ([_headerTitle containsString:@"\r"]) {
        _headerTitle= [_headerTitle stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    }
    if ([_headerTitle containsString:@"\n"]) {
        _headerTitle= [_headerTitle stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    }
    if ([_headerTitle containsString:@"\t"]) {
        _headerTitle=  [_headerTitle stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    }
    self.titleLabel.text = [NSString stringWithFormat:@"%@:",_headerTitle];

}


-(void)actionViewClick:(ActionBaseView*)sender
{
    if ([self.headerDelegate respondsToSelector:@selector(actionViewClick:inView:)]) {
        [self.headerDelegate actionViewClick:sender inView:self];
    }
}
-(void)setShowActionView:(BOOL)showActionView{
    _showActionView = showActionView;
    self.actionView.hidden =  !showActionView;
    [self setNeedsLayout];
}
-(void)setShowNoHistoryView:(BOOL)showNoHistoryView{
    _showNoHistoryView = showNoHistoryView;
    self.noHistoryView.hidden = !showNoHistoryView;
    [self setNeedsLayout];


}

@end
