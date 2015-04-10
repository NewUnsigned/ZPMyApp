//
//  ZPSmallViewController.m
//  WeiBo
//
//  Created by 赵鹏 on 15/4/10.
//  Copyright (c) 2015年 赵鹏. All rights reserved.
//

#import "ZPSmallViewController.h"

@interface ZPSmallViewController ()

@end

@implementation ZPSmallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"SmallView_Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    if (cell == nil) {
        
    }
    return cell;
}

@end
