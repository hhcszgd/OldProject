//
//  HPostCell.m
//  b2c
//
//  Created by wangyuanfei on 4/11/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "HPostCell.h"
#import "HPostCellComposeView.h"

//#import "<#header#>"
@interface HPostCell()
@property(nonatomic,weak)UIImageView * topImageView ;
@property(nonatomic,weak)UIView * bottomContainer ;


@end


@implementation HPostCell

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIImageView * topImageView = [[UIImageView alloc]init];
        self.topImageView = topImageView;
        [self.contentView addSubview:self.topImageView];
        //        self.topImageView.backgroundColor = randomColor;
        
        
        
        UIView * container = [[UIView alloc]init];
        self.bottomContainer = container;
        [self.contentView addSubview:container];
        //        self.bottomContainer.backgroundColor= randomColor;
        
        
        
        //
        //        CGFloat topImageViewH = 38*SCALE ;
        //        CGFloat totalTopMargin = 11*SCALE ;
        //        CGFloat collectionViewH = 148*SCALE;
        //
        //        [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.top.equalTo(self.contentView).offset(totalTopMargin);
        //            make.left.right.equalTo(self.contentView);
        //            make.height.equalTo(@(topImageViewH));
        //        }];
        //
        //
        //        [self.bottomContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.left.right.equalTo(self.topImageView);
        //            make.top.equalTo(self.topImageView.mas_bottom).offset(1);
        //            make.height.equalTo(@(collectionViewH));
        //        }];
        //        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.left.right.equalTo(self);
        //            make.bottom.equalTo(self.bottomContainer);
        //        }];
        
        
        
        
        
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    //    NSUInteger itemCount = self.bottomContainer.subviews.count ;//目标展示个数
    
    CGFloat topImageViewH = 38*SCALE ;
    CGFloat totalTopMargin = 11*SCALE ;
    CGFloat itemMargin = 1 ;
    CGFloat collectionViewH = 148*SCALE;
    self.topImageView.frame = CGRectMake(0, totalTopMargin, self.bounds.size.width, topImageViewH);
    self.bottomContainer.frame = CGRectMake(0, topImageViewH+totalTopMargin+itemMargin, self.bounds.size.width, collectionViewH);
    
    NSUInteger itemCount = 4 ;//目标展示个数
    CGFloat leftRightMargin = 1 ;
    CGFloat subW = (self.bounds.size.width - (itemCount-1)*leftRightMargin)/itemCount;
    CGFloat subH = self.bottomContainer.bounds.size.height;
    
    for (int i = 0 ;  i< self.bottomContainer.subviews.count; i++) {
        if (i<4) {
            HPostCellComposeView * sub = self.bottomContainer.subviews[i];
            CGFloat subX = (subW+leftRightMargin)*i;
            CGFloat subY = 0;
            sub.frame = CGRectMake(subX, subY, subW, subH);
            
        }
    }
    //根据item个数确定item的宽度
    //    CGFloat leftRightMargin = 1 ;
    //    CGFloat subW = (self.bounds.size.width - (self.bottomContainer.subviews.count-1)*leftRightMargin)/self.bottomContainer.subviews.count;
    //    CGFloat subH = self.bottomContainer.bounds.size.height;
    //
    //    for (int i = 0 ;  i< self.bottomContainer.subviews.count; i++) {
    //        HPostCellComposeView * sub = self.bottomContainer.subviews[i];
    //        CGFloat subX = (subW+leftRightMargin)*i;
    //        CGFloat subY = 0;
    //        sub.frame = CGRectMake(subX, subY, subW, subH);
    //    }
    
}
-(void)setCellModel:(HCellModel *)cellModel{
    [super setCellModel:cellModel];
    
    //    [self.topImageView sd_setImageWithURL:[NSURL URLWithString:cellModel.imgStr] placeholderImage:nil options:SDWebImageCacheMemoryOnly];
    if ([cellModel.imgStr hasPrefix:@"http"]){
        [self.topImageView sd_setImageWithURL:[NSURL URLWithString:cellModel.imgStr] placeholderImage:nil options:SDWebImageCacheMemoryOnly];
    }else{
        [self.topImageView sd_setImageWithURL:ImageUrlWithString(cellModel.imgStr)  placeholderImage:nil options:SDWebImageCacheMemoryOnly];
    }
    //    [self.topImageView sd_setImageWithURL:ImageUrlWithString(cellModel.imgStr) placeholderImage:nil options:SDWebImageCacheMemoryOnly];
    //
    //    LOG(@"_%@_%d_%@",[self class] , __LINE__,cellModel.items);
    
    
    if ( self.bottomContainer.subviews.count==0 || self.bottomContainer.subviews.count != cellModel.items.count) {//当网络数据返回个数改变时
        
        
        [self.bottomContainer.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
        }];
        
        
        for (int i = 0 ; i< cellModel.items.count; i++) {
            if (i<4) {
                
                HPostCellComposeView * sub = [[HPostCellComposeView alloc]init];
                sub.backgroundColor=[UIColor whiteColor];
                [sub addTarget:self action:@selector(composeClick:) forControlEvents:UIControlEventTouchUpInside];
                [self.bottomContainer addSubview:sub];
            }
        }
        
        
        
    }
    
    for (int k = 0 ; k<cellModel.items.count; k++) {
        if (k<4) {
            HPostCellComposeView * sub = self.bottomContainer.subviews[k];
            HCellComposeModel * model =cellModel.items[k];
            //            LOG(@"_%@_%d_%@",[self class] , __LINE__,cellModel.color);
            if (model.ID) {
                model.keyParamete=@{@"paramete":model.ID};
            }
            //        model.theamColor= [UIColor colorWithRed:65/256.0 green:202/256.0 blue:123/256.0 alpha:1];
            model.theamColor = [UIColor colorWithHexString:[cellModel.color stringByReplacingOccurrencesOfString:@"#" withString:@""]];
            model.theamtit=@"包邮";
            sub.composeModel = cellModel.items[k];
            
        }
    }
    
    
    
    
    
    //////////
    
    //    for (UIView * subview in self.bottomContainer.subviews) {
    //        [subview removeFromSuperview];
    //    }
    ////    if (self.bottomContainer.subviews.count==0) {
    //        for (int i = 0 ; i< cellModel.items.count; i++) {
    //            if (i<4) {
    //
    //                HPostCellComposeView * sub = [[HPostCellComposeView alloc]init];
    //                sub.backgroundColor=[UIColor whiteColor];
    //                [sub addTarget:self action:@selector(composeClick:) forControlEvents:UIControlEventTouchUpInside];
    //                [self.bottomContainer addSubview:sub];
    //            }
    //        }
    ////    }
    //
    //    for (int k = 0 ; k<cellModel.items.count; k++) {
    //        if (k<4) {
    //            HPostCellComposeView * sub = self.bottomContainer.subviews[k];
    //            HCellComposeModel * model =cellModel.items[k];
    ////            LOG(@"_%@_%d_%@",[self class] , __LINE__,cellModel.color);
    //            if (model.ID) {
    //                model.keyParamete=@{@"paramete":model.ID};
    //            }
    //            //        model.theamColor= [UIColor colorWithRed:65/256.0 green:202/256.0 blue:123/256.0 alpha:1];
    //            model.theamColor = [UIColor colorWithHexString:[cellModel.color stringByReplacingOccurrencesOfString:@"#" withString:@""]];
    //            model.theamtit=@"包邮";
    //            sub.composeModel = cellModel.items[k];
    //
    //        }
    //    }
    
    //    LOG(@"_%@_%d_%@",[self class] , __LINE__,cellModel.items)
}






