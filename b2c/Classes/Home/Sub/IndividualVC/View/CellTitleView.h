//
//  CellTitleView.h
//  b2c
//
//  Created by wangyuanfei on 16/5/5.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "ActionBaseView.h"
#import "CustomDetailCell.h"
//typedef enum : NSUInteger {
//    style1=0,//普通的一张平铺图片
//    style2=1,//仅文字标题时
//    style3=2,//先小图片 , 紧接着是标题
//} CellTitleViewType;

@interface CellTitleView : CustomDetailCell

/** 距离左边缘0点的图片 */
//@property(nonatomic,strong)UIImage * leftImageCloseToBorder ;
///** 距离上面图片10点的标题 */
//@property(nonatomic,copy)NSString * leftTitleToBorderImg ;

@property(nonatomic,strong)UIColor * titleStrColor ;
@property(nonatomic,copy)NSString * titleStr ;

///** style1时平铺的图片 */
//@property(nonatomic,strong)UIImage * backImage;
///** style1时平铺的图片链接 */
//@property(nonatomic,copy)NSString * backImageUrl ;
///** 仅文字标题时的title  距左侧10个点*/
//@property(nonatomic,copy)NSString * cellTitle ;
///** 仅文字标题是title的字体 */
//@property(nonatomic,strong)UIFont * cellTitleFont ;
///** 仅文字标题是title的颜色 */
//@property(nonatomic,strong)UIColor * cellTitleColor ;
//-(instancetype)initWithStyle:(CellTitleViewType)style ;
@end
