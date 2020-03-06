//
//  SecondBaseVC.h
//  b2c
//
//  Created by wangyuanfei on 3/24/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "OldBaseVC.h"
@class ActionBaseView;

//#import "ActionBaseView.h"
@interface SecondBaseVC : OldBaseVC
/** 导航栏标题 */
@property(nonatomic,copy)NSString * naviTitle ;
/** 导航栏背景透明度 */
-(void)changenavigationBarBackGroundAlphaWithScale:(CGFloat)scale;
/** 导航栏透明度 */
-(void)changenavigationBarAlphaWithScale:(CGFloat)scale;
/** 导航栏颜色 可以设置一个默认颜色*/
@property(nonatomic,strong)UIColor * navigationBarColor ;
//@property(nonatomic,weak)ActionBaseView * navigationView ;
/** 这里面子控件,如果不设置frame默认是正方形 , 如果设置 ,只有宽有效 */
@property(nonatomic,strong)NSArray * navigationBarLeftActionViews ;
/** 这里面子控件,如果不设置frame默认是正方形 , 如果设置 ,只有宽有效 */
@property(nonatomic,strong)NSArray * navigationBarRightActionViews ;
/** 导航栏中间的文体view */
@property(nonatomic,weak)UIView * navigationTitleView ;
/** 导航栏中间的搜索框view */
@property(nonatomic,weak)UIView * searchView ;
/** 导航栏中间的自定义view , 始终居中的 */
@property(nonatomic,weak)UIView * navigationCustomView ;
@property(nonatomic,assign)CGFloat startY ;
/** 是否显示导航栏底部的线 (默认显示)*/
@property(nonatomic,assign)BOOL showNavigationBarBottomLine ;
@property(nonatomic,assign)BOOL  backButtonHidden ;
/** 是否在视图disappear以后销毁当前控制器 */
@property(nonatomic,assign)BOOL  canDestroy ;
@property(nonatomic,weak)ActionBaseView * navigationView ;

///** 导航栏上的三个点的菜单按钮对应的数组 */
//@property(nonatomic,strong)NSArray * threePointMenuArr ;
-(void)addsubviews;
-(void)layoutsubviews;
-(void)hiddenCustomNavigationbar;
//-(void)navigationBack;
//-(void)showNavigationBarBottomLine;
@end
