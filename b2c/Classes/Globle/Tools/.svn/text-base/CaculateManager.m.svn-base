//
//  CaculateManager.m
//  b2c
//
//  Created by WY on 16/9/16.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "CaculateManager.h"

@interface CaculateManager()
//@property(nonatomic,strong)UILabel * textLabel ;
@end


static UILabel * _textLabel  ;
@implementation CaculateManager
//static NSMutableDictionary  *_zhaoDaCai;
//
////方式1
//+ (void)initialize
//{
//    _zhaoDaCai = [NSMutableDictionary dictionary];
//}
//
////方式2
//+ (NSMutableDictionary *)zhaoDaCai
//{
//    if (_zhaoDaCai == nil) {
//        _zhaoDaCai = [NSMutableDictionary dictionary];
//    }
//
//    return _zhaoDaCai;
//}

+(UILabel * )textLabel{
    if(_textLabel==nil){
        _textLabel = [[UILabel alloc]init];
    }
    return _textLabel;
}
/**
 计算行高
 
 @param itemsCount   子view的个数
 @param itemHeight   单个子view的高度
 @param itemMargin   子view之间的间距 (垂直方向)
 @param columnCount  子view的列数
 @param topHeight    顶部视图的高度
 @param bottomHeight 底部视图的高度
 @param topMargin    顶部离上一个cell的距离
 @param bottomMargin 底部里下一个cell的距离
 
 @return 总行高
 */



+(CGFloat)caculateRowHeightWithItemsCount:( NSInteger)itemsCount  itemHeight:( CGFloat)itemHeight itemMargin : (CGFloat)itemMargin columnCount :(NSInteger)columnCount topHeight:(CGFloat)topHeight bottomHeight:(CGFloat)bottomHeight topMargin :(CGFloat)topMargin bottomMargin : (CGFloat)bottomMargin {
    
    if (itemsCount > 0)  {
        return topHeight + bottomHeight + topMargin + bottomMargin  + [self caculateItemsHeightWithItemHeight:itemHeight itemMargin: itemMargin itemsCount:itemsCount columnCount:columnCount] ;
    }else {
        return topHeight + bottomHeight + topMargin + bottomMargin + itemHeight ;
    }
    
}


+(CGFloat)caculateItemsHeightWithItemHeight:(CGFloat)itemHeight itemMargin:(CGFloat)itemMargin itemsCount:(NSInteger)itemsCount columnCount:(NSInteger)columnCount {
    if (itemsCount ==0) return 0 ;
    if  (itemsCount % columnCount == 0){
        NSInteger  rows =  itemsCount / columnCount ;
        NSLog(@"_%d_%f",__LINE__,(rows + 1) * (itemHeight + itemMargin) );
        return  rows *  (itemHeight + itemMargin) ;
    }else {
        NSInteger  rows =  itemsCount / columnCount ;
        return  (rows + 1) *  (itemHeight + itemMargin) ;
        
    }
}

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

+(CGFloat)caculateRowHeightWithString:(NSString*)str fontSize:(CGFloat)fontSize lineNum : (NSInteger)lineNum maxWidth : (CGFloat)maxWidth itemMargin:(CGFloat)itemMargin  topHeight:(CGFloat)topHeight bottomHeight:(CGFloat)bottomHeight topMargin:(CGFloat)topMargin bottomMargin:(CGFloat)bottomMargin{
    UIFont * font = [UIFont systemFontOfSize:fontSize];
    NSDictionary *attr = @{NSFontAttributeName : font};
    
    CGRect rect =  [str boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attr context:nil];
    if (lineNum>0) {
        
        CGFloat maxHeight = font.lineHeight * lineNum;
        CGFloat strHeight = rect.size.height > maxHeight ? maxHeight : rect.size.height ;
        
        return  strHeight + itemMargin + topHeight + bottomHeight + topMargin + bottomMargin ;
    }else{
        return rect.size.height +  itemMargin + topHeight + bottomHeight + topMargin + bottomMargin  ;
        
    }
}






@end
