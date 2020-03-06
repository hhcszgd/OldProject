//
//  HLaoCell.m
//  b2c
//
//  Created by wangyuanfei on 4/12/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "HLaoCell.h"
#import "HLaoCellComposeView.h"

#import "CustomDetailCell.h"

@interface HLaoCell()
//@property(nonatomic,weak)CustomDetailCell * topImageView ;
@property(nonatomic,weak)UIView * container ;

@end

@implementation HLaoCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //        self.backgroundColor = [UIColor greenColor];
        CustomDetailCell * topImageView = [[CustomDetailCell alloc]init];
        topImageView.arrowHidden=YES;
        self.topImageView = topImageView ;
        topImageView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:topImageView];
        //        self.topImageView.backgroundColor = randomColor;
        
        UIView * container = [[UIView alloc]init];
        //        container.backgroundColor = randomColor;
        self.container = container;
        [self.contentView addSubview:container];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat midMargin = 1 ;
    CGFloat topBottomMargin = 1 ;
    CGFloat oneH  = 75.5*SCALE ;
    CGFloat oneW  = (self.bounds.size.width - midMargin)/2;
    
    CGFloat topImageViewH = 38*SCALE ;
    
    CGFloat totalTopMargin = 10*SCALE;
    
    self.topImageView.frame = CGRectMake(0, totalTopMargin, self.bounds.size.width, topImageViewH);
    self.container.frame = CGRectMake(0, totalTopMargin + topImageViewH + midMargin, self.bounds.size.width, self.bounds.size.height - (totalTopMargin + topImageViewH + midMargin));
    //    CGFloat totalH = 0;
    for (int i = 0 ; i < self.container.subviews.count; i ++) {
        HLaoCellComposeView * sub  = self.container.subviews[i];
        CGFloat subX = (oneW+midMargin) * (i%2);
        CGFloat subY = topBottomMargin + (topBottomMargin + oneH) * (i / 2);
        CGFloat subW = oneW;
        CGFloat subH = oneH;
        sub.frame = CGRectMake(subX, subY, subW, subH);
    }
}

