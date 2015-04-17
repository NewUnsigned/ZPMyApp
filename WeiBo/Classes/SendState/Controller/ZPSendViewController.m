//
//  ZPSendViewController.m
//  WeiBo
//
//  Created by 赵鹏 on 15/4/17.
//  Copyright (c) 2015年 赵鹏. All rights reserved.
//

#import "ZPSendViewController.h"
#import "ZPSendTextView.h"

@interface ZPSendViewController () <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet ZPSendTextView *sendText;
@property (weak, nonatomic) IBOutlet UIView *sendConView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *recent;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *defaultEmoji;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *emoji;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *langXiaoHua;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sendBtnState;
- (IBAction)closeSendVC:(id)sender;
- (IBAction)sendStatue:(id)sender;

@end

@implementation ZPSendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //直接进入编辑状态
    [self becomeFirstResponder];
    self.sendText.delegate = self;
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
    return YES;
}
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
- (IBAction)closeSendVC:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)sendStatue:(id)sender {

}
@end
