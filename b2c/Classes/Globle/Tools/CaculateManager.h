//
//  CaculateManager.h
//  b2c
//
//  Created by WY on 16/9/16.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HCellModel.h"
@interface CaculateManager : NSObject
/**
 计算包含子view的行高
 
 @param itemsCount   子view的个数
 @param itemHeight   单个子view的高度
 @param itemMargin   子view之间的间距h或者子View里顶部\底部视图的间距 (垂直方向)
 @param columnCount  子view的列数
 @param topHeight    顶部视图的高度
 @param bottomHeight 底部视图的高度
 @param topMargin    顶部离上一个cell的距离
 @param bottomMargin 底部里下一个cell的距离
 
 @return 总行高
 */
+(CGFloat)caculateRowHeightWithItemsCount:( NSInteger)itemsCount  itemHeight:( CGFloat)itemHeight itemMargin : (CGFloat)itemMargin columnCount :(NSInteger)columnCount topHeight:(CGFloat)topHeight bottomHeight:(CGFloat)bottomHeight topMargin :(CGFloat)topMargin bottomMargin : (CGFloat)bottomMargin ;


/**
 动态计算包含文字cell的行高
 
 @param str          文字内容
 @param fontSize     文字所在label的字体
 @param itemMargin   子空间之间的垂直间距
 @param topHeight    顶部视图的高度
 @param bottomHeight 底部视图的高度
 @param topMargin    顶部里上一个cell的间距
 @param bottomMargin 底部离上一个cell的间距
 
 @return 总行高
 */
+(CGFloat)caculateRowHeightWithString:(NSString*)str fontSize:(CGFloat)fontSize lineNum : (NSInteger)lineNum maxWidth : (CGFloat)maxWidth itemMargin:(CGFloat)itemMargin  topHeight:(CGFloat)topHeight bottomHeight:(CGFloat)bottomHeight topMargin:(CGFloat)topMargin bottomMargin:(CGFloat)bottomMargin;

@end
