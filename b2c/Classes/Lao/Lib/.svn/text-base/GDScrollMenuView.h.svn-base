//
//  GDScrollMenuView.h
//  NewsDemo
//
//  Created by wangyuanfei on 2/26/16.
//  Copyright © 2016 wy. All rights reserved.
//
/**
 #import <UIKit/UIKit.h>
 @class BackImgView;
 @protocol BackImgViewSwipDelegate <NSObject>
 
 -(void)backImgViewSwip:(BackImgView *) backImgView;
 
 @end
 
 @interface BackImgView : UIImageView
 @property(nonatomic,assign)id <BackImgViewSwipDelegate> delegate ;
 @end
 */
#import <UIKit/UIKit.h>
@class GDScrollMenuView ;
@protocol GDScrollMenuViewDataSource <NSObject>
@optional
/** 获取item 和 菜单选项的个数 */
-(NSInteger)numberOfComposeInScrollMenuView:(UIView*)menuView;
/** 获取每一个菜单选项的文字 */
-(NSString *) titleOfEveryoneInMenuView:(UIView*)menuView index:(NSInteger)index;
/** 获取每一个菜单选项的图片 */
-(UIImage *) imageOfEveryoneInMenuView:(UIView*)menuView index:(NSInteger)index;
/** 监听当前item的下标和上一个下标 */
-(void)scrollMenuView:(UIView*)menuView WithTargetIndex:(NSInteger)index oldIndex:(NSInteger)oldIndex;
/** 显示内容的frame */
-(CGRect) collectionFrameInscrollMenuView:(UIView * )menuView;
/** 获取用来显示内容的视图控件 */
-(UIView*) contentViewInScrollMenuView:(UIView *)menuView index:(NSInteger)index;
@end
@protocol GDScrollMenuViewDelegate <NSObject>
@end
@interface GDScrollMenuView : UIView
/** 菜单视图 */
@property(nonatomic,weak)UIScrollView * scrollView ;

//@property(nonatomic,copy)UICollectionView <GDScrollMenuViewDelegate> *GDDelegate;
/** */
@property(nonatomic,weak)id<GDScrollMenuViewDataSource>GDaDtaSource;
/** */
@property(nonatomic,assign)NSInteger  currentIndex ;
/** */
@property(nonatomic,strong)UIColor * textColor ;
/** */
@property(nonatomic,weak)UICollectionView  * myCollectionView ;
/** 单个平道的宽度 , 不设置的话默认80 */
@property(nonatomic,assign)CGFloat   composeW ;
@property(nonatomic,assign)CGSize  sliderSize ;
@end
