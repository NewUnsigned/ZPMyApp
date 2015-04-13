//
//  ZPHomeTableViewController.m
//  WeiBo
//
//  Created by 赵鹏 on 15/4/8.
//  Copyright (c) 2015年 赵鹏. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"
#import "UIView+Extension.h"
#import "ZPStatusTableViewCell.h"
#import <SVProgressHUD.h>
#import <MJExtension.h>
#import <AFNetworking.h>
#import <AFHTTPSessionManager.h>
#import "ZPButton.h"
#import "ZPHomeTableViewController.h"
#import "ZPSmallViewController.h"
#import "ZPSmallView.h"
#import "ZPStatus.h"
#import "ZPUser.h"
#import "ZPPhoto.h"
#import "ZPAccount.h"

@interface ZPHomeTableViewController () <ZPSmallViewDelegate>
@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong) ZPSmallView *smallBtn;
@property (nonatomic, strong) NSArray *weiboStatus;
@end

@implementation ZPHomeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftAndRightBarButtonItem];
    //设置titleView
    [self setTitleView];
    
    // 因为进入程序后首页标题按钮位置不对,需要点击一次位置才正确,因此在进入程序的时候模拟了一次点击
//    [self titleViewBtnClicked];
    
    [self setLogViewImageAndDegest];
    
    //加载微博数据
    [self loadWeiBoInfo];
}

- (void)loadWeiBoInfo
{
    //取出请求需要的参数
    ZPAccount *acount = [ZPAccount accountFromSandbox];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *parater = [NSMutableDictionary dictionary];
    parater[@"access_token"] = acount.access_token;
    
    [manager GET:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:parater success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *dicts = responseObject[@"statuses"];
        self.weiboStatus = [ZPStatus objectArrayWithKeyValuesArray:dicts];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"获取微博数据失败"];
    }];
    
    //创建请求
    
    //发送请求,解析返回的数据后刷新微博
}
- (void)setLogViewImageAndDegest
{
    self.degestLbl = @"当你关注一些人后,他们发布的最新消息会显示在这里";
    self.upImg = [UIImage imageNamed:@"visitordiscover_feed_image_house"];
    self.imagDown = [UIImage imageNamed:@"visitordiscover_feed_image_smallicon"];
    self.midImg = [UIImage imageNamed:@"visitordiscover_feed_mask_smallicon"];
    
}

ZPButton *_btn;
- (void)setTitleView
{
    _btn = [[ZPButton alloc]init];
    _btn.adjustsImageWhenHighlighted = NO;
    self.navigationItem.titleView = _btn;
    [_btn setTitle:@"没落帝国" forState:UIControlStateNormal];
    [_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_btn setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    [_btn setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
    
    [_btn sizeToFit];
    [_btn addTarget:self action:@selector(titleViewBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)titleViewBtnClicked
{
    _btn.selected = YES;
    [self.smallBtn test:self.view button:_btn];
    self.smallBtn.delegate = self;
}
- (void)buttonClicked
{
//    _btn.selected = !_btn.selected;
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.weiboStatus.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZPStatusTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WeiBoHome_Cell" forIndexPath:indexPath];
    ZPStatus *statu = self.weiboStatus[indexPath.row];
    cell.status = statu;
    return cell;
}
- (void)setLeftAndRightBarButtonItem
{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithNorImage:@"navigationbar_friendsearch" higImage:@"navigationbar_friendsearch_highlighted" title:nil target:self action:@selector(leftBarButtonItemClicked)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithNorImage:@"navigationbar_pop" higImage:@"navigationbar_pop_highlighted" title:nil target:self action:@selector(rightBarButtomItemClicked)];
}
-(void)leftBarButtonItemClicked
{
    NSLog(@"%s",__func__);
}
- (void)rightBarButtomItemClicked
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Scan" bundle:nil];
    UIViewController *vc = sb.instantiateInitialViewController;
    [self presentViewController:vc animated:YES completion:nil];
}

- (ZPSmallView *)smallBtn
{
    if (_smallBtn == nil) {
        _smallBtn = [[ZPSmallView alloc]init];
    }
    return _smallBtn;
}
- (NSArray *)weiboStatus
{
    if (_weiboStatus == nil) {
        _weiboStatus = [[NSArray alloc]init];
    }
    return _weiboStatus;
}
@end
