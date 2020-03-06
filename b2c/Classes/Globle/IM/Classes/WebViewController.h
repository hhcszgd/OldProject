//
//  WebViewController.h
//  jzg
//
//  Created by apple on 13-10-9.
//  Copyright (c) 2013年 bzwzdsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "SuperWebViewController.h"

@interface WebViewController : SuperWebViewController<UIWebViewDelegate,UINavigationControllerDelegate> {
    NSString *url;
    NSString *titleString;
}

@property (nonatomic, strong) UIWebView *myWeb;
@property (nonatomic, assign) BOOL hideNavWhenBack;
-(void)initData:(NSString *)_title url:(NSString *)_url;
@end