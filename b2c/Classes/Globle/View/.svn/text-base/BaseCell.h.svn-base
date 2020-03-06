//
//  BaseCell.h
//  b2c
//
//  Created by wangyuanfei on 3/25/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BaseCell;
@protocol BaseCellDelegate <NSObject>

-(void)baseCell:(BaseCell*)cell modelOfDidSelectCell:(id)model;

@end

@interface BaseCell : UITableViewCell
@property(nonatomic,weak)id <BaseCellDelegate> delegate ;
@end
