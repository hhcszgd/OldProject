//
//  SeachSectionHeader.h
//  b2c
//
//  Created by wangyuanfei on 16/5/9.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SeachHeaderView;
@protocol SeachHeaderViewDelegate <NSObject>

-(void)actionViewClick:(ActionBaseView*)sender inView:(SeachHeaderView*)headerView;

@end

@interface SeachHeaderView : UICollectionReusableView
@property(nonatomic,copy)NSString * headerTitle ;
@property(nonatomic,weak)ActionBaseView * actionView ;
@property(nonatomic,assign) BOOL  showActionView ;
@property(nonatomic,assign)BOOL  showNoHistoryView ;

@property(nonatomic,weak)id <SeachHeaderViewDelegate> headerDelegate ;
@end
