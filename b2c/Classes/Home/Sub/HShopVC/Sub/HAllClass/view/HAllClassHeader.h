//
//  HAllClassHeader.h
//  b2c
//
//  Created by 0 on 16/3/31.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

@class HAllClassBaseModel;
@protocol HAllClassHeaderDelegate <NSObject>

/**传输Model值*/
- (void)clickToSearchWith:(HAllClassBaseModel *)baseModel;

@end
#import <UIKit/UIKit.h>
#import "HAllClassBaseModel.h"
@interface HAllClassHeader : UICollectionReusableView
@property (nonatomic, assign) HAllClassBaseModel* baseModel;
@property (nonatomic, weak) id <HAllClassHeaderDelegate>delegate;
@end
