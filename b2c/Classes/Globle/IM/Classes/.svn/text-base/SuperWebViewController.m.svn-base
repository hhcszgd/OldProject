//
//  SuperWebViewController.m
//  jzg
//
//  Created by fei lan on 14-5-26.
//  Copyright (c) 2014年 bzwzdsoft. All rights reserved.
//

#import "SuperWebViewController.h"

#define ballSize 4
#define ballNum 5
#define ballSpacing 8.f
#define durationTime 0.8

@interface SuperWebViewController ()

@end

@implementation SuperWebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [self createWebProgress];
    [super viewDidLoad];
}
//创建加载进度线
- (void)createWebProgress {
    CGRect mainRect = [Tool screenRect];
    webProgress = [[UIView alloc] initWithFrame:CGRectMake(0, 0, mainRect.size.width, ballSize)];
    webProgress.backgroundColor = [Tool colorWithHexString:@"EEEEEE"];
    [self.view addSubview:webProgress];
    //生成滚动球
    for (int x = 0; x < ballNum; x++) {
        UIView *ball = [[UIView alloc] initWithFrame:CGRectMake(- 3 * ballSize, 0, ballSize, ballSize)];
        ball.tag = x;
        ball.layer.cornerRadius = ballSize / 2;
        ball.backgroundColor = [Tool colorWithHexString:@"DA3610"];
        [webProgress addSubview:ball];
    }
}
//开启加载进度线动画效果
- (void)startBallAnimation {
    stopAnimation = NO;
    webProgress.hidden = NO;
    [self runAnimation];
}
//停止加载进度线动画效果
- (void)stopBallAnimation {
    stopAnimation = YES;
    webProgress.hidden = YES;
}
//启动进度线动画
- (void)runAnimation {
    if (stopAnimation) {
        return;
    }
    if (!webProgress) {
        [self createWebProgress];
    }
    //创建动画
    for (UIView *ball in webProgress.subviews) {
        [self createAnimation:ball];
    }
    //计时器 4秒后执行
    [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(runAnimation) userInfo:nil repeats:NO];
}
//创建动画效果
- (void)createAnimation:(UIView *)targetView {
    CGRect mainRect = [Tool screenRect];
    CALayer *viewLayer = targetView.layer;
    [viewLayer removeAllAnimations];
    
    //计算第一次动画移动的坐标
    int ballTag = targetView.tag;
    CGFloat positionX = 0;
    if (ballTag == 0) {
        positionX = mainRect.size.width / 2 + 20;
    } else {
        positionX = mainRect.size.width / 2 - ballSpacing * ballTag;
    }
    CGPoint position = viewLayer.position;
    CGPoint x = CGPointMake(positionX, position.y);
    CFTimeInterval delay = 0;
    if (ballTag == 0) {
        delay = 0.6;
    } else {
        delay = .2 * ballTag + (ballTag > 0 ? durationTime / 2 : 0) + 0.6;
    }
    
    //进入时动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    //先加速进入 再减速到达目标位置
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [animation setFromValue:[NSValue valueWithCGPoint:position]];
    [animation setToValue:[NSValue valueWithCGPoint:x]];
    [animation setDuration:durationTime];
    [animation setBeginTime:CACurrentMediaTime() + delay];
    [viewLayer addAnimation:animation forKey:@"moveIn"];
    
    //移出时动画
    CGPoint y = CGPointMake(mainRect.size.width + 3 * ballSize, position.y);
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"position"];
    //一直加速
    [animation2 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [animation2 setFromValue:[NSValue valueWithCGPoint:x]];
    [animation2 setToValue:[NSValue valueWithCGPoint:y]];
    [animation2 setDuration:durationTime];
    [animation2 setBeginTime:CACurrentMediaTime() + durationTime + delay];
    [viewLayer addAnimation:animation2 forKey:@"moveOut"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
