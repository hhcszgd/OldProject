//
//  LoginVC.h
//  TTmall
//
//  Created by wangyuanfei on 2/18/16.
//  Copyright © 2016 Footway tech. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LoginVC ;
@protocol LoginVCDelegate <NSObject>

- (void)sbloginsuccessed:(LoginVC *) vc;

@end

@interface LoginVC : SecondBaseVC
//@interface LoginVC : ProfileBaseVC
@property(nonatomic,weak)id  <LoginVCDelegate> mydelegate ;

@end
