//
//  HCHotMarketCell.m
//  b2c
//
//  Created by wangyuanfei on 16/8/8.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HCHotMarketCell.h"
#import "CellTitleView.h"
#import "IHHotMarketCellCompose.h"
@interface HCHotMarketCell ()
@property(nonatomic,weak) CellTitleView  * titleView ;
//@property(nonatomic,weak)IHHighGradeCellCompose * compose ;
@property(nonatomic,weak)UIView * bottomContainer ;


@end


@implementation HCHotMarketCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        CellTitleView * titleView = [[CellTitleView alloc]init];
        self.titleView = titleView;
        [self.contentView addSubview:self.titleView];
        //        self.topImageView.backgroundColor = randomColor;
        titleView.arrowHidden=YES;
        
        
        UIView * container = [[UIView alloc]init];
        self.bottomContainer = container;
        [self.contentView addSubview:container];
                self.bottomContainer.backgroundColor= BackgroundGray;
        
        
        
        //
        //        CGFloat topImageViewH = 33*SCALE ;
        //        CGFloat totalTopMargin = 11*SCALE ;
        //        CGFloat collectionViewH = 146*SCALE;
        //
        //        [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.top.equalTo(self.contentView).offset(totalTopMargin);
        //            make.left.right.equalTo(self.contentView);
        //            make.height.equalTo(@(topImageViewH));
        //        }];
        //
        //
        //        [self.bottomContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.left.equalTo(self.titleView).offset(10);
        //            make.right.equalTo(self.titleView).offset(-10);
        //            make.top.equalTo(self.titleView.mas_bottom).offset(1);
        //            make.height.equalTo(@(collectionViewH));
        //        }];
        //        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.left.right.equalTo(self);
        //            make.bottom.equalTo(self.bottomContainer);
        //        }];
        //
        //
        
    }
    return self;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    //    CGFloat leftRightMargin = 1 ;
    CGFloat midMargin = 1 ;
    CGFloat toBorderMaigin = 0 ;
    CGFloat usedWidth = self.bounds.size.width - toBorderMaigin * 2;
    
    //    [self.bottomContainer mas_updateConstraints:^(MASConstraintMaker *make) {
    //        make.height.equalTo(@(bottomtotalH));
    //        [self layoutIfNeeded];
    //    }];
    for (int i = 0 ;  i< self.bottomContainer.subviews.count; i++) {
        CGFloat subW = 0;
        CGFloat subH = 0;
        CGFloat subX = 0;
        CGFloat subY = 0;
        if (i<2) {//保证两个大图
            
            subW = (usedWidth - midMargin)/2;
            subX = (subW + midMargin) * (i%4);
            subH = subW;
        }else{//布局小图
            subW = (usedWidth - midMargin*3)/4;
            subH = subW;
            subX = (subW +midMargin)*((i-2)%4) ;
            subY =  (subH + midMargin) * ((i-2)/4) + (usedWidth -midMargin)/2+midMargin;
            
            
        }
        
        
        IHHotMarketCellCompose * sub = self.bottomContainer.subviews[i];
        sub.frame = CGRectMake(subX, subY, subW, subH);
    }
    
}
-(void)setCellModel:(HCellModel *)cellModel{
    
    /////////////
    
    CGFloat midMargin = 1 ;
    CGFloat toBorderMaigin = 0 ;
    CGFloat usedWidth = screenW - toBorderMaigin * 2;
    CGFloat oneBigWidth = (usedWidth - midMargin )/2;
    CGFloat oneSmallWidth = (usedWidth - midMargin * 3) /4;
    CGFloat bottomtotalH=0;
    if ((cellModel.items.count - 2)%4==0) {
        bottomtotalH= (cellModel.items.count - 2 )/4 * oneSmallWidth  + oneBigWidth + midMargin;
        
    }else{
        bottomtotalH = (cellModel.items.count - 2 )/4 * oneSmallWidth  + oneBigWidth + midMargin +oneSmallWidth;
    }
    
    CGFloat topImageViewH = 33*SCALE ;
    CGFloat totalTopMargin = 11*SCALE ;
    //移除原有的所有约束
    NSArray * containerConstraints = self.bottomContainer.constraints;
    [self.bottomContainer removeConstraints:containerConstraints];
    
    NSArray * topImageViewConstraints = self.titleView.constraints;
    [self.titleView removeConstraints:topImageViewConstraints];
    
    NSArray *  containtViewConstraints  =self.contentView.constraints ;
    [self.contentView removeConstraints:containtViewConstraints];
    
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(totalTopMargin);
        make.left.right.equalTo(self.contentView);
        make.height.equalTo(@(topImageViewH));
        
    }];
    
    
    [self.bottomContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.left.equalTo(self.titleView).offset(10);
        //        make.right.equalTo(self.titleView).offset(-10);
        make.left.right.equalTo(self.titleView);
        make.top.equalTo(self.titleView.mas_bottom).offset(1);
        make.height.equalTo(@(bottomtotalH));
    }];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(self.bottomContainer.mas_bottom);
    }];
    
    /////////////
    [self layoutIfNeeded];
    
    [super setCellModel:cellModel];
    self.titleView.titleStrColor =  [UIColor colorWithHexString:@"30b4f0"];
    self.titleView.titleStr = cellModel.channel;
    self.titleView.backImageURLStr = cellModel.imgStr;
    self.titleView.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
    self.titleView.leftTitleColor = MainTextColor;
    for (UIView * subview in self.bottomContainer.subviews) {
        [subview removeFromSuperview];
    }
    
    for (UIView * subview in self.bottomContainer.subviews) {
        [subview removeFromSuperview];
    }
    
    if (self.bottomContainer.subviews.count==0) {
        for (int i = 0 ; i< cellModel.items.count; i++) {
            IHHotMarketCellCompose * sub = [[IHHotMarketCellCompose alloc]init];
            sub.backgroundColor=[UIColor whiteColor];
            [sub addTarget:self action:@selector(composeClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.bottomContainer addSubview:sub];
        }
    }
    
    for (int k = 0 ; k<cellModel.items.count; k++) {
        
        IHHotMarketCellCompose * sub = self.bottomContainer.subviews[k];
        sub.titleFont = [UIFont systemFontOfSize:12];
        sub.titleColor = SubTextColor;
        HCellComposeModel * model =cellModel.items[k];
        sub.composeModel = model;
    }
    
    [self setNeedsDisplay];
    [self setNeedsLayout];
    
    
}

-(void)composeClick:(HCellBaseComposeView*)sender
{
    if (sender.composeModel) {
        if (sender.composeModel.classify_name) {
            
            sender.composeModel.keyParamete=@{
                                              @"paramete":sender.composeModel.classify_name
                                              };
        }
        
        NSDictionary * pragma = @{
                                  @"CountrysideCellComposeViewModel":sender.composeModel
                                  };
        sender.composeModel.actionKey = @"HSearchgoodsListVC";
        [[NSNotificationCenter defaultCenter] postNotificationName:@"CountrysideCellComposeViewClick" object:nil userInfo:pragma];
    }
}
@end
