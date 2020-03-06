//
//  POrderCell.m
//  b2c
//
//  Created by wangyuanfei on 3/30/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "POrderCell.h"
#import "PSectionHeaderView.h"
#import "PTableCellModel.h"
#import "POrderCellComposeModel.h"
#import "POrderCellCompose.h"
@interface POrderCell ()//<CustomDetailCellDelegate>
@property(nonatomic,weak)UIView * topViewContainer ;
@property(nonatomic,weak)UIView * midLine ;
@property(nonatomic,weak)UIView * bottomViewContainer ;
@property(nonatomic,weak)UIView * bottomLine ;
@property(nonatomic,weak)PSectionHeaderView * sectionHeaderView ;
@property(nonatomic,strong)NSMutableArray  * subCompenentTitles ;
@property(nonatomic,strong)NSMutableArray * subCompenentActionKeys ;
@property(nonatomic,strong)NSMutableArray * composeImageS ;
@end


@implementation POrderCell


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
    //     topViewContainer.backgroundColor = randomColor;
    
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
    [sectionHeader addTarget:self action:@selector(profileSectionHeaderClickWith:) forControlEvents:UIControlEventTouchUpInside];
    //    sectionHeader.leftTitleFont = [UIFont systemFontOfSize:10];
    self.sectionHeaderView = sectionHeader;
    //    sectionHeader.backgroundColor = randomColor;
    [self.topViewContainer addSubview:sectionHeader];
    /**
     //添加监听者
     [self.tableView addObserver: self forKeyPath: @"contentOffset" options: NSKeyValueObservingOptionNew context: nil];
     
     // 监听属性值发生改变时回调
     
     - (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
     {
     CGFloat offset = self.tableView.contentOffset.y;
     CGFloat delta = offset / 64.f + 1.f;
     delta = MAX(0, delta);
     [self alphaNavController].barAlpha = MIN(1, delta);
     }
     */
    
    for (int i = 0 ;  i < 5; i++) {
        POrderCellCompose * sub = [[POrderCellCompose alloc]init];
        POrderCellComposeModel * model= [[POrderCellComposeModel alloc]init];
        model.botomTitle = self.subCompenentTitles[i];
        model.actionKey=self.subCompenentActionKeys[i];
        model.judge=YES;
        model.topImage=[UIImage imageNamed:self.composeImageS[i]];
        model.cornerCount = i*3 ;
        sub.orderComposeModel = model;
        [self.bottomViewContainer addSubview:sub];
        [sub addTarget:self action:@selector(componentClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    ///////////////模型问题
}


-(void)profileSectionHeaderClickWith:(PSectionHeaderView * )sender
{
    //    LOG(@"_%@_%d_%ld",[self class] , __LINE__,sender.state)
    if ([self.PCellDelegate respondsToSelector:@selector(actionWithModel:)]) {
        [self.PCellDelegate actionWithModel:sender.sectionHeaderModel];
    }
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
        //        composeModel.actionKey = self.subCompenentActionKeys[i];
        if ([composeModel.actionKey isEqualToString:@"pay"]){
            composeModel.actionKey = ActionPendingPay;
        }else if ([composeModel.actionKey isEqualToString:@"ship"]){
            composeModel.actionKey = ActionPendingSend;
        }else if ([composeModel.actionKey isEqualToString:@"receive"]){
            composeModel.actionKey = ActionPendingReceive;
        }else if ([composeModel.actionKey isEqualToString:@"comment"]){
            composeModel.actionKey = ActionPendingAppraise;
        }else if ([composeModel.actionKey isEqualToString:@"over"]){
            composeModel.actionKey = ActionAfterCost;
        }
        POrderCellCompose * composeView = self.bottomViewContainer.subviews[i];
        composeView.orderComposeModel = composeModel;
        //        [self.subCompenentTitles addObject:composeModel.title];
    }
    //    self.sectionHeaderView.title = cellModel.title;
    //    self.cellTitle = cellModel.title;
    //    BaseModel *sectionHeaderViewModel = [[BaseModel alloc]init];
    //    sectionHeaderViewModel.actionKey = cellModel.actionKey;
    //    sectionHeaderViewModel.title=cellModel.title;
    //    sectionHeaderViewModel.judge=cellModel.judge;
    ////    self.sectionHeaderView.model= sectionHeaderViewModel;
    //    self.sectionHeaderView.leftImage = cellModel.leftImage;
    //    self.sectionHeaderView.leftTitle = cellModel.leftTitle;
    self.sectionHeaderView.sectionHeaderModel = cellModel;
    
    
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
        POrderCellCompose * sub = self.bottomViewContainer.subviews[i];
        sub.frame = CGRectMake(i * W, 0, W, H);
    }
    
}
////////////////////////////////////
-(void)componentClick:(POrderCellCompose *)sender{
    if ([self.PCellDelegate respondsToSelector:@selector(actionWithModel:)]) {
        [self.PCellDelegate actionWithModel:sender.orderComposeModel];
    }
    
}
-(void)setCellTitle:(NSString *)cellTitle{
    
    _cellTitle = cellTitle;
    if (cellTitle&&cellTitle.length>0) {
        self.sectionHeaderView.leftTitle=cellTitle;
    }
}
//-(void)sectionHeaderClick:(PSectionHeaderView*)sender
//{
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,sender)
//}
/**
 static  NSString * ActionPendingPay = @"ActionPendingPay";
 static  NSString * ActionPendingSend = @"ActionPendingSend";
 static  NSString * ActionPendingReceive = @"ActionPendingReceive";
 static  NSString * ActionPendingAppraise = @"ActionPendingAppraise";
 static  NSString * ActionAfterCost = @"ActionAfterCost";
 */
