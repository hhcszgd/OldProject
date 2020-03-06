//
//  EditAddressVC.h
//  b2c
//
//  Created by wangyuanfei on 4/6/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
/**
    当为修改地址的控制器时 , 传递过来一个包含地址模型(model)信息的cell , 修改完毕之后再把model信息更新到最新 , 返回到上一个地址管理列表控制器时直接刷新一下就可以了
    当为添加地址的控制器时 , 直接编辑创建一个model模型信息来保存新的地址信息,通过代理把新增的地址模型传递到上一个控制器 , 再在上一个控制器中把新模型添加到数组中, 并刷新tableView即可
 
    注意: 记得更新服务器地址信息
 */

#import "ThreePointMenuVC.h"
typedef enum{
    Editing =0,
    Adding = 1
} EditAddressVCActionStyle;
@class AMCell;
@class EditAddressVC;
@class AMCellModel;
@protocol EditAddressVCDelegate <NSObject>
@optional
-(void)endEditingAddtess:(EditAddressVC*)editVC andEditingCell:(AMCell*)editingCell;
-(void)addAddressWithModel:(AMCellModel*)model ;
-(void)endEditingAddress;
@end


@interface EditAddressVC : ThreePointMenuVC
@property(nonatomic,weak)id<EditAddressVCDelegate>  delegate ;

@property(nonatomic,weak)AMCell * editingCell ;
@property(nonatomic,strong)AMCellModel * model ;
//-(void)editAddressWithEditingCell:(AMCell*)editingCell;
-(instancetype)initWithActionStyle:(EditAddressVCActionStyle)actionStyle;
/** 更新服务器地址信息 待完成 */

@end
