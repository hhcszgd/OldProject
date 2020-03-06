//
//  CONormalCompose.h
//  b2c
//
//  Created by wangyuanfei on 16/4/28.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "ActionBaseView.h"
@class ConfirmOrderNormalCellModel;
@interface CONormalCompose : ActionBaseView

@property(nonatomic,strong)ConfirmOrderNormalCellModel * normalCellModel ;

@property(nonatomic,copy)NSString * leftTitle ;
@property(nonatomic,copy)NSString * rightTitle ;
@property(nonatomic,assign)BOOL showArrow ;
@property(nonatomic,strong)UIColor * rightTitleColor ;
@end
