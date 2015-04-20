//
//  ZPPictureSelectViewController.m
//  WeiBo
//
//  Created by 赵鹏 on 15/4/19.
//  Copyright (c) 2015年 赵鹏. All rights reserved.
//

#import "ZPPictureSelectViewController.h"

@interface ZPPictureSelectViewController ()

- (IBAction)dismissBtn:(id)sender;


@end

@implementation ZPPictureSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dismissBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
