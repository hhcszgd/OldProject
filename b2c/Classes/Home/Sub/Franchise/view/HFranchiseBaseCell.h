//
//  HFranchiseBaseCell.h
//  b2c
//
//  Created by 0 on 16/5/4.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomCollectionModel.h"
#import "HFranchiseBaseModel.h"
@interface HFranchiseBaseCell : UICollectionViewCell
/**cell在组中的行数*/
@property (nonatomic, assign) NSInteger line;
/**列数*/
@property (nonatomic, assign) NSInteger row;
@property (nonatomic, strong) CustomCollectionModel *customModel;
@property (nonatomic, strong) HFranchiseBaseModel *baseModel;
@end
