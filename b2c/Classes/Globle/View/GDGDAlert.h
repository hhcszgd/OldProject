//
//  GDGDAlert.h
//  b2c
//
//  Created by WY on 17/3/9.
//  Copyright © 2017年 www.16lao.com. All rights reserved.
//

#import "ActionBaseView.h"

@interface GDGDAlert : ActionBaseView
-(void)alertInView:(UIView * )view ;
-(void)alertInVC:(UIViewController * )vc ;
//-(void)alertInWindowWithCustomView:(UIView*)view  animat:(BOOL)isAnimat dismissComplate : (void(^)(id objc)) compale  whitespaceHandle : (void(^)(GDGDAlert * alert)) whitespaceHandle ;
-(void)alertInWindowWithCustomView:(UIView*)view  animat:(BOOL)isAnimat whitespaceHandle : (void(^)(GDGDAlert * alert)) whitespaceHandle ;
-(void)dismissView:(id ) objc dismissComplate : (void(^)(id objc)) compale;
@end
