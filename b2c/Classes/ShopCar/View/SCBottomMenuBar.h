//
//  SCBottomMenuBar.h
//  b2c
//
//  Created by wangyuanfei on 16/4/20.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SCBottomMenuBar;
@protocol SCBottomMenuBarModelDelegate <NSObject>
-(void)chooseAllButtonClickInMenuBar:(SCBottomMenuBar*)bottomMenuBar chooseAllButton:(UIButton*)sender;
-(void)settleMoneyClickInMenuBar:(SCBottomMenuBar*)bottomMenuBar chooseAllButton:(UIButton*)sender;

@end


@class SCBottomMenuBarModel ;
@interface SCBottomMenuBar : UIView

/** 全选按钮 */
@property(nonatomic,weak)   UIButton * chooseAllButton ;
@property(nonatomic,strong)SCBottomMenuBarModel * bottomMenuBarModel ;
@property(nonatomic,weak)id <SCBottomMenuBarModelDelegate> delegate ;

@end
