//
//  UINavigationBar+Extension.m
//  testNavigation
//
//  Created by apple on 15/12/15.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "UINavigationBar+Extension.h"
#import <objc/runtime.h>

@implementation UINavigationBar (Extension)
static char VerView;

-(void)setAwasomeView:(UIView *)awasomeView
{
    objc_setAssociatedObject(self, &VerView, awasomeView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIView *)awasomeView
{
    return  objc_getAssociatedObject(self, &VerView);
}

//实现方法
-(void)setbackgroundAlphaColor:(UIColor *)color
{
    if (!self.awasomeView) {
        //添加图片
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.shadowImage = [UIImage new];
        
        //创建view
        self.awasomeView = [[UIView alloc]initWithFrame:CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, 64)];
        
        //插入到父控件最底层
//        [self insertSubview:self.awasomeView atIndex:0];
        [self addSubview:self.awasomeView];
    }
    
    //颜色透明
    self.awasomeView.backgroundColor = color;
}

@end
