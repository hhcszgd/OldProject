//
//  ChooseAddressVC.h
//  b2c
//
//  Created by wangyuanfei on 16/5/17.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "SecondBaseVC.h"
@class AMCellModel;
@protocol ChooseAddressVCDelegate <NSObject>

-(void)chooseTheAddressModel:(AMCellModel*)addressModel;

@end

@interface ChooseAddressVC : SecondBaseVC
@property(nonatomic,weak)id  <ChooseAddressVCDelegate> ChooseAddressDelegate ;
@property(nonatomic,assign)NSUInteger choosedAddressID ;
@end
