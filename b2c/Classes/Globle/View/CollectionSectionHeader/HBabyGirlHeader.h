//
//  HBabyGirlHeader.h
//  b2c
//
//  Created by 0 on 16/4/7.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HBabyBaseModel.h"
@interface HBabyGirlHeader : UICollectionReusableView
@property (nonatomic, copy) NSString *title;
/***/
@property (nonatomic, strong) UIPageControl *page;

@property (nonatomic, strong) HBabyBaseModel *babyModel;

/**添加图片*/
@property (nonatomic, strong) UIImage *titleImage;


@end
