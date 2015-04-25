//
//  ZPSendViewController.m
//  WeiBo
//
//  Created by 赵鹏 on 15/4/17.
//  Copyright (c) 2015年 赵鹏. All rights reserved.
//

#import "ZPSendViewController.h"
#import "ZPSendTextView.h"
#import <AFNetworking/AFNetworking.h>
#import "ZPStatus.h"
#import "ZPAccount.h"
#import <MJExtension.h>
#import <SVProgressHUD.h>
#import "ZPPictureSelectViewController.h"

@interface ZPSendViewController () <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet ZPSendTextView *sendText;
@property (weak, nonatomic) IBOutlet UIButton *showImage;
@property (weak, nonatomic) IBOutlet UIButton *longStatue;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sendBtnState;

- (IBAction)selectPicture;

- (IBAction)closeSendVC:(id)sender;
- (IBAction)sendStatue:(id)sender;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toolBarBottonConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewConstraint;
@end

@implementation ZPSendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //直接进入编辑状态
    [self becomeFirstResponder];
    self.sendText.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
}

//键盘将要弹出
- (void)keyBoardWillShow:(NSNotification *)note
{
    //获取键盘的键盘的高度
    CGRect keyBoardFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyBoardHight = keyBoardFrame.size.height;
    CGFloat animationTime = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    self.toolBarBottonConstraint.constant = keyBoardHight;
    NSUInteger curve = [note.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    [UIView animateWithDuration:animationTime delay:0 options:curve << 16 animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
}
//键盘将要隐藏
- (void)keyBoardWillHidden:(NSNotification *)note
{
    NSLog(@"%s",__func__);
}

#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView
{
    //当输入文本为空时,显示占位字符,否则隐藏
    if (textView.text.length > 0) {
        _sendText.textLbl.hidden = YES;
        _sendBtnState.enabled = YES;
    }else{
        _sendText.textLbl.hidden = NO;
        _sendBtnState.enabled = NO;
    }
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    [self becomeFirstResponder];
    [UIView animateWithDuration:5 animations:^{
        self.toolBarBottonConstraint.constant = 255;
    }];
    return YES;
}
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    [UIView animateWithDuration:5 animations:^{
        self.toolBarBottonConstraint.constant = 0;
    }];
    [self.view endEditing:YES];
}
//选择图片
- (IBAction)selectPicture {

    [UIView animateWithDuration:0.2 animations:^{
        self.toolBarBottonConstraint.constant = 0;
    } completion:^(BOOL finished) {
        UIStoryboard *picSB = [UIStoryboard storyboardWithName:@"ZPPictureSelectViewController" bundle:nil];
        UIViewController *picVC = picSB.instantiateInitialViewController;
        [self.navigationController presentViewController:picVC animated:YES completion:nil];
    }];
}


- (IBAction)closeSendVC:(id)sender {
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)sendStatue:(id)sender {
    //发送微博
    ZPAccount *acount = [ZPAccount accountFromSandbox];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *parater = [NSMutableDictionary dictionary];
    parater[@"access_token"] = acount.access_token;
    parater[@"status"] = self.sendText.text;
   
    [manager POST:@"https://api.weibo.com/2/statuses/update.json" parameters:parater success:^(NSURLSessionDataTask *task, id responseObject) {
        //关闭键盘
        [self.view endEditing:YES];
        //转发完成,关闭发送页面
        [self dismissViewControllerAnimated:YES completion:nil];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"发送微博数据失败"];

    }];
}
@end
