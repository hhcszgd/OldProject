//
//  OldMsgLabel.m
//  zjlao
//
//  Created by WY on 16/11/14.
//  Copyright © 2016年 com.16lao.zjlao. All rights reserved.
//

#import "OldMsgLabel.h"
#import <objc/runtime.h>
@interface OldMsgLabel ()

@end

@implementation OldMsgLabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

//- (instancetype)initWithFrame:(CGRect)frame {
//    if (self = [super initWithFrame:frame]) {
//        [self pressAction];
//    }
//    return self;
//}
//// 初始化设置
//- (void)pressAction {
//    self.userInteractionEnabled = YES;
//    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
//    longPress.minimumPressDuration = 1;
//    [self addGestureRecognizer:longPress];
//}
//// 使label能够成为响应事件
//- (BOOL)canBecomeFirstResponder {
//    return YES;
//}
//// 控制响应的方法
//- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
//    return action == @selector(customCopy:);
//}
//- (void)customCopy:(id)sender {
//    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
//    pasteboard.string = self.text;
//}
//- (void)longPressAction:(UIGestureRecognizer *)recognizer {
//    UIMenuItem *copyItem = [[UIMenuItem alloc] initWithTitle:@"拷贝" action:@selector(customCopy:)];
//    [[UIMenuController sharedMenuController] setMenuItems:[NSArray arrayWithObjects:copyItem, nil]];
//    [[UIMenuController sharedMenuController] setTargetRect:self.frame inView:self.superview];
//    [[UIMenuController sharedMenuController] setMenuVisible:YES animated:YES];
//    [self becomeFirstResponder];
//}
@end
