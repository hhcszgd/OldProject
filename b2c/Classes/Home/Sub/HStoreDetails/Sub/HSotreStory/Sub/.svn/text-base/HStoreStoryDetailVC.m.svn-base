//
//  HStoreStoryDetailVC.m
//  b2c
//
//  Created by 0 on 16/4/5.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HStoreStoryDetailVC.h"

@interface HStoreStoryDetailVC ()<UIWebViewDelegate>

@end

@implementation HStoreStoryDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, self.startY, screenW, screenH - self.startY)];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com/"]]];
    webView.scalesPageToFit = YES;
    webView.detectsPhoneNumbers = YES;
    [self.view addSubview:webView];
    // Do any additional setup after loading the view.
}

- (void)configmentMidleView{
    self.naviTitle = @"你是我的小苹果";
    
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
