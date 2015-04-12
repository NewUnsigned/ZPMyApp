//
//  ZPAuthViewController.m
//  WeiBo
//
//  Created by 赵鹏 on 15/4/12.
//  Copyright (c) 2015年 赵鹏. All rights reserved.
//

#import "ZPAuthViewController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import "ZPAccount.h"

#define ZP_REQUEST_TOKEN_BEASE_URL @"https://api.weibo.com/oauth2/authorize"
#define ZP_CLIENT_ID @"422720824"
#define ZP_SECRET @"b3c26d76af109c1657c6c7912b5acbab"
#define ZP_REDIRECT_URL @"http://www.baidu.com"
#define ZP_ACCESSTOKEN_URL @"https://api.weibo.com/oauth2/access_token"

@interface ZPAuthViewController () <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *loginWebView;

@end

@implementation ZPAuthViewController
- (IBAction)backBtn {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 1.从新浪服务器加载登陆界面(获取未授权的RequestToken)
//    NSString *str = [NSString stringWithFormat:@"%@?client_id=%@&redirect_uri=%@", HM_REQUEST_TOKEN_BEASE_URL, HM_CLIENT_ID, HM_REDIRECT_URL];
//    NSURL *url = [NSURL URLWithString:str];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    [self.loginWebView loadRequest:request];
    [self loginWeiBo];
}
- (void)loginWeiBo
{
    NSLog(@"%s",__func__);
    self.loginWebView.delegate = self;
    [SVProgressHUD showWithStatus:@"正在加载,请稍等!"];
    //请求的URL
    NSString *str = [NSString stringWithFormat:@"%@?client_id=%@&redirect_uri=%@", ZP_REQUEST_TOKEN_BEASE_URL, ZP_CLIENT_ID, ZP_REDIRECT_URL];

    NSURL *url = [NSURL URLWithString:str];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.loginWebView loadRequest:request];
}
#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"%@",request.URL.absoluteString);
    NSRange rang = [request.URL.absoluteString rangeOfString:@"code="];
    if (rang.location != NSNotFound) {
        // 2.截取已经授权的RequestToken, 然后后利用RequestToken换取AccessToken
        NSString *code = [request.URL.query substringFromIndex:@"code=".length];
        // 3.利用code换取AccessToken
        [self accessTokenWithCode:code];
        return NO;
    }
    return YES;
}
- (void)accessTokenWithCode:(NSString *)code
{
    //使用AFN框架和code获取AccessToken
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"client_id"] = ZP_CLIENT_ID;
    parameter[@"client_secret"] = ZP_SECRET;
    parameter[@"grant_type"] = @"authorization_code";
    parameter[@"code"] = code;
    parameter[@"redirect_uri"] = ZP_REDIRECT_URL;
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];

    [manager POST:ZP_ACCESSTOKEN_URL parameters:parameter success:^(NSURLSessionDataTask *task, id responseObject) {
        
        ZPAccount *account = [ZPAccount accountWithDict:responseObject];
        
        [account save];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD showWithStatus:@"请求失败" maskType:SVProgressHUDMaskTypeBlack];
    }];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [SVProgressHUD dismiss];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [SVProgressHUD dismiss];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [SVProgressHUD dismiss];
}

@end