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
#import "ZPTabBar.h"
#import <PopMenu.h>
#import "ZPProfileInfo.h"
#import "ZPBroViewController.h"

@interface ZPHomeTableViewController () <ZPSmallViewDelegate>
@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong) ZPSmallView *smallBtn;
@property (nonatomic, strong) NSArray *weiboStatus;
@property (nonatomic, strong) PopMenu *popMenu;;
@property (nonatomic, strong)
NSCache *rowHightCache;

@end

@implementation ZPHomeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftAndRightBarButtonItem];
    //设置titleView
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showPopMenu) name:@"TabBarPlusButtonClicked" object:nil];

    [self setTitleView];
    // 因为进入程序后首页标题按钮位置不对,需要点击一次位置才正确,因此在进入程序的时候模拟了一次点击
//    [self titleViewBtnClicked];
    [self setLogViewImageAndDegest];
//    self.tableView.rowHeight = UITableViewAutomaticDimension;
    //加载微博数据
    [self loadWeiBoInfo];
}
- (void)showPopMenu
{
    NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:3];
    MenuItem  *menuItem = [[MenuItem alloc] initWithTitle:@"文字" iconName:@"post_type_bubble_flickr" glowColor:[UIColor grayColor] index:0];
    [items addObject:menuItem];
    
    menuItem = [[MenuItem alloc] initWithTitle:@"相册" iconName:@"post_type_bubble_googleplus" glowColor:[UIColor colorWithRed:0.000 green:0.840 blue:0.000 alpha:1.000] index:0];
    [items addObject:menuItem];
    
    menuItem = [[MenuItem alloc] initWithTitle:@"拍摄" iconName:@"post_type_bubble_instagram" glowColor:[UIColor colorWithRed:0.687 green:0.000 blue:0.000 alpha:1.000] index:0];
    [items addObject:menuItem];
    
    menuItem = [[MenuItem alloc] initWithTitle:@"签到" iconName:@"post_type_bubble_twitter" glowColor:[UIColor colorWithRed:0.687 green:0.000 blue:0.000 alpha:1.000] index:0];
    [items addObject:menuItem];
    
    menuItem = [[MenuItem alloc] initWithTitle:@"点评" iconName:@"post_type_bubble_youtube" glowColor:[UIColor colorWithRed:0.687 green:0.000 blue:0.000 alpha:1.000] index:0];
    [items addObject:menuItem];
    
    menuItem = [[MenuItem alloc] initWithTitle:@"更多" iconName:@"post_type_bubble_facebook" glowColor:[UIColor colorWithRed:0.687 green:0.000 blue:0.000 alpha:1.000] index:0];
    [items addObject:menuItem];
    
    CGRect screenFrame = [UIScreen mainScreen].bounds;
    if (!_popMenu) {
        _popMenu = [[PopMenu alloc] initWithFrame:screenFrame items:items];
        _popMenu.menuAnimationType = kPopMenuAnimationTypeNetEase;
    }
    if (_popMenu.isShowed) {
        return;
    }
    __block typeof(self) weakSelf = self;
    _popMenu.didSelectedItemCompletion = ^(MenuItem *selectedItem) {
        if (selectedItem.index == 2) {
            NSLog(@"%s",__func__);
            [weakSelf pushView];
//            [self.navigationController pushViewController:vc animated:YES];
        }
    };
    
    [_popMenu showMenuAtView:self.navigationController.tabBarController.view];
    [_popMenu showMenuAtView:self.navigationController.tabBarController.view startPoint:CGPointMake(CGRectGetWidth(screenFrame) - 60, CGRectGetHeight(screenFrame)) endPoint:CGPointMake(60, CGRectGetHeight(screenFrame))];
}
- (void)pushView
{
    UIViewController *vc = [[UIViewController alloc]init];
    vc.view.frame = [UIScreen mainScreen].bounds;
    vc.view.backgroundColor = [UIColor orangeColor];
    [self presentViewController:vc animated:YES completion:nil];
}
- (void)loadWeiBoInfo
{
    //取出请求需要的参数
    ZPAccount *acount = [ZPAccount accountFromSandbox];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *parater = [NSMutableDictionary dictionary];
    if (acount == nil) {
        return;
    }
    parater[@"access_token"] = acount.access_token;
    
    [manager GET:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:parater success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *dicts = responseObject[@"statuses"];
        self.weiboStatus = [ZPStatus objectArrayWithKeyValuesArray:dicts];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"获取微博数据失败"];
    }];

}
- (void)setLogViewImageAndDegest
{
    self.degestLbl = @"当你关注一些人后,他们发布的最新消息会显示在这里";
    self.upImg     = [UIImage imageNamed:@"visitordiscover_feed_image_house"];
    self.imagDown  = [UIImage imageNamed:@"visitordiscover_feed_image_smallicon"];
    self.midImg    = [UIImage imageNamed:@"visitordiscover_feed_mask_smallicon"];
}

ZPButton *_btn;
- (void)setTitleView
{
    ZPProfileInfo *profile = [ZPProfileInfo pfofileFromSandbox];
    NSString *userName = profile.screen_name;
    if (userName == nil) {
        userName = @"用户名";
    }
    _btn = [[ZPButton alloc]init];
    _btn.adjustsImageWhenHighlighted = NO;
    self.navigationItem.titleView = _btn;
    [_btn setTitle:userName forState:UIControlStateNormal];
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
    ZPStatus *statu = self.weiboStatus[indexPath.row];
    ZPStatusTableViewCell *picCell1 = [tableView dequeueReusableCellWithIdentifier:[ZPStatusTableViewCell indentifierWithStatus:statu] forIndexPath:indexPath];
    picCell1.status = statu;
    __weak typeof(self) weakSelf = self;
    picCell1.cellIndexPatnSelected = ^(NSIndexPath *path){
        UIStoryboard *browserSB = [UIStoryboard storyboardWithName:@"Browser" bundle:nil];
        ZPBroViewController *browserVC = browserSB.instantiateInitialViewController;
        browserVC.urlStrArr = statu.pic_urls;
        browserVC.indexPath = path;
        [weakSelf.navigationController presentViewController:browserVC animated:YES completion:nil];
    };
    return picCell1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ZPStatus *statue = self.weiboStatus[indexPath.row];
    ZPStatusTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[ZPStatusTableViewCell indentifierWithStatus:statue]];
    
    NSNumber *rowHight = [self.rowHightCache objectForKey:statue.idstr];
    
    if (rowHight == nil) {
        //使用NSCache将计算的高度缓存起来
        NSUInteger rowHightNum = [cell countCellRowHight:statue];
        rowHight = @(rowHightNum);
        [_rowHightCache setObject:rowHight forKey:statue.idstr];
    }
    
    return rowHight.integerValue;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

- (CGSize)sizeOfText:(NSString *)text Font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
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
- (NSCache *)rowHightCache
{
    if (_rowHightCache == nil) {
        _rowHightCache = [[NSCache alloc]init];
    }
    return _rowHightCache;
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
