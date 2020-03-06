//
//  OldBaseCell.h
//  zjlao
//
//  Created by WY on 16/11/12.
//  Copyright © 2016年 com.16lao.zjlao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OldBaseCell;
@protocol BaseCellDelegate <NSObject>

-(void)baseCell:(OldBaseCell*)cell modelOfDidSelectCell:(id)model;

@end

@interface OldBaseCell : UITableViewCell
@property(nonatomic,weak)id <BaseCellDelegate> delegate ;

@end
