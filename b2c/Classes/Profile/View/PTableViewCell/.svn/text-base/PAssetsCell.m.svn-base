//
//  PAssetsCell.m
//  b2c
//
//  Created by wangyuanfei on 3/30/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "PAssetsCell.h"

#import "PTableCellModel.h"
#import "PSectionHeaderView.h"
#import "POrderCellCompose.h"
#import "POrderCellComposeModel.h"
@interface PAssetsCell()//<CustomDetailCellDelegate>
@property(nonatomic,weak)UIView * topViewContainer ;
@property(nonatomic,weak)UIView * midLine ;
@property(nonatomic,weak)UIView * bottomViewContainer ;
@property(nonatomic,weak)UIView * bottomLine ;
@property(nonatomic,weak)PSectionHeaderView * sectionHeaderView ;
@property(nonatomic,strong)NSMutableArray * subCompenentTitles ;
@property(nonatomic,strong)NSMutableArray * subCompenentActionKeys ;
@property(nonatomic,strong)NSMutableArray * composeImageS ;
@end

@implementation PAssetsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addsubviews];
        [self layoutsubviews];
    }
    return self;
    
}
-(void)addsubviews
{
    UIView * topViewContainer = [[UIView alloc]init];
    self.topViewContainer = topViewContainer;
    [self.contentView addSubview:topViewContainer];
    //    topViewContainer.backgroundColor = randomColor;
    
    
    UIView * midLine = [[UIView alloc]init];
    self.midLine=midLine;
    [self.contentView addSubview:self.midLine];
    self.midLine.backgroundColor=BackgroundGray;
    
    
    UIView * bottomViewContainer = [[UIView alloc]init];
    self.bottomViewContainer = bottomViewContainer;
    [self.contentView addSubview:bottomViewContainer];
    //    bottomViewContainer.backgroundColor = randomColor;
    
    UIView * bottomLine = [[UIView alloc]init];
    self.bottomLine=bottomLine;
    [self.contentView addSubview:self.bottomLine];
    self.bottomLine.backgroundColor=BackgroundGray;
    
    PSectionHeaderView * sectionHeader = [[PSectionHeaderView alloc]init];
    self.sectionHeaderView = sectionHeader;
    [sectionHeader addTarget:self action:@selector(headerClickWith:) forControlEvents:UIControlEventTouchUpInside];
    //    sectionHeader.CustomDetailCellDelegate = self;
    //    sectionHeader.backgroundColor = randomColor;
    //    BaseModel * sectionHeaderModel = [[BaseModel alloc]init];
    //    sectionHeaderModel.actionKey=  ActionPAssetsSection;
    //    sectionHeader.model = sectionHeaderModel;
    [self.topViewContainer addSubview:sectionHeader];
    
    for (int i = 0 ;  i < self.subCompenentTitles.count; i++) {
        POrderCellCompose * sub = [[POrderCellCompose alloc]init];
        POrderCellComposeModel * model= [[POrderCellComposeModel alloc]init];
        model.botomTitle = self.subCompenentTitles[i];
        model.topImage = [UIImage imageNamed:self.composeImageS[i]];
        model.actionKey=self.subCompenentActionKeys[i];
        model.judge=YES;
        sub.orderComposeModel = model;
        [self.bottomViewContainer addSubview:sub];
        [sub addTarget:self action:@selector(customDetailCellClickWith:) forControlEvents:UIControlEventTouchUpInside];
    }
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.topViewContainer.frame = CGRectMake(0, 0, self.bounds.size.width, 44*SCALE);
    self.sectionHeaderView.frame = self.topViewContainer.bounds;
    self.midLine.frame = CGRectMake(0, CGRectGetMaxY(self.topViewContainer.frame), self.bounds.size.width, 1);
    self.bottomViewContainer.frame = CGRectMake(0,CGRectGetMaxY(self.midLine.frame)+1 , self.bounds.size.width, 78*SCALE);
    self.bottomLine.frame = CGRectMake(0, CGRectGetMaxY(self.bottomViewContainer.frame), self.bounds.size.width, 11*SCALE);
    CGFloat  W = self.bottomViewContainer.bounds.size.width/self.bottomViewContainer.subviews.count;
    CGFloat H = self.bottomViewContainer.bounds.size.height;
    for (int i = 0 ; i < self.bottomViewContainer.subviews.count; i ++) {
        ActionBaseView * sub = self.bottomViewContainer.subviews[i];
        sub.frame = CGRectMake(i * W, 0, W, H);
    }
    
}
-(void)layoutsubviews
{
    
    //    [self.topViewContainer mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.top.left.right.equalTo(self.contentView);
    //        make.height.equalTo(@(45*SCALE));
    //    }];
    //
    //    [self.midLine mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.top.equalTo(self.topViewContainer.mas_bottom);
    //        make.left.right.equalTo(self.topViewContainer);
    //        make.height.equalTo(@(1*SCALE));
    //    }];
    //
    //
    //    [self.bottomViewContainer mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.right.equalTo(self.midLine);
    //        make.top.equalTo(self.midLine.mas_bottom);
    //        make.height.equalTo(@(78*SCALE));
    //    }];
    //
    //    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.top.equalTo(self.bottomViewContainer.mas_bottom);
    //        make.left.right.equalTo(self.bottomViewContainer);
    //        make.height.equalTo(@(20*SCALE));
    //    }];
    //
    //    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.bottom.equalTo(self.bottomLine.mas_bottom);
    //        make.left.right.equalTo(self);
    //    }];
    //
    //    [self.sectionHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.top.left.right.bottom.right.equalTo(self.topViewContainer);
    //    }];
    
}
-(void)setCellModel:(PTableCellModel *)cellModel{
    _cellModel = cellModel;
    
    
    
    [self.subCompenentTitles removeAllObjects];
    
    for (int i = 0; i< cellModel.items.count; i++) {
        POrderCellComposeModel * composeModel = cellModel.items[i];
        composeModel.judge = YES;
        if (composeModel.url) {
            composeModel.keyParamete = @{@"paramete":composeModel.url};
        }
        composeModel.topImage = [UIImage imageNamed:self.composeImageS[i]];
        POrderCellCompose * composeView = self.bottomViewContainer.subviews[i];
        
        //        if ([composeModel.actionKey isEqualToString:@"pay"]){//没有actiongkey , 就用数组下标吧
        //            composeModel.actionKey = ActionPendingPay;
        //        }else if ([composeModel.actionKey isEqualToString:@"ship"]){
        //            composeModel.actionKey = ActionPendingSend;
        //        }else if ([composeModel.actionKey isEqualToString:@"receive"]){
        //            composeModel.actionKey = ActionPendingReceive;
        //        }else if ([composeModel.actionKey isEqualToString:@"comment"]){
        //            composeModel.actionKey = ActionPendingAppraise;
        //        }else if ([composeModel.actionKey isEqualToString:@"over"]){
        //            composeModel.actionKey = ActionAfterCost;
        //        }
        composeModel.actionKey = self.subCompenentActionKeys[i];
        
        composeView.orderComposeModel = composeModel;
        //        [self.subCompenentTitles addObject:composeModel.title];
    }
    
    //    self.sectionHeaderView.leftTitle = cellModel.title;
    //    BaseModel * sectionHeaderViewModel = [[BaseModel alloc]init];
    //    sectionHeaderViewModel.title =cellModel.title;
    //    sectionHeaderViewModel.judge=cellModel.judge;
    //    sectionHeaderViewModel.actionKey = cellModel.actionKey;
    
    self.sectionHeaderView.sectionHeaderModel = cellModel;
    
}
//-(void)setCellTitle:(NSString *)cellTitle{
//    _cellTitle = cellTitle;
//    self.sectionHeaderView.title = cellTitle;
//
//}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

