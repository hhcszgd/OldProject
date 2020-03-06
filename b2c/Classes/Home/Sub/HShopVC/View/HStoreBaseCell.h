//
//  HStoreBaseCell.h
//  b2c
//
//  Created by 0 on 16/3/30.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HStoreDetailModel.h"
#import "HStoreSubModel.h"
@interface HStoreBaseCell : UICollectionViewCell
@property (nonatomic, strong) HStoreDetailModel *baseModel;
@property (nonatomic, strong) HStoreSubModel *subModel;
@property (nonatomic, copy) NSString *shop_id;

@end