-(void)setCellModel:(HCellModel *)cellModel{
    [super setCellModel:cellModel];
    
    if ( self.container.subviews.count==0 || self.container.subviews.count != cellModel.items.count) {//当网络数据返回个数改变时
        
        
        //        CGFloat topImageViewX = 0 ;
        //        CGFloat topImageViewY = 0 ;
        //        CGFloat topImageViewW = self.bounds.size.width;
        CGFloat topImageViewH = 38*SCALE ;
        
        //        CGFloat midMargin = 1 ;
        CGFloat topBottomMargin = 1 ;
        CGFloat oneH  = 75.5*SCALE ;
        //        CGFloat oneW  = (self.bounds.size.width - midMargin)/2;
        CGFloat totalH = 0;
        CGFloat totalTopMargin = 10*SCALE;
        if (cellModel.items.count%2 ==0) {
            totalH = (oneH + topBottomMargin) * cellModel.items.count/2;
        }else{
            totalH = ((oneH + topBottomMargin)) * (cellModel.items.count/2 +1);
        }
        //移除原有的所有约束
        //        NSArray * containerConstraints = self.container.constraints;
        //        [self.container removeConstraints:containerConstraints];
        //
        //        NSArray * topImageViewConstraints = self.topImageView.constraints;
        //        [self.topImageView removeConstraints:topImageViewConstraints];
        
        NSArray *  containtViewConstraints  =self.contentView.constraints ;
        [self.contentView removeConstraints:containtViewConstraints];
        //移除容器视图的所有子控件
        [self.container.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
        }];
        //        for (int i = 0 ; i< self.container.subviews.count;i++) {//fuck 这个方法不行 , i值会跳 , 子控件删不完
        //            UIView * sub = self.container.subviews[i];
        //            [sub removeFromSuperview];
        //        }
        
        LOG(@"_%@_%d_%@",[self class] , __LINE__,self.container.subviews);
        
        
        
        //重新约束
        //        [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.top.equalTo(self.contentView).offset(totalTopMargin);
        //            make.left.right.equalTo(self.contentView);
        //            make.height.equalTo(@(topImageViewH));
        //        }];
        //
        //
        //        [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.left.right.equalTo(self.topImageView);
        //            make.top.equalTo(self.topImageView.mas_bottom).offset(1);
        //            make.height.equalTo(@(totalH));
        //        }];
        //        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.left.right.equalTo(self);
        //            make.bottom.equalTo(self.container);
        //        }];
        //        //重新添加
        
        
        for (int i = 0 ; i< cellModel.items.count; i++) {
            HLaoCellComposeView * sub = [[HLaoCellComposeView alloc]init];
            [sub addTarget:self action:@selector(composeClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.container addSubview:sub];
            //            sub.composeModel = cellModel.items[i];
        }
    }
    
    
    
    
    //每次刷新tabView的重新赋值
    for (int i = 0 ; i< cellModel.items.count ; i++) {
        HLaoCellComposeView*sub =self.container.subviews[i];
        sub.composeModel = cellModel.items[i];
    }
    
    if ([cellModel.imgStr hasPrefix:@"http"]){
        //        [self.topImageView.customBackgroundImageView sd_setImageWithURL:[NSURL URLWithString:cellModel.imgStr] placeholderImage:nil options:SDWebImageCacheMemoryOnly];
        self.topImageView.backImageURL = [NSURL URLWithString:cellModel.imgStr];
    }else{
        //        [self.topImageView.customBackgroundImageView sd_setImageWithURL:ImageUrlWithString(cellModel.imgStr)  placeholderImage:nil options:SDWebImageCacheMemoryOnly];
        self.topImageView.backImageURL = ImageUrlWithString(cellModel.imgStr)  ;
    }
    
    //    [self setNeedsLayout];
    //    [self layoutIfNeeded];
}









//-(void)setCellModel:(HCellModel *)cellModel{
//    [super setCellModel:cellModel];
//
//    //    if ( self.container.subviews.count==0 || self.container.subviews.count != cellModel.items.count) {//当网络数据返回个数改变时
//
//
//    //        CGFloat topImageViewX = 0 ;
//    //        CGFloat topImageViewY = 0 ;
//    //        CGFloat topImageViewW = self.bounds.size.width;
//    CGFloat topImageViewH = 38*SCALE ;
//
//    //        CGFloat midMargin = 1 ;
//    CGFloat topBottomMargin = 1 ;
//    CGFloat oneH  = 75.5*SCALE ;
//    //        CGFloat oneW  = (self.bounds.size.width - midMargin)/2;
//    CGFloat totalH = 0;
//    CGFloat totalTopMargin = 10*SCALE;
//    if (cellModel.items.count%2 ==0) {
//        totalH = (oneH + topBottomMargin) * cellModel.items.count/2;
//    }else{
//        totalH = ((oneH + topBottomMargin)) * (cellModel.items.count/2 +1);
//    }
//    //移除原有的所有约束
//    NSArray * containerConstraints = self.container.constraints;
//    [self.container removeConstraints:containerConstraints];
//
//    NSArray * topImageViewConstraints = self.topImageView.constraints;
//    [self.topImageView removeConstraints:topImageViewConstraints];
//
//    NSArray *  containtViewConstraints  =self.contentView.constraints ;
//    [self.contentView removeConstraints:containtViewConstraints];
//    //移除容器视图的所有子控件
//    [self.container.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        [obj removeFromSuperview];
//    }];
//    //        for (int i = 0 ; i< self.container.subviews.count;i++) {//fuck 这个方法不行 , i值会跳 , 子控件删不玩
//    //            UIView * sub = self.container.subviews[i];
//    //            [sub removeFromSuperview];
//    //        }
//
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,self.container.subviews);
//
//
//
//    //重新约束
//    [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.contentView).offset(totalTopMargin);
//        make.left.right.equalTo(self.contentView);
//        make.height.equalTo(@(topImageViewH));
//    }];
//
//
//    [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(self.topImageView);
//        make.top.equalTo(self.topImageView.mas_bottom).offset(1);
//        make.height.equalTo(@(totalH));
//    }];
//    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(self);
//        make.bottom.equalTo(self.container);
//    }];
//    //重新添加
//
//
//    for (int i = 0 ; i< cellModel.items.count; i++) {
//        HLaoCellComposeView * sub = [[HLaoCellComposeView alloc]init];
//        [sub addTarget:self action:@selector(composeClick:) forControlEvents:UIControlEventTouchUpInside];
//        [self.container addSubview:sub];
//        sub.composeModel = cellModel.items[i];
//    }
//    //    }
//
//
//
//
//    //每次刷新tabView的重新赋值
//    //    for (int i = 0 ; i< cellModel.items.count ; i++) {
//    //        HLaoCellComposeView*sub =self.container.subviews[i];
//    //        sub.composeModel = cellModel.items[i];
//    //    }
//
//    if ([cellModel.imgStr hasPrefix:@"http"]){
//        //        [self.topImageView.customBackgroundImageView sd_setImageWithURL:[NSURL URLWithString:cellModel.imgStr] placeholderImage:nil options:SDWebImageCacheMemoryOnly];
//        self.topImageView.backImageURL = [NSURL URLWithString:cellModel.imgStr];
//    }else{
//        //        [self.topImageView.customBackgroundImageView sd_setImageWithURL:ImageUrlWithString(cellModel.imgStr)  placeholderImage:nil options:SDWebImageCacheMemoryOnly];
//        self.topImageView.backImageURL = ImageUrlWithString(cellModel.imgStr)  ;
//    }
//    
//    [self setNeedsLayout];
//    [self layoutIfNeeded];
//}



