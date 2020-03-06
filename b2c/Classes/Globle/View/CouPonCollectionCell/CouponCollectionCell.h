//
//  CouponCollectionCell.h
//  b2c
//
//  Created by 0 on 16/4/6.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface CouponCollectionCell : UICollectionViewCell
@property (nonatomic, strong) CustomCollectionModel *customModel;

@property (nonatomic, strong) UILabel *discount_price;

/**优惠券价格*/
@property (nonatomic, strong) UILabel *full_price;
/**竖线*/
@property (nonatomic, strong) UIImageView *img;
/**开始时间*/
@property (nonatomic, strong) UILabel *start_to_end;
@property (nonatomic, strong) UILabel *title;

@property (nonatomic, strong) UILabel *receiveLabel;

@property (nonatomic, weak) UIView *leftView;
@property (nonatomic, weak) UIView *rightView;
@end
