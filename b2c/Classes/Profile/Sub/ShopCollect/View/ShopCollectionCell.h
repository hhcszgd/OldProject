//
//  ShopCollectionCell.h
//  TTmall
//
//  Created by 0 on 16/3/18.
//  Copyright © 2016年 Footway tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopCollectionRightButton.h"
#import "SCModel.h"
typedef void(^block)(id);


@interface ShopCollectionCell : UITableViewCell
@property (nonatomic, strong) block myBlock;
@property (nonatomic, strong)  SCModel *model;
@property (nonatomic, strong) UITableView *tableView;
@end
