//
//  PTableHeaderView.h
//  b2c
//
//  Created by wangyuanfei on 3/29/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "ActionBaseView.h"

#import "PTableCellModel.h"

@protocol PTableHeaderViewDelegate <NSObject>

-(void)actionWithTableHeaderComponent:(ActionBaseView*)sender;

@end


@class PTableHeaderModel;

@interface PTableHeaderView : ActionBaseView
@property(nonatomic,weak)id <PTableHeaderViewDelegate> TableHeaderDelegate ;
//@property(nonatomic,assign) NSInteger level ;
//@property(nonatomic,copy)NSString * accountName ;
//@property(nonatomic,strong)UIImage * iconImage ;
//@property(nonatomic,assign)NSInteger  goodsCollectCount ;
//@property(nonatomic,assign)NSInteger  shopCollectCount ;
//@property(nonatomic,assign)NSInteger  attentionBrandCount ;
@property(nonatomic,strong)PTableHeaderModel * pTableHeaderModel ;
@end
