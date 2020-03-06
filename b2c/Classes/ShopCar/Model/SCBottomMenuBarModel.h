//
//  SCBottomMenuBarModel.h
//  b2c
//
//  Created by wangyuanfei on 16/4/20.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "BaseModel.h"

@interface SCBottomMenuBarModel : BaseModel
/** 所有选中的商品个数 */
@property(nonatomic,assign)NSInteger  totalGoodsCount ;
/** 选中商品的总价 */
@property(nonatomic,assign)CGFloat  totalMoney ;
/** 所有的店铺是否选中(也就是全选按钮是否要选中) */
@property(nonatomic,assign)BOOL  isAllShopSecect ;
/** 结算按钮的标题 */
@property(nonatomic,copy)NSString * settleOrDeleteTittle ;

//@property(nonatomic,assign)CGFloat  totalMoneyOrMove ;
//@property(nonatomic,assign)BOOL  isAllEdit ;//预留
//@property(nonatomic,copy)NSString * settleOrDeleteTittle ;
@end
