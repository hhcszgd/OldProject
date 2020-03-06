//
//  LaoStoryTabCell.h
//  b2c
//
//  Created by wangyuanfei on 16/4/22.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@class LaoStoryTabCell ;
@protocol LaoStoryTabCellDelegate <NSObject>

-(void) skipInLaoStoryTabCell:(LaoStoryTabCell*)storyTabCell WithComposeModel:(BaseModel*)composeModel ;

@end

@class LaoStoryCellModel;
@interface LaoStoryTabCell : UITableViewCell
@property(nonatomic,strong)LaoStoryCellModel * laoStoryCellModel ;
@property(nonatomic,weak) id  <LaoStoryTabCellDelegate> delegate ;
@end
