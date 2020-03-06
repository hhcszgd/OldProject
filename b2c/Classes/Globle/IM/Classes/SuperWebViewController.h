//
//  SuperWebViewController.h
//  jzg
//
//  Created by fei lan on 14-5-26.
//  Copyright (c) 2014年 bzwzdsoft. All rights reserved.
//

#import "CommViewController.h"
#import "Tool.h"
#import "SVProgressHUD.h"
#import "SystemVariable.h"

@interface SuperWebViewController : CommViewController<UIWebViewDelegate> {
    UIView *webProgress;
    BOOL stopAnimation;
}
- (void)startBallAnimation;
- (void)stopBallAnimation;
@end
