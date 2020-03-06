//
//  CListOfGoodsBarCell.h
//  b2c
//
//  Created by 0 on 16/4/25.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClistOfGoodsModel.h"
#import "HStoreSubModel.h"
@interface CListOfGoodsBarCell : UICollectionViewCell
@property (nonatomic, strong) ClistOfGoodsModel *clistModel;
@property (nonatomic, strong) HStoreSubModel *subModel;
@end
