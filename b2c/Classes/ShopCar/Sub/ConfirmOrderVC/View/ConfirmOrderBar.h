//
//  ConfirmOrderBar.h
//  b2c
//
//  Created by wangyuanfei on 16/4/28.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ConfirmOrderBar;

@protocol ConfirmOrderBarDelegate <NSObject>

-(void)creatOrderClickWithConfirmOrderBar:(ConfirmOrderBar*)confirmOrderBar;

@end

@class ConfirmOrderNormalCellModel;
@interface ConfirmOrderBar : UIView
@property(nonatomic,strong)ConfirmOrderNormalCellModel * orderBarModel ;
@property(nonatomic,weak) id <ConfirmOrderBarDelegate> delegate ;
@end
