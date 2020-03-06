//
//  WebViewController.m
//  jzg
//
//  Created by apple on 13-10-9.
//  Copyright (c) 2013年 bzwzdsoft. All rights reserved.
//

#import "WebViewController.h"
#import "Tool.h"
#import "SystemVariable.h"
#import "SystemConfig.h"
#import "SVProgressHUD.h"

@interface WebViewController () {
    long long shopId;
}
@end

@implementation WebViewController
@synthesize myWeb;

//初始化标题和链接
-(void)initData:(NSString *)title_ url:(NSString *)_url {
    titleString = title_;
    url = _url;
}
//页面即将显示
-(void) viewWillAppear:(BOOL)animated {
    [self initUrl:url];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [super viewWillAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated {
    if (self.hideNavWhenBack) {
        [self.navigationController setNavigationBarHidden:YES animated:NO];
    }
    [self stopBallAnimation];
    [super viewWillDisappear:animated];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}
- (void)viewDidLoad {
    title = titleString;
    isShowBackButton = YES;
    [super viewDidLoad];
    CGRect mainRect = [Tool screenRect];
    //状态栏高度
    CGFloat statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    //导航栏高度
    CGFloat navigationBarHeight = self.navigationController.navigationBar.bounds.size.height;
    
    //背景图
    CGRect backgroundViewRect = mainRect;
    if (IS_GTE_IOS7) {
        backgroundViewRect.origin.y -= (statusBarHeight + navigationBarHeight);
    }
    UIImageView *backgroundView = [[UIImageView alloc] initWithFrame:backgroundViewRect];
    backgroundView.image = [UIImage imageNamed:@"appBG"];
    [self.view addSubview:backgroundView];
    
    //设置web
    CGRect webRect = mainRect;
    webRect.size.height -= (statusBarHeight + navigationBarHeight);
    if (IS_GTE_IOS7) {
    } else {
        webRect.origin.y += navigationBarHeight;
    }
    myWeb = [[UIWebView alloc] initWithFrame:webRect];
    myWeb.delegate = self;
    [self.view addSubview:myWeb];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


//请求解析
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString *requestURL = [[request URL] absoluteString];
    if ([requestURL rangeOfString:@"/app,"].location == NSNotFound) {
        return YES;
    }
    //转码
    NSString *encodeURL = [requestURL stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *param = [encodeURL substringFromIndex:[encodeURL rangeOfString:@"app,"].location + 4];
    NSData *jsonData = [param dataUsingEncoding: NSUTF8StringEncoding];
    
    //获取参数
    NSDictionary *rootDic;
    if (jsonData) {
        rootDic = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    }
    NSString *name = [rootDic objectForKey:@"name"];
    if ([param rangeOfString:@"psdChanged"].location != NSNotFound) {
        [SystemConfig setRememberPasswordByBOOL:NO];
        [SVProgressHUD showSuccessWithStatus:@"修改密码成功" duration:2];
        [self back:nil];
    } else if ([name isEqualToString:@"psdFinded"]) {
        [SystemConfig setRememberPasswordByBOOL:NO];
    }
    return NO;
}
//页面加载失败
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self stopBallAnimation];
}
//页面加载完成
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self stopBallAnimation];
    self.navigationItem.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}
//弹出页面
- (void)back:(id)send {
    [myWeb stopLoading];
    [myWeb stringByEvaluatingJavaScriptFromString:@"document.body.innerHTML='';"];
    [myWeb removeFromSuperview];
    myWeb.delegate = nil;
    myWeb = nil;
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    [super back:send];
}

//加载页面
-(void)initUrl:(NSString *)path {
    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *_urlc =[NSURL URLWithString:path];
    if (_urlc == nil) {
        _urlc = [NSURL fileURLWithPath:path];
    }
    [self startBallAnimation];
    NSURLRequest *request =[NSURLRequest requestWithURL:_urlc];
    [myWeb loadRequest:request];
}
@end
