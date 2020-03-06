//
//  PBaseCell.h
//  b2c
//
//  Created by wangyuanfei on 3/30/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "BaseCell.h"

@protocol PBaseCellDelegate <NSObject>

-(void)actionWithModel:(BaseModel*)model;

@end

@interface PBaseCell : BaseCell
@property(nonatomic,weak)id <PBaseCellDelegate> PCellDelegate ;
@end
