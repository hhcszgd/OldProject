//
//  PTableView.h
//  b2c
//
//  Created by wangyuanfei on 3/26/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "BaseTableView.h"

#import "PTableCellModel.h"

@class PTableHeaderModel;
@protocol PTableViewDelegate <NSObject>

-(void)actionWithTableViewComponent:(ActionBaseView*)sender;
-(void)actionWithModel:(BaseModel *)model;
@end

@interface PTableView : BaseTableView
@property(nonatomic,weak)id <PTableViewDelegate> PTableViewDelegate ;
@property(nonatomic,strong)PTableHeaderModel * tableHeaderModel ;

@end
