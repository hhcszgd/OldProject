//
//  CustomCollectionCell.h
//  TTmall
//
//  Created by 0 on 16/3/24.
//  Copyright © 2016年 Footway tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomCollectionModel.h"
#import "HGoodsSubGFocusModel.h"

/**主要是为了展示没有图片的放大缩小功能*/
@interface CustomCollectionCell : UICollectionViewCell
@property (nonatomic, strong) CustomCollectionModel *model;
/**商品详情页面滑动的背景图片*/
@property (nonatomic, strong) HGoodsSubGFocusModel *GoodsSubFocusModel;
@end
