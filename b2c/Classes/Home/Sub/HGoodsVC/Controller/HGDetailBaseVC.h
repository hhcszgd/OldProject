//
//  HGDetailBaseVC.h
//  b2c
//
//  Created by 0 on 16/4/22.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "SecondBaseVC.h"
#import "TitleView.h"
#import "ShopCar.h"
#import "HGMoreView.h"
#import "HGTopSepecificationModel.h"
#import "HSpecSubGoodsDeatilModel.h"
#import "HSepcModel.h"
@class GNavScroll;
//#import "b2c-Swift.h"
/**添加购物车按钮和立即购买按钮的高度*/
#define bottomBtnHeight 50 * SCALE
@interface HGDetailBaseVC : SecondBaseVC<TitleViewDelegate>
/**titleview*/
@property (nonatomic, strong) TitleView *titleView;
/**跳转到购物车的按钮*/
@property (nonatomic, strong) ShopCar *shopCarBtn;
@property (nonatomic, strong) UIButton *collectionBtn;
@property (nonatomic, strong) UIButton *colsultBtn;


@property (nonatomic, strong) GNavScroll *scroll;


//加入购物车
@property (nonatomic, strong) UIButton *addSHopCar;
//立即购买
@property (nonatomic, strong) UIButton *quickBuy;
/**bottomCell的数据源*/
@property (nonatomic, strong) NSMutableArray *goodsDetailArr;
/**商品信息的数据*/
@property (nonatomic, strong) NSMutableArray *goodsInfoDataArr;
/**评价页面的数据源*/
@property (nonatomic, strong) NSMutableArray *goodsEvluateArr;
/**总数据源*/
@property (nonatomic, strong) NSMutableArray *dataArr;


/**被选中的具体的组*/
@property (nonatomic, strong) NSMutableArray *selectIndexPaths;
/**规格模型*/
@property (nonatomic, strong) HSepcModel *sepcModel;
@property (nonatomic, strong) HGTopSepecificationModel *sepecificationModel;
/**规格组合模型*/
@property (nonatomic, strong) HSpecSubGoodsDeatilModel *goodsDetailModel;
/**判断item是滑动到什么地方,使用index来存放数据将上下两部分分为两组。上面一组0，下面一组1*/
@property (nonatomic, strong) NSMutableArray *navigationBackArr;
/**存放每组规格的选中状态*/
//@property (nonatomic, strong) NSMutableArray *cellsIsSelect;
- (void)collection:(UIButton *)btn;
- (void)consult;
/**预售按钮*/
@property (nonatomic, strong) UILabel *shelvesLabel;



@end
