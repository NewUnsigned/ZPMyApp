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
#import "UIWindow+Extension.h"
#import "ZPProfileInfo.h"
#import <MJExtension.h>
#import "ZPNetworkingManager.h"

#define ZP_REQUEST_TOKEN_BEASE_URL @"https://api.weibo.com/oauth2/authorize"
#define ZP_CLIENT_ID @"422720824"

@interface ZPAuthViewController () <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *loginWebView;

@end

@implementation ZPAuthViewController
- (IBAction)backBtn {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loginWeiBo];
}
- (void)loginWeiBo
{
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
    NSRange rang = [request.URL.absoluteString rangeOfString:@"code="];
    if (rang.location != NSNotFound) {
        // 2.截取已经授权的RequestToken, 然后后利用RequestToken换取AccessToken
        NSString *code = [request.URL.query substringFromIndex:@"code=".length];
        // 3.利用code换取AccessToken
        [self accessTokenWithCode:code];
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [SVProgressHUD dismiss];
        [window chooseRootViewController];
        return NO;
    }
    return YES;
}
- (void)accessTokenWithCode:(NSString *)code
{
    ZPNetworkingManager *manager = [ZPNetworkingManager downloadManager];
    [manager getAccessTokenWithCode:code success:^(NSURLSessionDataTask *task, id responseObject) {
        ZPAccount *account = [ZPAccount accountWithDict:responseObject];
        [account save];
    } failuer:^(NSURLSessionDataTask *task, NSError *error) {
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
