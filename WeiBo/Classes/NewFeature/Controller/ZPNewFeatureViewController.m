//
//  ZPNewFeatureViewController.m
//  WeiBo
//
//  Created by 赵鹏 on 15/4/12.
//  Copyright (c) 2015年 赵鹏. All rights reserved.
//

#import "ZPNewFeatureViewController.h"

@interface ZPNewFeatureViewController ()

@end

@implementation ZPNewFeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)NewFeatureBtn {
    UIStoryboard *newSB = [UIStoryboard storyboardWithName:@"Welcome" bundle:nil];
    [UIApplication sharedApplication].keyWindow.rootViewController = newSB.instantiateInitialViewController;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