-(NSMutableArray * )subCompenentTitles{
    if(_subCompenentTitles==nil){
        _subCompenentTitles =[NSMutableArray arrayWithArray: @[@"待付款",@"待发货",@"待收货",@"待评价",@"退款/售后"]];
    }
    return _subCompenentTitles;
}
-(NSMutableArray * )subCompenentActionKeys{
    if(_subCompenentActionKeys==nil){
        _subCompenentActionKeys =[NSMutableArray arrayWithArray: @[ActionPendingPay,ActionPendingSend,ActionPendingReceive,ActionPendingAppraise,ActionAfterCost]];
    }
    return _subCompenentActionKeys;
}
-(NSMutableArray * )composeImageS{
    if(_composeImageS==nil){
        _composeImageS = [NSMutableArray arrayWithArray:@[@"icon_After payment",@"icon_To delivery",@"icon_The receipt",@"icon_To evaluate",@"icon_return"]];
    }
    return _composeImageS;
}
@end





































////
////  POrderCell.m
////  b2c
////
////  Created by wangyuanfei on 3/30/16.
////  Copyright © 2016 www.16lao.com. All rights reserved.
////
//
//#import "POrderCell.h"
//#import "PSectionHeaderView.h"
//#import "PTableCellModel.h"
//#import "POrderCellComposeModel.h"
//#import "POrderCellCompose.h"
//@interface POrderCell ()//<CustomDetailCellDelegate>
//@property(nonatomic,weak)UIView * topViewContainer ;
//@property(nonatomic,weak)UIView * midLine ;
//@property(nonatomic,weak)UIView * bottomViewContainer ;
//@property(nonatomic,weak)UIView * bottomLine ;
//@property(nonatomic,weak)PSectionHeaderView * sectionHeaderView ;
//@property(nonatomic,strong)NSMutableArray  * subCompenentTitles ;
//@property(nonatomic,strong)NSMutableArray * subCompenentActionKeys ;
//@property(nonatomic,strong)NSMutableArray * composeImageS ;
//@end
//
//
//@implementation POrderCell
//
//
//-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
//
//    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        [self addsubviews];
//        [self layoutsubviews];
//    }
//    return self;
//}
//-(void)addsubviews
//{
//    UIView * topViewContainer = [[UIView alloc]init];
//    self.topViewContainer = topViewContainer;
//    [self.contentView addSubview:topViewContainer];
////     topViewContainer.backgroundColor = randomColor;
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
//    
//    PSectionHeaderView * sectionHeader = [[PSectionHeaderView alloc]init];
//    [sectionHeader addTarget:self action:@selector(profileSectionHeaderClickWith:) forControlEvents:UIControlEventTouchUpInside];
////    sectionHeader.leftTitleFont = [UIFont systemFontOfSize:10];
//    self.sectionHeaderView = sectionHeader;
////    sectionHeader.backgroundColor = randomColor;
//    [self.topViewContainer addSubview:sectionHeader];
//    /**
//     //添加监听者
//     [self.tableView addObserver: self forKeyPath: @"contentOffset" options: NSKeyValueObservingOptionNew context: nil];
//     
//     // 监听属性值发生改变时回调
//     
//     - (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
//     {
//     CGFloat offset = self.tableView.contentOffset.y;
//     CGFloat delta = offset / 64.f + 1.f;
//     delta = MAX(0, delta);
//     [self alphaNavController].barAlpha = MIN(1, delta);
//     }
//     */
//    
//    for (int i = 0 ;  i < 5; i++) {
//        POrderCellCompose * sub = [[POrderCellCompose alloc]init];
//        POrderCellComposeModel * model= [[POrderCellComposeModel alloc]init];
//        model.botomTitle = self.subCompenentTitles[i];
//        model.actionKey=self.subCompenentActionKeys[i];
//        model.judge=YES;
//        model.topImage=[UIImage imageNamed:self.composeImageS[i]];
//        model.cornerCount = i*3 ;
//        sub.orderComposeModel = model;
//        [self.bottomViewContainer addSubview:sub];
//        [sub addTarget:self action:@selector(componentClick:) forControlEvents:UIControlEventTouchUpInside];
//    }
//
//    ///////////////模型问题
//}
//
//
//-(void)profileSectionHeaderClickWith:(PSectionHeaderView * )sender
//{
////    LOG(@"_%@_%d_%ld",[self class] , __LINE__,sender.state)
//    if ([self.PCellDelegate respondsToSelector:@selector(actionWithModel:)]) {
//        [self.PCellDelegate actionWithModel:sender.sectionHeaderModel];
//    }
//}
//-(void)setCellModel:(PTableCellModel *)cellModel{
//    _cellModel = cellModel;
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
////        composeModel.actionKey = self.subCompenentActionKeys[i];
//        if ([composeModel.actionKey isEqualToString:@"pay"]){
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
//        POrderCellCompose * composeView = self.bottomViewContainer.subviews[i];
//        composeView.orderComposeModel = composeModel;
////        [self.subCompenentTitles addObject:composeModel.title];
//    }
////    self.sectionHeaderView.title = cellModel.title;
////    self.cellTitle = cellModel.title;
////    BaseModel *sectionHeaderViewModel = [[BaseModel alloc]init];
////    sectionHeaderViewModel.actionKey = cellModel.actionKey;
////    sectionHeaderViewModel.title=cellModel.title;
////    sectionHeaderViewModel.judge=cellModel.judge;
//////    self.sectionHeaderView.model= sectionHeaderViewModel;
////    self.sectionHeaderView.leftImage = cellModel.leftImage;
////    self.sectionHeaderView.leftTitle = cellModel.leftTitle;
//    self.sectionHeaderView.sectionHeaderModel = cellModel;
//    
//    
//}
//-(void)layoutsubviews
//{
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
//
//-(void)layoutSubviews{
//    CGFloat  W = self.bottomViewContainer.bounds.size.width/self.bottomViewContainer.subviews.count;
//    CGFloat H = self.bottomViewContainer.bounds.size.height;
//    for (int i = 0 ; i < self.bottomViewContainer.subviews.count; i ++) {
//        POrderCellCompose * sub = self.bottomViewContainer.subviews[i];
//        sub.frame = CGRectMake(i * W, 0, W, H);
//    }
//
//}
//////////////////////////////////////
//-(void)componentClick:(POrderCellCompose *)sender{
//    if ([self.PCellDelegate respondsToSelector:@selector(actionWithModel:)]) {
//        [self.PCellDelegate actionWithModel:sender.orderComposeModel];
//    }
//
//}
//-(void)setCellTitle:(NSString *)cellTitle{
//
//    _cellTitle = cellTitle;
//    if (cellTitle&&cellTitle.length>0) {
//        self.sectionHeaderView.leftTitle=cellTitle;
//    }
//}
////-(void)sectionHeaderClick:(PSectionHeaderView*)sender
////{
////    LOG(@"_%@_%d_%@",[self class] , __LINE__,sender)
////}
///**
// static  NSString * ActionPendingPay = @"ActionPendingPay";
// static  NSString * ActionPendingSend = @"ActionPendingSend";
// static  NSString * ActionPendingReceive = @"ActionPendingReceive";
// static  NSString * ActionPendingAppraise = @"ActionPendingAppraise";
// static  NSString * ActionAfterCost = @"ActionAfterCost";
// */
//-(NSMutableArray * )subCompenentTitles{
//    if(_subCompenentTitles==nil){
//        _subCompenentTitles =[NSMutableArray arrayWithArray: @[@"待付款",@"待发货",@"待收货",@"待评价",@"退款/售后"]];
//    }
//    return _subCompenentTitles;
//}
//-(NSMutableArray * )subCompenentActionKeys{
//    if(_subCompenentActionKeys==nil){
//        _subCompenentActionKeys =[NSMutableArray arrayWithArray: @[ActionPendingPay,ActionPendingSend,ActionPendingReceive,ActionPendingAppraise,ActionAfterCost]];
//    }
//    return _subCompenentActionKeys;
//}
//-(NSMutableArray * )composeImageS{
//    if(_composeImageS==nil){
//        _composeImageS = [NSMutableArray arrayWithArray:@[@"icon_After payment",@"icon_To delivery",@"icon_The receipt",@"icon_To evaluate",@"icon_return"]];
//    }
//    return _composeImageS;
//}
//@end
