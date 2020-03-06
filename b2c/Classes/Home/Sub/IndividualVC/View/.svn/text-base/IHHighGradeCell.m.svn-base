//
//  IHHighGradeCell.m
//  b2c
//
//  Created by wangyuanfei on 16/5/5.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "IHHighGradeCell.h"
#import "CellTitleView.h"

#import "IHHighGradeCellCompose.h"

@interface IHHighGradeCell ()

@property(nonatomic,weak) CellTitleView  * titleView ;
@property(nonatomic,weak)IHHighGradeCellCompose * compose ;
@property(nonatomic,weak)UIView * bottomContainer ;
@end

@implementation IHHighGradeCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
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
        
        
        
        
        CGFloat topImageViewH = 33*SCALE ;
        CGFloat totalTopMargin = 11*SCALE ;
        CGFloat collectionViewH = 146*SCALE;
        
        [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(totalTopMargin);
            make.left.right.equalTo(self.contentView);
            make.height.equalTo(@(topImageViewH));
        }];
        
        
        [self.bottomContainer mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.titleView);
            make.top.equalTo(self.titleView.mas_bottom).offset(1);
            make.height.equalTo(@(collectionViewH));
        }];
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.bottom.equalTo(self.bottomContainer);
        }];
        
        
        
    }
    return self;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat leftRightMargin = 1 ;
//    CGFloat subW = (self.bounds.size.width - (self.bottomContainer.subviews.count-1)*leftRightMargin)/self.bottomContainer.subviews.count;
    CGFloat subW = (self.bounds.size.width - (3-1)*leftRightMargin)/3;
    CGFloat subH = self.bottomContainer.bounds.size.height;
    
    for (int i = 0 ;  i< self.bottomContainer.subviews.count; i++) {
        IHHighGradeCellCompose * sub = self.bottomContainer.subviews[i];
        CGFloat subX = (subW+leftRightMargin)*i;
        CGFloat subY = 0;
        sub.frame = CGRectMake(subX, subY, subW, subH);
    }
    
    LOG(@"_%@_%d_这个该死的头视图  ---------->%@",[self class] , __LINE__,self.titleView);
    
}
-(void)setCellModel:(HCellModel *)cellModel{
    [super setCellModel:cellModel];
    self.titleView.titleStrColor = [UIColor colorWithHexString:@"2b912b"];;
    self.titleView.titleStr = cellModel.channel;
//    self.titleView.backImageURLStr = cellModel.imgStr;
    self.titleView.backgroundColor = [UIColor colorWithHexString:@"ddffdf"];
//    self.titleView.leftTitleColor = MainTextColor;
    for (UIView * subview in self.bottomContainer.subviews) {
        [subview removeFromSuperview];
    }
    
    
    
    if (self.bottomContainer.subviews.count==0) {
        for (int i = 0 ; i< cellModel.items.count; i++) {
#pragma mark 为了限制显示个数 , 临时加的限制
            if (i>2) {
                break;
            }
            IHHighGradeCellCompose * sub = [[IHHighGradeCellCompose alloc]init];
            sub.backgroundColor=[UIColor whiteColor];
            [sub addTarget:self action:@selector(composeClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.bottomContainer addSubview:sub];
        }
    }
    
    for (int k = 0 ; k<cellModel.items.count; k++) {
        if (k>2) {
            break;
        }
        IHHighGradeCellCompose * sub = self.bottomContainer.subviews[k];
        sub.bottomTitleFont = [UIFont systemFontOfSize:12];
        sub.bottomTitleColor = SubTextColor;
        HCellComposeModel * model =cellModel.items[k];
        model.theamColor=[UIColor colorWithRed:165/256.0 green:67/256.0 blue:240/256.0 alpha:1];
//        model.theamtit=@"包邮";
        HCellComposeModel * composeModel = cellModel.items[k];
        sub.composeModel = composeModel ; //cellModel.items[k];
    }
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}
@end
