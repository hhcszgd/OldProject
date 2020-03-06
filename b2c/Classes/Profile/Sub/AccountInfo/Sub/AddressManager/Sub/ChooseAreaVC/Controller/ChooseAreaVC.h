//
//  ChooseAreaVC.h
//  b2c
//
//  Created by wangyuanfei on 16/5/21.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "ThreePointMenuVC.h"
@class AMCellModel;

typedef enum : NSUInteger {
    Country=1,
    Province=2,
    City=3,
    Cantonal=4//区
} AddressType;

@protocol ChooseAreaVCDelegate <NSObject>
-(void)choosedAddressWithModel:(AMCellModel*)addressModel;
-(void)removeFromeSupercontroller;


@end

@interface ChooseAreaVC : ThreePointMenuVC
@property(nonatomic,assign)AddressType  addressType ;//根据type给模型的省/市/区赋值
@property(nonatomic,copy)NSString * areaID ;
@property(nonatomic,strong)NSMutableArray * dataS ;


@property(nonatomic,weak)id  <ChooseAreaVCDelegate> delegate ;
@property(nonatomic,strong)AMCellModel * addressModel ;
@property(nonatomic,copy)NSString * country_id ;
@property(nonatomic,copy)NSString * province_id ;
@end
