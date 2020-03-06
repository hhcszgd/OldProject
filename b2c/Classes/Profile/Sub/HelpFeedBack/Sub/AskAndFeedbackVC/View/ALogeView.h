//
//  ALogeView.h
//  b2c
//
//  Created by 张凯强 on 16/7/10.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

@protocol ALogeViewDelegate <NSObject>

- (void)logePhoneToTarget:(NSString *)phoneNumber;

@end
#import <UIKit/UIKit.h>

@interface ALogeView : UIView
/**投诉电话*/
@property (nonatomic, strong) UILabel *logePhone;
@property (nonatomic, weak) id <ALogeViewDelegate>delegate;
@end
