//
//  ZPAuthViewController.m
//  WeiBo
//
//  Created by 赵鹏 on 15/4/12.
//  Copyright (c) 2015年 赵鹏. All rights reserved.
//

#import "ZPAuthViewController.h"
#import <AFNetworking.h>

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
    NSLog(@"%s",__func__);
    self.loginWebView.delegate = self;
    //请求的URL
    NSString *str = [NSString stringWithFormat:@" https://api.weibo.com/oauth2/authorize?client_id= 422720824&redirect_uri= http://baidu.com"];
    NSURL *url = [NSURL URLWithString:str];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.loginWebView loadRequest:request];
}
#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
 {
     return YES;
 }
- (void)webViewDidStartLoad:(UIWebView *)webView
    {
        
    }
- (void)webViewDidFinishLoad:(UIWebView *)webView
                     {
                         
                     }
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
    {
        
    }

@end
