//
//  HGuesslikeCell.m
//  b2c
//
//  Created by wangyuanfei on 16/4/13.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HGuesslikeCell.h"
#import "GuessLikeCellSub.h"
@interface HGuesslikeCell()
@property(nonatomic,strong)GuessLikeCellSub * contennerViewL ;
@property(nonatomic,strong)GuessLikeCellSub * contennerViewR ;

@end

@implementation HGuesslikeCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self layoutContennerView];
        self.backgroundColor = BackgroundGray;

    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)layoutContennerView
{
    
    CGFloat margin = 2 ;
    CGFloat conposeW = (screenW - margin)/2 ;
    GuessLikeCellSub * contennerViewL = [[GuessLikeCellSub alloc]init];
    [contennerViewL addTarget:self action:@selector(composeClick:) forControlEvents:UIControlEventTouchUpInside];
    self.contennerViewL = contennerViewL;
    //    self.contennerViewL.backgroundColor = randomColor;
    [self.contentView addSubview: self.contennerViewL];
    
    self.contennerViewL.frame = CGRectMake(0, margin, conposeW, 251 * SCALE);
    //    [self.contennerViewL.btn setImage:[UIImage imageNamed:@"zuidapai_02"] forState:UIControlStateNormal];
    
    GuessLikeCellSub * contennerViewR = [[GuessLikeCellSub alloc]init];
    self.contennerViewR =contennerViewR;
        [contennerViewR addTarget:self action:@selector(composeClick:) forControlEvents:UIControlEventTouchUpInside];//父类有
    //    self.contennerViewR.backgroundColor = randomColor;
    [self.contentView addSubview: self.contennerViewR];
    
    self.contennerViewR.frame = CGRectMake(conposeW + margin, margin, conposeW, 251 * SCALE);
    
    //    [self.contennerViewR.btn setImage:[UIImage imageNamed:@"zuidapai_02"] forState:UIControlStateNormal];
    
        
}
//父类有
//-(void)composeClick:(GuessLikeCellSub*)sender
//{
//    if (sender.composeModel) {
//        
//        NSDictionary * pragma = @{
//                                  @"HCellComposeViewModel":sender.composeModel
//                                  };
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"HCellComposeViewClick" object:nil userInfo:pragma];
//    }
//    //    LOG(@"_%@_%d_%@",[self class] , __LINE__,self.composeModel.actionKey)
//}
//-(void)dealloc{
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//}
-(void)setCellModel:(HCellModel *)cellModel{
    [super setCellModel:cellModel];
    HCellComposeModel * LModel = [cellModel.items firstObject];
    if (LModel.ID) LModel.keyParamete = @{@"paramete":LModel.ID};
    self.contennerViewL.composeModel = LModel;
    
    HCellComposeModel * RModel = [cellModel.items lastObject];
    if (RModel.ID) RModel.keyParamete = @{@"paramete":RModel.ID};
    self.contennerViewR.composeModel = RModel;
    
    
    
    
    
    
    
    
    
//    self.contennerViewL.composeModel = [cellModel.items firstObject];
//    if (!self.contennerViewL.composeModel.ID) {
//        return;
//    }
//    self.contennerViewL.composeModel.keyParamete = @{@"paramete":self.contennerViewL.composeModel.ID};
////    self.contennerViewL.composeModel.
//    self.contennerViewR.composeModel = [cellModel.items lastObject];
//    if (!self.contennerViewR.composeModel.ID) {
//        return;
//    }
//    self.contennerViewR.composeModel.keyParamete = @{@"paramete":self.contennerViewR.composeModel.ID};
}
@end
