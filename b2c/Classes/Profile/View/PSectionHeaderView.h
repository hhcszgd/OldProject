//
//  PSectionHeaderView.h
//  b2c
//
//  Created by wangyuanfei on 3/29/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "ActionBaseView.h"
#import "CustomDetailCell.h"
@class PTableCellModel;
//@protocol PSectionHeaderViewDelegate <NSObject>

//-(void) profileSectionHeaderClickWith:(ActionBaseView*)sender;

//@end

@interface PSectionHeaderView : CustomDetailCell
@property(nonatomic,strong)PTableCellModel * sectionHeaderModel ;
//@property(nonatomic,weak)id <PSectionHeaderViewDelegate> PSectionHeaderDelegate ;
//@property(nonatomic,assign)BOOL arrowHidden ;
//
// @property(nonatomic,strong)UIImage * leftImage ;
// @property(nonatomic,copy)NSString * leftTitle ;
// @property(nonatomic,copy)NSString * rightDetailTitle ;
// @property(nonatomic,strong)UIImage * rightImage ;

@end
