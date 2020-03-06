//
//  ShopCarFullVC.h
//  b2c
//
//  Created by wangyuanfei on 16/4/18.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "BaseVC.h"


@class ShopCarFullVC;
@protocol ShopCarFullVCDelegate <NSObject>

-(void) shopCarDataHasChanged:(ShopCarFullVC*)fullVC ;

@end

@interface ShopCarFullVC : BaseVC
@property(nonatomic,strong)NSMutableArray * shopCarData ;
@property(nonatomic,weak)id <ShopCarFullVCDelegate> delegate ;
@end