-(void)headerClickWith:(PSectionHeaderView*)sender
{
    if ([self.PCellDelegate respondsToSelector:@selector(actionWithModel:)]) {
        [self.PCellDelegate actionWithModel:sender.sectionHeaderModel];
    }
}
-(void)customDetailCellClickWith:(POrderCellCompose *)sender{
    
    if ([self.PCellDelegate respondsToSelector:@selector(actionWithModel:)]) {
        [self.PCellDelegate actionWithModel:sender.orderComposeModel];
    }
}
//-(void)profileSectionHeaderClickWith:(ActionBaseView *)sender{
//
//}
-(NSMutableArray * )subCompenentTitles{
    if(_subCompenentTitles==nil){
        _subCompenentTitles =[NSMutableArray arrayWithArray: @[@"优惠券",@"余额",@"L币"]];
    }
    return _subCompenentTitles;
}
/**
 static  NSString * ActionCoupon = @"ActionCoupon";
 static  NSString * ActionBalance = @"ActionBalance";
 static  NSString * ActionCardPackage = @"ActionCardPackage";
 static  NSString * ActionLBi = @"ActionLBi";
 */
-(NSMutableArray * )subCompenentActionKeys{
    if(_subCompenentActionKeys==nil){
        _subCompenentActionKeys =[NSMutableArray arrayWithArray: @[ActionBalance,ActionCoupon,ActionLBi]];
    }
    return _subCompenentActionKeys;
}
-(NSMutableArray * )composeImageS{
    if(_composeImageS==nil){
        _composeImageS =[NSMutableArray arrayWithArray: @[@"icon_balance",@"icon_coupon",@"icon_Lcoin"]];
    }
    return _composeImageS;
}
@end







































