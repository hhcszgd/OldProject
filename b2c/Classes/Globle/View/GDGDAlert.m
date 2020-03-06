//
//  GDGDAlert.m
//  b2c
//
//  Created by WY on 17/3/9.
//  Copyright © 2017年 www.16lao.com. All rights reserved.
//

#import "GDGDAlert.h"
#import "b2c-Swift.h"

@interface GDGDAlert ()
@property(nonatomic,weak)UIView * belongView ;
@property(nonatomic,weak)UIView * customView ;
@property(nonatomic,assign)BOOL  isAnimat ;
@property(nonatomic,copy) void(^dismiss)(id objc)   ;
@property(nonatomic,copy) void(^whitespaceHandle)(GDGDAlert * alert)   ;

@end

@implementation GDGDAlert
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor lightGrayColor];
        [self addTarget:self  action:@selector(whiteSpaceClick) forControlEvents:UIControlEventTouchUpInside];
        self.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0];
        [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(theKeyBoaryWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(theKeyBoaryWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

-(void)theKeyBoaryWillShow:(NSNotification*)sender
{
    
    
    CGFloat timeInterval = [sender.userInfo[@"UIKeyboardAnimationDurationUserInfoKey"] floatValue];
    CGRect keyboardEndFrame = [sender.userInfo[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue] ;
    GDlog(@"%f%@",timeInterval , NSStringFromCGRect(keyboardEndFrame));
    [UIView animateWithDuration:timeInterval animations:^{
        
        CGFloat centerx = self.customView.center.x;
        self.customView.center = CGPointMake(centerx, keyboardEndFrame.origin.y - self.customView.bounds.size.height/2);
    }];
    /** 
     ❌NSConcreteNotification 0x608000251430 {name = UIKeyboardWillShowNotification; userInfo = {
     UIKeyboardFrameBeginUserInfoKey = NSRect: {{0, 667}, {375, 258}};
     UIKeyboardCenterEndUserInfoKey = NSPoint: {187.5, 538};
     UIKeyboardBoundsUserInfoKey = NSRect: {{0, 0}, {375, 258}};
     UIKeyboardFrameEndUserInfoKey = NSRect: {{0, 409}, {375, 258}};
     UIKeyboardAnimationDurationUserInfoKey = 0.25;
     UIKeyboardCenterBeginUserInfoKey = NSPoint: {187.5, 796};
     UIKeyboardAnimationCurveUserInfoKey = 7;
     UIKeyboardIsLocalUserInfoKey = 1;
     }
     }❌
     */
}
-(void)theKeyBoaryWillHide:(NSNotification*)sender
{
    GDlog(@"%@",[sender class]);
    CGFloat timeInterval = [sender.userInfo[@"UIKeyboardAnimationDurationUserInfoKey"] floatValue];
//    CGRect keyboardEndFrame = [sender.userInfo[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue] ;
    [UIView animateWithDuration:timeInterval animations:^{
        
        CGFloat centerx = self.customView.center.x;
        self.customView.center = CGPointMake(centerx, screenH/2 );
    }];
    
    /**
     ❌NSConcreteNotification 0x600000648c70 {name = UIKeyboardWillHideNotification; userInfo = {
     UIKeyboardFrameBeginUserInfoKey = NSRect: {{0, 409}, {375, 258}};
     UIKeyboardCenterEndUserInfoKey = NSPoint: {187.5, 796};
     UIKeyboardBoundsUserInfoKey = NSRect: {{0, 0}, {375, 258}};
     UIKeyboardFrameEndUserInfoKey = NSRect: {{0, 667}, {375, 258}};
     UIKeyboardAnimationDurationUserInfoKey = 0.25;
     UIKeyboardCenterBeginUserInfoKey = NSPoint: {187.5, 538};
     UIKeyboardAnimationCurveUserInfoKey = 7;
     UIKeyboardIsLocalUserInfoKey = 1;
     }
     }❌
     */
}
-(void)alertInView:(UIView * )view {//判断tabbar有没有隐藏
    GDlog(@"%d",[GDKeyVC share].mainTabbarVC.tabBar.isHidden);
    
    UIView * realView = nil ;
    if (view) {
        realView = view ;
    }else{
        realView = [UIApplication sharedApplication].keyWindow ;
    }
    [self.belongView removeFromSuperview];
    self.belongView = nil ;
    self.belongView = realView ;
    [self.belongView addSubview:self];
    self.frame = realView.bounds;
}

-(void)alertInVC:(UIViewController * )vc{
    
}

//
//-(void)alertInWindowWithCustomView:(UIView*)view  animat:(BOOL)isAnimat dismissComplate : (void(^)(id objc)) compale whitespaceHandle: (void(^)(GDGDAlert * alert)) whitespaceHandle {
//    self.dismiss = compale;
//    self.whitespaceHandle = whitespaceHandle;
//    self.isAnimat = isAnimat;
//    self.belongView = [UIApplication sharedApplication].keyWindow  ;
//    [self.customView removeFromSuperview];
//    self.customView = nil ;
//    self.customView = view;
//    [self.belongView addSubview:self];
//    self.frame = self.belongView.bounds ;
//    [self addSubview:view ];
//    view .bounds = CGRectMake(0, 0, view.bounds.size.width, view.bounds.size.height);
//    
//    
//    view.center = CGPointMake(screenW/2, - self.customView.bounds.size.height/2);
//    
//    
//
//    if (self.isAnimat) {
//        [UIView animateWithDuration:0.2 animations:^{
//            self.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
////            self.bounds =[UIApplication sharedApplication].keyWindow .bounds;
//            view.center = CGPointMake(screenW/2, screenH/2);
//            
//        }];
//    }else{
//        self.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
//        self.center = CGPointMake(screenW/2, screenH/2);
//    }
//}

-(void)alertInWindowWithCustomView:(UIView*)view  animat:(BOOL)isAnimat  whitespaceHandle: (void(^)(GDGDAlert * alert)) whitespaceHandle {
//    self.dismiss = compale;
    self.whitespaceHandle = whitespaceHandle;
    self.isAnimat = isAnimat;
    self.belongView = [UIApplication sharedApplication].keyWindow  ;
    [self.customView removeFromSuperview];
    self.customView = nil ;
    self.customView = view;
    [self.belongView addSubview:self];
    self.frame = self.belongView.bounds ;
    [self addSubview:view ];
    view .bounds = CGRectMake(0, 0, view.bounds.size.width, view.bounds.size.height);
    
    
    view.center = CGPointMake(screenW/2, - self.customView.bounds.size.height/2);
    
    
    
    if (self.isAnimat) {
        [UIView animateWithDuration:0.2 animations:^{
            self.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
            //            self.bounds =[UIApplication sharedApplication].keyWindow .bounds;
            view.center = CGPointMake(screenW/2, screenH/2);
            
        }];
    }else{
        self.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
        self.center = CGPointMake(screenW/2, screenH/2);
    }
}

-(void)whiteSpaceClick
{
    self.whitespaceHandle(self);
}
-(void)dismissView:(id ) objc dismissComplate : (void(^)(id objc)) compale{
    if (self.isAnimat) {
        
        [UIView animateWithDuration:0.2 animations:^{
            //        self.bounds = CGRectMake(0, 0, 0, 0);
            self.customView.center=CGPointMake(screenW/2, screenH + self.customView.bounds.size.height/2);
            self.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0];
        }completion:^(BOOL finished) {
//            if (compale) {
                compale(objc);
//            }else{
//                self.dismiss(objc);
//            }
            [self removeFromSuperview];
        }];
    }else{
        self.customView.center =  CGPointMake(screenW/2, screenH + self.customView.bounds.size.height/2);;
        self.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0];
//        self.dismiss(objc);
//        if (compale) {
            compale(objc);
//        }else{
//            self.dismiss(objc);
//        }
        [self removeFromSuperview];
    }
}
-(void)dealloc
{
    GDlog(@"我的弹框销毁了")
}
@end
