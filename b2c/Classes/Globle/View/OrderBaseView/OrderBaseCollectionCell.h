//
//  OrderBaseCollectionCell.h
//  b2c
//
//  Created by 0 on 16/4/12.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderBaseCollectionCell : UICollectionViewCell
/**图片*/
@property (nonatomic, strong) UIImageView *goodsImage;
/**介绍*/
@property (nonatomic, strong) UILabel *TitleLabel;
/**价格*/
@property (nonatomic, strong) UILabel *PriceLabel;
/**颜色分类尺寸*/
@property (nonatomic, strong) UILabel *sizeAndcolorLabel;
/**售后服务*/
@property (nonatomic, strong) UILabel *afterCostLabel;
/**数量*/
@property (nonatomic, strong) UILabel *countLable;
@end
