//
//  PNormalCell.m
//  b2c
//
//  Created by wangyuanfei on 3/30/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "PNormalCell.h"

#import "PTableCellModel.h"


#import "PSectionHeaderView.h"

@interface PNormalCell()//<PSectionHeaderViewDelegate>

@property(nonatomic,weak)PSectionHeaderView * containerView ;
@property(nonatomic,weak)UIView * bottomLine ;
@end

@implementation PNormalCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addsubviews];
        [self layoutsubviews];
    }
    return self;
    
}
-(void)addsubviews
{
    PSectionHeaderView * containerView = [[PSectionHeaderView alloc]init];
    //    containerView.arrowHidden=YES;////////////////////////////
    self.containerView = containerView;
    [self.contentView addSubview:containerView];
    //    containerView.backgroundColor = randomColor;
    [containerView addTarget:self action:@selector(profileSectionHeaderClickWith:) forControlEvents:UIControlEventTouchUpInside];
    //    containerView.PSectionHeaderDelegate = self;
    
    
    UIView * bottomLine = [[UIView alloc]init];
    self.bottomLine=bottomLine;
    self.bottomLine.backgroundColor=BackgroundGray;
    [self.contentView addSubview:self.bottomLine];
    
}
-(void)profileSectionHeaderClickWith:(PSectionHeaderView *)sender{
    if ([self.PCellDelegate respondsToSelector:@selector(actionWithModel:)]) {
        [self.PCellDelegate actionWithModel:sender.sectionHeaderModel];
    }
}
-(void)layoutsubviews
{
    //    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.top.left.right.equalTo(self.contentView);
    //        make.height.equalTo(@(45*SCALE));
    //    }];
    //
    //    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.top.equalTo(self.containerView.mas_bottom);
    //        make.left.right.equalTo(self.containerView);
    //        make.height.equalTo(@(1*SCALE));
    //    }];
    //
    //    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.bottom.equalTo(self.bottomLine.mas_bottom);
    //        make.left.right.equalTo(self);
    //    }];
    
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.containerView.frame = CGRectMake(0, 0, self.bounds.size.width, 45*SCALE);
    
    self.bottomLine.frame = CGRectMake(0, CGRectGetMaxY(self.containerView.frame), self.bounds.size.width, 1);
    
}
-(void)setCellModel:(PTableCellModel *)cellModel{
    _cellModel = cellModel;
    self.containerView.leftTitle = cellModel.title;
#pragma mark  测试赋值sectionheader
    //    self.containerView.leftImage = [UIImage imageNamed:@"tm_quick_menu_home"];
    //    self.containerView.rightDetailTitle = @"详细数据";
    //    self.containerView.rightImage = [UIImage imageNamed:@"me"];
    //    PTableCellModel * model = [[PTableCellModel alloc]init];
    //    model.title = cellModel.title;
    //    model.judge=cellModel.judge;
    //    model.actionKey = cellModel.actionKey;
    self.containerView.sectionHeaderModel = cellModel;
    
    
}
//-(void)setCellTitle:(NSString *)cellTitle{
//    _cellTitle = cellTitle;
//    if (cellTitle&&cellTitle.length>0) {
//        self.containerView.title = cellTitle;
//    }
//}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end

















































////
////  PNormalCell.m
////  b2c
////
////  Created by wangyuanfei on 3/30/16.
////  Copyright © 2016 www.16lao.com. All rights reserved.
////
//
//#import "PNormalCell.h"
//
//#import "PTableCellModel.h"
//
//
//#import "PSectionHeaderView.h"
//
//@interface PNormalCell()//<PSectionHeaderViewDelegate>
//
//@property(nonatomic,weak)PSectionHeaderView * containerView ;
//@property(nonatomic,weak)UIView * bottomLine ;
//@end
//
//@implementation PNormalCell
//
//-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
//    
//    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        [self addsubviews];
//        [self layoutsubviews];
//    }
//    return self;
//    
//}
//-(void)addsubviews
//{
//    PSectionHeaderView * containerView = [[PSectionHeaderView alloc]init];
////    containerView.arrowHidden=YES;////////////////////////////
//    self.containerView = containerView;
//    [self.contentView addSubview:containerView];
////    containerView.backgroundColor = randomColor;
//    [containerView addTarget:self action:@selector(profileSectionHeaderClickWith:) forControlEvents:UIControlEventTouchUpInside];
////    containerView.PSectionHeaderDelegate = self;
//    
//    
//    UIView * bottomLine = [[UIView alloc]init];
//    self.bottomLine=bottomLine;
//    self.bottomLine.backgroundColor=BackgroundGray;
//    [self.contentView addSubview:self.bottomLine];
//    
//}
//-(void)profileSectionHeaderClickWith:(PSectionHeaderView *)sender{
//    if ([self.PCellDelegate respondsToSelector:@selector(actionWithModel:)]) {
//        [self.PCellDelegate actionWithModel:sender.sectionHeaderModel];
//    }
//}
//-(void)layoutsubviews
//{
//    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.right.equalTo(self.contentView);
//        make.height.equalTo(@(45*SCALE));
//    }];
//    
//    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.containerView.mas_bottom);
//        make.left.right.equalTo(self.containerView);
//        make.height.equalTo(@(1*SCALE));
//    }];
//    
//    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(self.bottomLine.mas_bottom);
//        make.left.right.equalTo(self);
//    }];
//
//}
//-(void)setCellModel:(PTableCellModel *)cellModel{
//    _cellModel = cellModel;
//    self.containerView.leftTitle = cellModel.title;
//#pragma mark  测试赋值sectionheader
////    self.containerView.leftImage = [UIImage imageNamed:@"tm_quick_menu_home"];
////    self.containerView.rightDetailTitle = @"详细数据";
////    self.containerView.rightImage = [UIImage imageNamed:@"me"];
////    PTableCellModel * model = [[PTableCellModel alloc]init];
////    model.title = cellModel.title;
////    model.judge=cellModel.judge;
////    model.actionKey = cellModel.actionKey;
//    self.containerView.sectionHeaderModel = cellModel;
//    
//
//}
////-(void)setCellTitle:(NSString *)cellTitle{
////    _cellTitle = cellTitle;
////    if (cellTitle&&cellTitle.length>0) {
////        self.containerView.title = cellTitle;
////    }
////}
///*
//// Only override drawRect: if you perform custom drawing.
//// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect {
//    // Drawing code
//}
//*/
//
//@end
