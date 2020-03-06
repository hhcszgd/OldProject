//
//  HBCouponCell.m
//  b2c
//
//  Created by 0 on 16/4/7.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HBCouponCell.h"

#import "CouponCollectionCell.h"
@interface HBCouponCell()
//<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
///**布局类*/
//@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
///**滑动collectionview*/
//@property (nonatomic, strong) UICollectionView *col;
///**数据源数组*/
//@property (nonatomic, strong) NSMutableArray *dataArray;
///**优惠券的高度*/
//@property (nonatomic, assign) CGFloat h;
///**优惠券的宽度*/
//@property (nonatomic, assign) CGFloat w;
/**折扣价*/
@property (nonatomic, strong) UILabel *discount_price;
/**结束时间*/
@property (nonatomic, strong) UILabel *end_time;
/**优惠券价格*/
@property (nonatomic, strong) UILabel *full_price;
/**竖线*/
@property (nonatomic, strong) UIImageView *img;
/**开始时间*/
@property (nonatomic, strong) UILabel *start_time;
@property (nonatomic, strong) UILabel *title;


@end
@implementation HBCouponCell

- (UIImageView *)img{
    if (_img == nil) {
        _img = [[UIImageView alloc] init];
        [self.contentView addSubview:_img];
    }
    return _img;
}
- (UILabel *)discount_price{
    if (_discount_price == nil) {
        _discount_price = [[UILabel alloc] init];
        [self.contentView addSubview:_discount_price];
        [_discount_price configmentfont:[UIFont systemFontOfSize:11 * SCALE] textColor:[UIColor colorWithHexString:@"ffffff"] backColor:[UIColor clearColor] textAligement:0 cornerRadius:0 text:@""];
        [_discount_price setNumberOfLines:2];
    }
    return _discount_price;
}

- (void)setCustomModel:(CustomCollectionModel *)customModel{
    
}



@end
