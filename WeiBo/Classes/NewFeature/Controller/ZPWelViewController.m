//
//  ZPWelViewController.m
//  WeiBo
//
//  Created by 赵鹏 on 15/4/12.
//  Copyright (c) 2015年 赵鹏. All rights reserved.
//

#import "ZPWelViewController.h"
#import "ZPAccount.h"
#import <MJExtension.h>
#import "ZPProfileInfo.h"
#import <UIImageView+WebCache.h>

@interface ZPWelViewController ()
@property (weak, nonatomic) IBOutlet UILabel *welLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgMidconstraint;
@end

@implementation ZPWelViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.iconImage.layer.cornerRadius = 50;
    self.iconImage.layer.masksToBounds = YES;
    ZPProfileInfo *profile = [ZPProfileInfo pfofileFromSandbox];
    NSURL *url = [NSURL URLWithString:profile.profile_image_url];
    if (profile.profile_image_url != nil) {
        [self.iconImage sd_setImageWithURL:url];
    }
    [self setIconImageWithURL];
}
- (void)setIconImageWithURLk
{
    ZPAccount *account = [ZPAccount accountFromSandbox];
    NSString *urlString = [NSString stringWithFormat:@"https://api.weibo.com/2/users/show.json?access_token=%@&uid=%@",account.access_token,account.uid];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        ZPProfileInfo *profile = [ZPProfileInfo objectWithKeyValues:dict];
        NSLog(@"%@",profile.profile_image_url);
        [profile save];
    }];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [UIView animateWithDuration:1 animations:^{
        self.imgMidconstraint.constant = 120;
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1 animations:^{
            self.welLabel.alpha = 1;
        }completion:^(BOOL finished) {
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            [UIApplication sharedApplication].keyWindow.rootViewController = sb.instantiateInitialViewController;
        }];
    }];
}

@end