////
////  PAssetsCell.m
////  b2c
////
////  Created by wangyuanfei on 3/30/16.
////  Copyright © 2016 www.16lao.com. All rights reserved.
////
//
//#import "PAssetsCell.h"
//
//#import "PTableCellModel.h"
//#import "PSectionHeaderView.h"
//#import "POrderCellCompose.h"
//#import "POrderCellComposeModel.h"
//@interface PAssetsCell()//<CustomDetailCellDelegate>
//@property(nonatomic,weak)UIView * topViewContainer ;
//@property(nonatomic,weak)UIView * midLine ;
//@property(nonatomic,weak)UIView * bottomViewContainer ;
//@property(nonatomic,weak)UIView * bottomLine ;
//@property(nonatomic,weak)PSectionHeaderView * sectionHeaderView ;
//@property(nonatomic,strong)NSMutableArray * subCompenentTitles ;
//@property(nonatomic,strong)NSMutableArray * subCompenentActionKeys ;
//@property(nonatomic,strong)NSMutableArray * composeImageS ;
//@end
//
//@implementation PAssetsCell
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
//    UIView * topViewContainer = [[UIView alloc]init];
//    self.topViewContainer = topViewContainer;
//    [self.contentView addSubview:topViewContainer];
////    topViewContainer.backgroundColor = randomColor;
//    
//
//    UIView * midLine = [[UIView alloc]init];
//    self.midLine=midLine;
//    [self.contentView addSubview:self.midLine];
//    self.midLine.backgroundColor=BackgroundGray;
//    
//    
//    UIView * bottomViewContainer = [[UIView alloc]init];
//    self.bottomViewContainer = bottomViewContainer;
//    [self.contentView addSubview:bottomViewContainer];
////    bottomViewContainer.backgroundColor = randomColor;
//    
//    UIView * bottomLine = [[UIView alloc]init];
//    self.bottomLine=bottomLine;
//    [self.contentView addSubview:self.bottomLine];
//    self.bottomLine.backgroundColor=BackgroundGray;
//    
//    PSectionHeaderView * sectionHeader = [[PSectionHeaderView alloc]init];
//    self.sectionHeaderView = sectionHeader;
//    [sectionHeader addTarget:self action:@selector(headerClickWith:) forControlEvents:UIControlEventTouchUpInside];
////    sectionHeader.CustomDetailCellDelegate = self;
////    sectionHeader.backgroundColor = randomColor;
////    BaseModel * sectionHeaderModel = [[BaseModel alloc]init];
////    sectionHeaderModel.actionKey=  ActionPAssetsSection;
////    sectionHeader.model = sectionHeaderModel;
//    [self.topViewContainer addSubview:sectionHeader];
//    
//    for (int i = 0 ;  i < self.subCompenentTitles.count; i++) {
//        POrderCellCompose * sub = [[POrderCellCompose alloc]init];
//        POrderCellComposeModel * model= [[POrderCellComposeModel alloc]init];
//        model.botomTitle = self.subCompenentTitles[i];
//        model.topImage = [UIImage imageNamed:self.composeImageS[i]];
//        model.actionKey=self.subCompenentActionKeys[i];
//        model.judge=YES;
//        sub.orderComposeModel = model;
//        [self.bottomViewContainer addSubview:sub];
//        [sub addTarget:self action:@selector(customDetailCellClickWith:) forControlEvents:UIControlEventTouchUpInside];
//    }
//}
//-(void)layoutSubviews{
//    CGFloat  W = self.bottomViewContainer.bounds.size.width/self.bottomViewContainer.subviews.count;
//    CGFloat H = self.bottomViewContainer.bounds.size.height;
//    for (int i = 0 ; i < self.bottomViewContainer.subviews.count; i ++) {
//        ActionBaseView * sub = self.bottomViewContainer.subviews[i];
//        sub.frame = CGRectMake(i * W, 0, W, H);
//    }
//    
//}
//-(void)layoutsubviews
//{
//
//    [self.topViewContainer mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.right.equalTo(self.contentView);
//        make.height.equalTo(@(45*SCALE));
//    }];
//    
//    [self.midLine mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.topViewContainer.mas_bottom);
//        make.left.right.equalTo(self.topViewContainer);
//        make.height.equalTo(@(1*SCALE));
//    }];
//    
//    
//    [self.bottomViewContainer mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(self.midLine);
//        make.top.equalTo(self.midLine.mas_bottom);
//        make.height.equalTo(@(78*SCALE));
//    }];
//    
//    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.bottomViewContainer.mas_bottom);
//        make.left.right.equalTo(self.bottomViewContainer);
//        make.height.equalTo(@(20*SCALE));
//    }];
//    
//    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(self.bottomLine.mas_bottom);
//        make.left.right.equalTo(self);
//    }]; 
//    
//    [self.sectionHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.right.bottom.right.equalTo(self.topViewContainer);
//    }];
//    
//}
//-(void)setCellModel:(PTableCellModel *)cellModel{
//    _cellModel = cellModel;
//    
//    
//    
//    [self.subCompenentTitles removeAllObjects];
//    
//    for (int i = 0; i< cellModel.items.count; i++) {
//        POrderCellComposeModel * composeModel = cellModel.items[i];
//        composeModel.judge = YES;
//        if (composeModel.url) {
//            composeModel.keyParamete = @{@"paramete":composeModel.url};
//        }
//        composeModel.topImage = [UIImage imageNamed:self.composeImageS[i]];
//        POrderCellCompose * composeView = self.bottomViewContainer.subviews[i];
//        
////        if ([composeModel.actionKey isEqualToString:@"pay"]){//没有actiongkey , 就用数组下标吧
////            composeModel.actionKey = ActionPendingPay;
////        }else if ([composeModel.actionKey isEqualToString:@"ship"]){
////            composeModel.actionKey = ActionPendingSend;
////        }else if ([composeModel.actionKey isEqualToString:@"receive"]){
////            composeModel.actionKey = ActionPendingReceive;
////        }else if ([composeModel.actionKey isEqualToString:@"comment"]){
////            composeModel.actionKey = ActionPendingAppraise;
////        }else if ([composeModel.actionKey isEqualToString:@"over"]){
////            composeModel.actionKey = ActionAfterCost;
////        }
//        composeModel.actionKey = self.subCompenentActionKeys[i];
//        
//        composeView.orderComposeModel = composeModel;
//        //        [self.subCompenentTitles addObject:composeModel.title];
//    }
//
////    self.sectionHeaderView.leftTitle = cellModel.title;
////    BaseModel * sectionHeaderViewModel = [[BaseModel alloc]init];
////    sectionHeaderViewModel.title =cellModel.title;
////    sectionHeaderViewModel.judge=cellModel.judge;
////    sectionHeaderViewModel.actionKey = cellModel.actionKey;
//    
//    self.sectionHeaderView.sectionHeaderModel = cellModel;
//
//}
////-(void)setCellTitle:(NSString *)cellTitle{
////    _cellTitle = cellTitle;
////    self.sectionHeaderView.title = cellTitle;
////    
////}
//
//
///*
//// Only override drawRect: if you perform custom drawing.
//// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect {
//    // Drawing code
//}
//*/
//
//-(void)headerClickWith:(PSectionHeaderView*)sender
//{
//    if ([self.PCellDelegate respondsToSelector:@selector(actionWithModel:)]) {
//        [self.PCellDelegate actionWithModel:sender.sectionHeaderModel];
//    }
//}
//-(void)customDetailCellClickWith:(POrderCellCompose *)sender{
//
//    if ([self.PCellDelegate respondsToSelector:@selector(actionWithModel:)]) {
//        [self.PCellDelegate actionWithModel:sender.orderComposeModel];
//    }
//}
////-(void)profileSectionHeaderClickWith:(ActionBaseView *)sender{
////
////}
//-(NSMutableArray * )subCompenentTitles{
//    if(_subCompenentTitles==nil){
//        _subCompenentTitles =[NSMutableArray arrayWithArray: @[@"优惠券",@"余额",@"L币"]];
//    }
//    return _subCompenentTitles;
//}
///**
// static  NSString * ActionCoupon = @"ActionCoupon";
// static  NSString * ActionBalance = @"ActionBalance";
// static  NSString * ActionCardPackage = @"ActionCardPackage";
// static  NSString * ActionLBi = @"ActionLBi";
// */
//-(NSMutableArray * )subCompenentActionKeys{
//    if(_subCompenentActionKeys==nil){
//        _subCompenentActionKeys =[NSMutableArray arrayWithArray: @[ActionBalance,ActionCoupon,ActionLBi]];
//    }
//    return _subCompenentActionKeys;
//}
//-(NSMutableArray * )composeImageS{
//    if(_composeImageS==nil){
//        _composeImageS =[NSMutableArray arrayWithArray: @[@"icon_balance",@"icon_coupon",@"icon_Lcoin"]];
//    }
//    return _composeImageS;
//}
//@end
