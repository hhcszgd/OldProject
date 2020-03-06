//
//  HSuperWebVC.h
//  b2c
//
//  Created by 张凯强 on 2017/1/12.
//  Copyright © 2017年 www.16lao.com. All rights reserved.
//

@protocol superWebDelegate <NSObject>

- (void)changeShopCarNumber;

@end



#import "BaseWebVC.h"

@interface HSuperWebVC : BaseWebVC
@property (nonatomic, assign) id <superWebDelegate>delegate;
@end
