//
//  LoginViewController.m
//  Riskmanagement
//
//  Created by demon on 2018/7/13.
//  Copyright © 2018年 demon. All rights reserved.
//

#import "LoginViewController.h"

//#define  webIP @"192.168.42.198:3000"
#define  webIP @"https://www.baidu.com"
@interface LoginViewController ()<UIWebViewDelegate>
@property (strong, nonatomic)UIWebView *webView;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIWebView *webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    webView.delegate = self;
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:webIP]];
    [webView loadRequest:request];
    self.webView = webView;
    [self.view addSubview:webView];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}


@end
