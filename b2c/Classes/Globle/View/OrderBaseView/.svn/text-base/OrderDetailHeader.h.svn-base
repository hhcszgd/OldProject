//
//  OrderDetailHeader.h
//  b2c
//
//  Created by 0 on 16/4/18.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//
@protocol OrderDetailToStoreDelegate <NSObject>
/**条状到店铺详情页面*/
- (void)actionToSotreDetail;


@end
#import <UIKit/UIKit.h>
#import "OrderDetailModel.h"
@interface OrderDetailHeader : UITableViewHeaderFooterView
/**店铺名*/
@property (nonatomic, strong) UILabel *storeName;
/**店铺logo*/
@property (nonatomic, strong) UIImageView *storeLogoImage;
/**点击店铺跳转到店铺页面手势*/
@property (nonatomic, strong) UITapGestureRecognizer *toStoreTap;
- (void)toStoreTap:(UITapGestureRecognizer *)toStoreTap;
/**跳转到店铺详情页面的代理*/
@property (nonatomic, weak) id <OrderDetailToStoreDelegate>delegate;
/**model*/
@property (nonatomic, strong) OrderDetailModel *orderDetailModel;

@end
