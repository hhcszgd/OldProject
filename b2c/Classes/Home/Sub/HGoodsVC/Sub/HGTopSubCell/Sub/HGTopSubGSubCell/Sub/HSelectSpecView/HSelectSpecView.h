//
//  selectcategaryView.h
//  TTmall
//
//  Created by 0 on 16/1/27.
//  Copyright © 2016年 Footway tech. All rights reserved.
//

@protocol HSelectSpecViewDelegate <NSObject>

@optional
//添加到购物车成功
- (void)addToShopCar;
- (void)ToPayControl;
- (void)noticeAddAddress;
/**页面将要弹出*/
- (void)viewWillDisPlay;
/**页面出现*/
- (void)viewDidDisPlay;
/**页面消失*/
- (void)viewEndDisPlay;
- (void)sentSelectIndexPathArr:(NSMutableArray *)resetSelectIndexPathArr;
- (void)selectGoodsDetailModel:(HSpecSubGoodsDeatilModel *)specSubGoodsDetailModel;
/**页面消失然后开始动画*/
- (void)viewHiddenAndBeginAnimation;
/**加入购物车失败*/
- (void)addshopCarfail;

@end

#import <UIKit/UIKit.h>
#import "HSepcModel.h"
#import "ConfirmOrderVC.h"
/**自定义的警告框*/
#import "UserDefineAlertView.h"
typedef enum {
    haveTwobtn = 0,
    //有一个确定按钮的时候
    addToShopCar,
    ToPayControl
    
}typeofView;

@interface HSelectSpecView : UIView

@property (nonatomic, copy) NSString *title;
/**上面的视图*/
@property (nonatomic, strong) ActionBaseView *topView;
/**下面的视图*/
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, assign) id <HSelectSpecViewDelegate>delegate;
- (instancetype)initWithFrame:(CGRect)frame typeofView:(typeofView)type goods_id:(NSString *)goodID;

/**规格模型*/
@property (nonatomic, strong) HSpecSubGoodsDeatilModel *goodsDetailModel;
/**数据源*/
@property (nonatomic, strong) HSepcModel *sepcModel;
/**原始数据源*/
@property (nonatomic, strong) HSepcModel *originalModel;
/**存放每组规格的选中状态*/
//@property (nonatomic, strong) NSMutableArray *cellsIsSelect;
/**被选中的具体的组*/
@property (nonatomic, strong) NSMutableArray *selectIndexPaths;

//每一个尺寸，颜色分类的详情
@property (nonatomic, strong) NSMutableArray *detailArray;
/**控制器*/
@property (nonatomic, weak) SecondBaseVC *fatherVC;
@property (nonatomic, strong) NSMutableArray *resetSelectIndexPath;
@property (nonatomic, copy)  void(^block)();

- (void)presentSemiView:(UIView *)semiView backView:(UIView *)backview target: (UIView *)target ScreenShot:(BOOL)isScreenShot;

@end
