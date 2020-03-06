//
//  AMCell.h
//  TTmall
//
//  Created by wangyuanfei on 3/3/16.
//  Copyright © 2016 Footway tech. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AMCell;

@protocol AMCellDelegate <NSObject>

-(void)setDefaultAddressAtCell:(AMCell*)cell;
-(void)deleteButtonClickAtCell:(AMCell*)cell;
-(void)editButtonClickAtCell:(AMCell*)cell;
@end
@class AMCellModel;
@interface AMCell : UITableViewCell
@property(nonatomic,strong)AMCellModel * model ;
@property(nonatomic,weak)id  <AMCellDelegate> delegate ;
@end
