//
//  MyInputAccessoryView.h
//  b2c
//
//  Created by wangyuanfei on 6/17/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyInputAccessoryView;
@protocol MyInputAccessoryViewDelegate <NSObject>

-(void)forgetPasswordActionWithAccessoryView:(MyInputAccessoryView*)accessoryView;

@end

@interface MyInputAccessoryView : UIView
@property(nonatomic,weak)id  <MyInputAccessoryViewDelegate> InputAccessoryViewDelegate ;
-(void)trendsChangeInputViewWithLength:(NSUInteger)length;
@end