//-(void)setCellModel:(HCellModel *)cellModel{
//    [super setCellModel:cellModel];
//
//    //    [self.topImageView sd_setImageWithURL:[NSURL URLWithString:cellModel.imgStr] placeholderImage:nil options:SDWebImageCacheMemoryOnly];
//    if ([cellModel.imgStr hasPrefix:@"http"]){
//        [self.topImageView sd_setImageWithURL:[NSURL URLWithString:cellModel.imgStr] placeholderImage:nil options:SDWebImageCacheMemoryOnly];
//    }else{
//        [self.topImageView sd_setImageWithURL:ImageUrlWithString(cellModel.imgStr)  placeholderImage:nil options:SDWebImageCacheMemoryOnly];
//    }
//    //    [self.topImageView sd_setImageWithURL:ImageUrlWithString(cellModel.imgStr) placeholderImage:nil options:SDWebImageCacheMemoryOnly];
//    //
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,cellModel.items);
//
//
//
//
//
//    for (UIView * subview in self.bottomContainer.subviews) {
//        [subview removeFromSuperview];
//    }
//    //    if (self.bottomContainer.subviews.count==0) {
//    for (int i = 0 ; i< cellModel.items.count; i++) {
//        if (i<4) {
//
//            HPostCellComposeView * sub = [[HPostCellComposeView alloc]init];
//            sub.backgroundColor=[UIColor whiteColor];
//            [sub addTarget:self action:@selector(composeClick:) forControlEvents:UIControlEventTouchUpInside];
//            [self.bottomContainer addSubview:sub];
//        }
//    }
//    //    }
//
//    for (int k = 0 ; k<cellModel.items.count; k++) {
//        if (k<4) {
//            HPostCellComposeView * sub = self.bottomContainer.subviews[k];
//            HCellComposeModel * model =cellModel.items[k];
//            //            LOG(@"_%@_%d_%@",[self class] , __LINE__,cellModel.color);
//            if (model.ID) {
//                model.keyParamete=@{@"paramete":model.ID};
//            }
//            //        model.theamColor= [UIColor colorWithRed:65/256.0 green:202/256.0 blue:123/256.0 alpha:1];
//            model.theamColor = [UIColor colorWithHexString:[cellModel.color stringByReplacingOccurrencesOfString:@"#" withString:@""]];
//            model.theamtit=@"包邮";
//            sub.composeModel = cellModel.items[k];
//            
//        }
//    }
//    
//    //    LOG(@"_%@_%d_%@",[self class] , __LINE__,cellModel.items)
//}






