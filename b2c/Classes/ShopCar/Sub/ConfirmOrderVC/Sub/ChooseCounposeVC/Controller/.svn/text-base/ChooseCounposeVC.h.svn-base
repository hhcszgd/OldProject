//
//  ChooseCounposeVC.h
//  b2c
//
//  Created by wangyuanfei on 16/5/17.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "SecondBaseVC.h"

@protocol ChooseCounposeVCDelegate <NSObject>
-(void)chooseCouponseWithConposeArr:(NSString*)conposeArr;


@end

@interface ChooseCounposeVC : SecondBaseVC
@property(nonatomic,weak)id <ChooseCounposeVCDelegate> ChooseCounposeDelegate ;
/** goodsID是json格式数组,元素是goodsID */

@property(nonatomic,copy)NSString * goodsID ;
@property(nonatomic,strong)NSMutableArray * selectCouponses ;
@end
