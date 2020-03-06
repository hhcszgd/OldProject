//
//  LoginNavVC.h
//  TTmall
//
//  Created by wangyuanfei on 3/11/16.
//  Copyright © 2016 Footway tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileNavigationVC.h"
@protocol LoginNaviVCDelegate <NSObject>

- (void)loginnavisuccessed;

@end

@interface LoginNavVC : ProfileNavigationVC
@property(nonatomic,weak)id  <LoginNaviVCDelegate> mydelegate ;
-(instancetype)initLoginNavVC;

@end