@end


























































////
////  HLaoCell.m
////  b2c
////
////  Created by wangyuanfei on 4/12/16.
////  Copyright © 2016 www.16lao.com. All rights reserved.
////
//
//#import "HLaoCell.h"
//#import "HLaoCellComposeView.h"
//
//#import "CustomDetailCell.h"
//
//@interface HLaoCell()
////@property(nonatomic,weak)CustomDetailCell * topImageView ;
//@property(nonatomic,weak)UIView * container ;
//
//@end
//
//@implementation HLaoCell
//
//
//-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
//    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
////        self.backgroundColor = [UIColor greenColor];
//        CustomDetailCell * topImageView = [[CustomDetailCell alloc]init];
//        topImageView.arrowHidden=YES;
//        self.topImageView = topImageView ;
//        topImageView.backgroundColor = [UIColor whiteColor];
//        [self.contentView addSubview:topImageView];
////        self.topImageView.backgroundColor = randomColor;
//        
//        UIView * container = [[UIView alloc]init];
////        container.backgroundColor = randomColor;
//        self.container = container;
//        [self.contentView addSubview:container];
//    }
//    return self;
//}
//-(void)layoutSubviews{
//    [super layoutSubviews];
//    CGFloat midMargin = 1 ;
//    CGFloat topBottomMargin = 1 ;
//    CGFloat oneH  = 75.5*SCALE ;
//    CGFloat oneW  = (self.bounds.size.width - midMargin)/2;
////    CGFloat totalH = 0;
//    for (int i = 0 ; i < self.container.subviews.count; i ++) {
//        HLaoCellComposeView * sub  = self.container.subviews[i];
//        CGFloat subX = (oneW+midMargin) * (i%2);
//        CGFloat subY = topBottomMargin + (topBottomMargin + oneH) * (i / 2);
//        CGFloat subW = oneW;
//        CGFloat subH = oneH;
//        sub.frame = CGRectMake(subX, subY, subW, subH);
//    }
//}
//
//-(void)setCellModel:(HCellModel *)cellModel{
//    [super setCellModel:cellModel];
//    
//    if ( self.container.subviews.count==0 || self.container.subviews.count != cellModel.items.count) {//当网络数据返回个数改变时
//    
//
////        CGFloat topImageViewX = 0 ;
////        CGFloat topImageViewY = 0 ;
////        CGFloat topImageViewW = self.bounds.size.width;
//        CGFloat topImageViewH = 38*SCALE ;
//        
////        CGFloat midMargin = 1 ;
//        CGFloat topBottomMargin = 1 ;
//        CGFloat oneH  = 75.5*SCALE ;
////        CGFloat oneW  = (self.bounds.size.width - midMargin)/2;
//        CGFloat totalH = 0;
//        CGFloat totalTopMargin = 10*SCALE;
//        if (cellModel.items.count%2 ==0) {
//            totalH = (oneH + topBottomMargin) * cellModel.items.count/2;
//        }else{
//            totalH = ((oneH + topBottomMargin)) * (cellModel.items.count/2 +1);
//        }
//        //移除原有的所有约束
//        NSArray * containerConstraints = self.container.constraints;
//        [self.container removeConstraints:containerConstraints];
//        
//        NSArray * topImageViewConstraints = self.topImageView.constraints;
//        [self.topImageView removeConstraints:topImageViewConstraints];
//        
//         NSArray *  containtViewConstraints  =self.contentView.constraints ;
//        [self.contentView removeConstraints:containtViewConstraints];
//        //移除容器视图的所有子控件
//        [self.container.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            [obj removeFromSuperview];
//        }];
////        for (int i = 0 ; i< self.container.subviews.count;i++) {//fuck 这个方法不行 , i值会跳 , 子控件删不完
////            UIView * sub = self.container.subviews[i];
////            [sub removeFromSuperview];
////        }
//    
//        LOG(@"_%@_%d_%@",[self class] , __LINE__,self.container.subviews);
//        
//        
//        
//        //重新约束
//        [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.contentView).offset(totalTopMargin);
//            make.left.right.equalTo(self.contentView);
//            make.height.equalTo(@(topImageViewH));
//        }];
//        
//        
//        [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.right.equalTo(self.topImageView);
//            make.top.equalTo(self.topImageView.mas_bottom).offset(1);
//            make.height.equalTo(@(totalH));
//        }];
//        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.right.equalTo(self);
//            make.bottom.equalTo(self.container);
//        }];
//        //重新添加
//        
//        
//        for (int i = 0 ; i< cellModel.items.count; i++) {
//            HLaoCellComposeView * sub = [[HLaoCellComposeView alloc]init];
//            [sub addTarget:self action:@selector(composeClick:) forControlEvents:UIControlEventTouchUpInside];
//            [self.container addSubview:sub];
////            sub.composeModel = cellModel.items[i];
//        }
//    }
//    
//    
//    
//    
//    //每次刷新tabView的重新赋值
//    for (int i = 0 ; i< cellModel.items.count ; i++) {
//        HLaoCellComposeView*sub =self.container.subviews[i];
//        sub.composeModel = cellModel.items[i];
//    }
//
//    if ([cellModel.imgStr hasPrefix:@"http"]){
//        //        [self.topImageView.customBackgroundImageView sd_setImageWithURL:[NSURL URLWithString:cellModel.imgStr] placeholderImage:nil options:SDWebImageCacheMemoryOnly];
//        self.topImageView.backImageURL = [NSURL URLWithString:cellModel.imgStr];
//    }else{
//        //        [self.topImageView.customBackgroundImageView sd_setImageWithURL:ImageUrlWithString(cellModel.imgStr)  placeholderImage:nil options:SDWebImageCacheMemoryOnly];
//        self.topImageView.backImageURL = ImageUrlWithString(cellModel.imgStr)  ;
//    }
//    
////    [self setNeedsLayout];
////    [self layoutIfNeeded];
//}
//
//
//
//
//
//
//
//
//
////-(void)setCellModel:(HCellModel *)cellModel{
////    [super setCellModel:cellModel];
////    
////    //    if ( self.container.subviews.count==0 || self.container.subviews.count != cellModel.items.count) {//当网络数据返回个数改变时
////    
////    
////    //        CGFloat topImageViewX = 0 ;
////    //        CGFloat topImageViewY = 0 ;
////    //        CGFloat topImageViewW = self.bounds.size.width;
////    CGFloat topImageViewH = 38*SCALE ;
////    
////    //        CGFloat midMargin = 1 ;
////    CGFloat topBottomMargin = 1 ;
////    CGFloat oneH  = 75.5*SCALE ;
////    //        CGFloat oneW  = (self.bounds.size.width - midMargin)/2;
////    CGFloat totalH = 0;
////    CGFloat totalTopMargin = 10*SCALE;
////    if (cellModel.items.count%2 ==0) {
////        totalH = (oneH + topBottomMargin) * cellModel.items.count/2;
////    }else{
////        totalH = ((oneH + topBottomMargin)) * (cellModel.items.count/2 +1);
////    }
////    //移除原有的所有约束
////    NSArray * containerConstraints = self.container.constraints;
////    [self.container removeConstraints:containerConstraints];
////    
////    NSArray * topImageViewConstraints = self.topImageView.constraints;
////    [self.topImageView removeConstraints:topImageViewConstraints];
////    
////    NSArray *  containtViewConstraints  =self.contentView.constraints ;
////    [self.contentView removeConstraints:containtViewConstraints];
////    //移除容器视图的所有子控件
////    [self.container.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
////        [obj removeFromSuperview];
////    }];
////    //        for (int i = 0 ; i< self.container.subviews.count;i++) {//fuck 这个方法不行 , i值会跳 , 子控件删不玩
////    //            UIView * sub = self.container.subviews[i];
////    //            [sub removeFromSuperview];
////    //        }
////    
////    LOG(@"_%@_%d_%@",[self class] , __LINE__,self.container.subviews);
////    
////    
////    
////    //重新约束
////    [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.top.equalTo(self.contentView).offset(totalTopMargin);
////        make.left.right.equalTo(self.contentView);
////        make.height.equalTo(@(topImageViewH));
////    }];
////    
////    
////    [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.left.right.equalTo(self.topImageView);
////        make.top.equalTo(self.topImageView.mas_bottom).offset(1);
////        make.height.equalTo(@(totalH));
////    }];
////    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.left.right.equalTo(self);
////        make.bottom.equalTo(self.container);
////    }];
////    //重新添加
////    
////    
////    for (int i = 0 ; i< cellModel.items.count; i++) {
////        HLaoCellComposeView * sub = [[HLaoCellComposeView alloc]init];
////        [sub addTarget:self action:@selector(composeClick:) forControlEvents:UIControlEventTouchUpInside];
////        [self.container addSubview:sub];
////        sub.composeModel = cellModel.items[i];
////    }
////    //    }
////    
////    
////    
////    
////    //每次刷新tabView的重新赋值
////    //    for (int i = 0 ; i< cellModel.items.count ; i++) {
////    //        HLaoCellComposeView*sub =self.container.subviews[i];
////    //        sub.composeModel = cellModel.items[i];
////    //    }
////    
////    if ([cellModel.imgStr hasPrefix:@"http"]){
////        //        [self.topImageView.customBackgroundImageView sd_setImageWithURL:[NSURL URLWithString:cellModel.imgStr] placeholderImage:nil options:SDWebImageCacheMemoryOnly];
////        self.topImageView.backImageURL = [NSURL URLWithString:cellModel.imgStr];
////    }else{
////        //        [self.topImageView.customBackgroundImageView sd_setImageWithURL:ImageUrlWithString(cellModel.imgStr)  placeholderImage:nil options:SDWebImageCacheMemoryOnly];
////        self.topImageView.backImageURL = ImageUrlWithString(cellModel.imgStr)  ;
////    }
////    
////    [self setNeedsLayout];
////    [self layoutIfNeeded];
////}
//
//
//
//@end
