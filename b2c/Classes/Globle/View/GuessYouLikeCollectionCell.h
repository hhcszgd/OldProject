//
//  GuessYouLikeCollectionCell.h
//  b2c
//
//  Created by 0 on 16/5/3.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomCollectionModel.h"
@interface GuessYouLikeCollectionCell : UICollectionViewCell
@property (nonatomic, strong) CustomCollectionModel *customModel;
@property (nonatomic, strong) UIImageView *img;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *price;
@property (nonatomic, strong) UILabel *count;
@end