@end
























































////
////  HPostCell.m
////  b2c
////
////  Created by wangyuanfei on 4/11/16.
////  Copyright © 2016 www.16lao.com. All rights reserved.
////
//
//#import "HPostCell.h"
//#import "HPostCellComposeView.h"
//
////#import "<#header#>"
//@interface HPostCell()
//@property(nonatomic,weak)UIImageView * topImageView ;
//@property(nonatomic,weak)UIView * bottomContainer ;
//
//
//@end
//
//
//@implementation HPostCell
//
///*
//// Only override drawRect: if you perform custom drawing.
//// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect {
//    // Drawing code
//}
//*/
//
//-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
//    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        UIImageView * topImageView = [[UIImageView alloc]init];
//        self.topImageView = topImageView;
//        [self.contentView addSubview:self.topImageView];
////        self.topImageView.backgroundColor = randomColor;
//        
//        
//        
//        UIView * container = [[UIView alloc]init];
//        self.bottomContainer = container;
//        [self.contentView addSubview:container];
////        self.bottomContainer.backgroundColor= randomColor;
//
//        
//        
//        
//        CGFloat topImageViewH = 38*SCALE ;
//        CGFloat totalTopMargin = 11*SCALE ;
//        CGFloat collectionViewH = 148*SCALE;
//        
//        [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.contentView).offset(totalTopMargin);
//            make.left.right.equalTo(self.contentView);
//            make.height.equalTo(@(topImageViewH));
//        }];
//        
//        
//        [self.bottomContainer mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.right.equalTo(self.topImageView);
//            make.top.equalTo(self.topImageView.mas_bottom).offset(1);
//            make.height.equalTo(@(collectionViewH));
//        }];
//        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.right.equalTo(self);
//            make.bottom.equalTo(self.bottomContainer);
//        }];
//
//        
//        
//        
//
//    }
//    return self;
//}
//
//-(void)layoutSubviews{
//    [super layoutSubviews];
////    NSUInteger itemCount = self.bottomContainer.subviews.count ;//目标展示个数
//    NSUInteger itemCount = 4 ;//目标展示个数
//    CGFloat leftRightMargin = 1 ;
//    CGFloat subW = (self.bounds.size.width - (itemCount-1)*leftRightMargin)/itemCount;
//    CGFloat subH = self.bottomContainer.bounds.size.height;
//    
//    for (int i = 0 ;  i< self.bottomContainer.subviews.count; i++) {
//        if (i<4) {
//            HPostCellComposeView * sub = self.bottomContainer.subviews[i];
//            CGFloat subX = (subW+leftRightMargin)*i;
//            CGFloat subY = 0;
//            sub.frame = CGRectMake(subX, subY, subW, subH);
//            
//        }
//    }
//    //根据item个数确定item的宽度
////    CGFloat leftRightMargin = 1 ;
////    CGFloat subW = (self.bounds.size.width - (self.bottomContainer.subviews.count-1)*leftRightMargin)/self.bottomContainer.subviews.count;
////    CGFloat subH = self.bottomContainer.bounds.size.height;
////    
////    for (int i = 0 ;  i< self.bottomContainer.subviews.count; i++) {
////        HPostCellComposeView * sub = self.bottomContainer.subviews[i];
////        CGFloat subX = (subW+leftRightMargin)*i;
////        CGFloat subY = 0;
////        sub.frame = CGRectMake(subX, subY, subW, subH);
////    }
//
//}
//-(void)setCellModel:(HCellModel *)cellModel{
//    [super setCellModel:cellModel];
//    
////    [self.topImageView sd_setImageWithURL:[NSURL URLWithString:cellModel.imgStr] placeholderImage:nil options:SDWebImageCacheMemoryOnly];
//    if ([cellModel.imgStr hasPrefix:@"http"]){
//        [self.topImageView sd_setImageWithURL:[NSURL URLWithString:cellModel.imgStr] placeholderImage:nil options:SDWebImageCacheMemoryOnly];
//    }else{
//        [self.topImageView sd_setImageWithURL:ImageUrlWithString(cellModel.imgStr)  placeholderImage:nil options:SDWebImageCacheMemoryOnly];
//    }
////    [self.topImageView sd_setImageWithURL:ImageUrlWithString(cellModel.imgStr) placeholderImage:nil options:SDWebImageCacheMemoryOnly];
////
////    LOG(@"_%@_%d_%@",[self class] , __LINE__,cellModel.items);
//    
//    
//        if ( self.bottomContainer.subviews.count==0 || self.bottomContainer.subviews.count != cellModel.items.count) {//当网络数据返回个数改变时
//        
//            
//            [self.bottomContainer.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                [obj removeFromSuperview];
//            }];
//            
//            
//            for (int i = 0 ; i< cellModel.items.count; i++) {
//                if (i<4) {
//                    
//                    HPostCellComposeView * sub = [[HPostCellComposeView alloc]init];
//                    sub.backgroundColor=[UIColor whiteColor];
//                    [sub addTarget:self action:@selector(composeClick:) forControlEvents:UIControlEventTouchUpInside];
//                    [self.bottomContainer addSubview:sub];
//                }
//            }
//            
//        
//        
//        }
//    
//    for (int k = 0 ; k<cellModel.items.count; k++) {
//        if (k<4) {
//            HPostCellComposeView * sub = self.bottomContainer.subviews[k];
//            HCellComposeModel * model =cellModel.items[k];
//            //            LOG(@"_%@_%d_%@",[self class] , __LINE__,cellModel.color);
//            if (model.ID) {
//                model.keyParamete=@{@"paramete":model.ID};
//            }
//            //        model.theamColor= [UIColor colorWithRed:65/256.0 green:202/256.0 blue:123/256.0 alpha:1];
//            model.theamColor = [UIColor colorWithHexString:[cellModel.color stringByReplacingOccurrencesOfString:@"#" withString:@""]];
//            model.theamtit=@"包邮";
//            sub.composeModel = cellModel.items[k];
//            
//        }
//    }
//    
//    
//    
//    
//    
//    //////////
//    
////    for (UIView * subview in self.bottomContainer.subviews) {
////        [subview removeFromSuperview];
////    }
//////    if (self.bottomContainer.subviews.count==0) {
////        for (int i = 0 ; i< cellModel.items.count; i++) {
////            if (i<4) {
////                
////                HPostCellComposeView * sub = [[HPostCellComposeView alloc]init];
////                sub.backgroundColor=[UIColor whiteColor];
////                [sub addTarget:self action:@selector(composeClick:) forControlEvents:UIControlEventTouchUpInside];
////                [self.bottomContainer addSubview:sub];
////            }
////        }
//////    }
////    
////    for (int k = 0 ; k<cellModel.items.count; k++) {
////        if (k<4) {
////            HPostCellComposeView * sub = self.bottomContainer.subviews[k];
////            HCellComposeModel * model =cellModel.items[k];
//////            LOG(@"_%@_%d_%@",[self class] , __LINE__,cellModel.color);
////            if (model.ID) {
////                model.keyParamete=@{@"paramete":model.ID};
////            }
////            //        model.theamColor= [UIColor colorWithRed:65/256.0 green:202/256.0 blue:123/256.0 alpha:1];
////            model.theamColor = [UIColor colorWithHexString:[cellModel.color stringByReplacingOccurrencesOfString:@"#" withString:@""]];
////            model.theamtit=@"包邮";
////            sub.composeModel = cellModel.items[k];
////            
////        }
////    }
//    
////    LOG(@"_%@_%d_%@",[self class] , __LINE__,cellModel.items)
//}
//
//
//
//
//
//
////-(void)setCellModel:(HCellModel *)cellModel{
////    [super setCellModel:cellModel];
////    
////    //    [self.topImageView sd_setImageWithURL:[NSURL URLWithString:cellModel.imgStr] placeholderImage:nil options:SDWebImageCacheMemoryOnly];
////    if ([cellModel.imgStr hasPrefix:@"http"]){
////        [self.topImageView sd_setImageWithURL:[NSURL URLWithString:cellModel.imgStr] placeholderImage:nil options:SDWebImageCacheMemoryOnly];
////    }else{
////        [self.topImageView sd_setImageWithURL:ImageUrlWithString(cellModel.imgStr)  placeholderImage:nil options:SDWebImageCacheMemoryOnly];
////    }
////    //    [self.topImageView sd_setImageWithURL:ImageUrlWithString(cellModel.imgStr) placeholderImage:nil options:SDWebImageCacheMemoryOnly];
////    //
////    LOG(@"_%@_%d_%@",[self class] , __LINE__,cellModel.items);
////    
////    
////    
////    
////    
////    for (UIView * subview in self.bottomContainer.subviews) {
////        [subview removeFromSuperview];
////    }
////    //    if (self.bottomContainer.subviews.count==0) {
////    for (int i = 0 ; i< cellModel.items.count; i++) {
////        if (i<4) {
////            
////            HPostCellComposeView * sub = [[HPostCellComposeView alloc]init];
////            sub.backgroundColor=[UIColor whiteColor];
////            [sub addTarget:self action:@selector(composeClick:) forControlEvents:UIControlEventTouchUpInside];
////            [self.bottomContainer addSubview:sub];
////        }
////    }
////    //    }
////    
////    for (int k = 0 ; k<cellModel.items.count; k++) {
////        if (k<4) {
////            HPostCellComposeView * sub = self.bottomContainer.subviews[k];
////            HCellComposeModel * model =cellModel.items[k];
////            //            LOG(@"_%@_%d_%@",[self class] , __LINE__,cellModel.color);
////            if (model.ID) {
////                model.keyParamete=@{@"paramete":model.ID};
////            }
////            //        model.theamColor= [UIColor colorWithRed:65/256.0 green:202/256.0 blue:123/256.0 alpha:1];
////            model.theamColor = [UIColor colorWithHexString:[cellModel.color stringByReplacingOccurrencesOfString:@"#" withString:@""]];
////            model.theamtit=@"包邮";
////            sub.composeModel = cellModel.items[k];
////            
////        }
////    }
////    
////    //    LOG(@"_%@_%d_%@",[self class] , __LINE__,cellModel.items)
////}
//
//
//
//
//
//
//@end
