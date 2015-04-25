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
#import "ZPButton.h"
#import "ZPHomeTableViewController.h"
#import "ZPSmallViewController.h"
#import "ZPSmallView.h"
#import "ZPStatus.h"
#import "ZPUser.h"
#import "ZPPhoto.h"
#import "ZPTabBar.h"
#import <PopMenu.h>
#import "ZPProfileInfo.h"
#import "ZPBroViewController.h"
#import "ZPSendViewController.h"
#import <MJRefresh/MJRefresh.h>
#import <MWPhotoBrowser.h>
#import "ZPNetworkingManager.h"

@interface ZPHomeTableViewController () <ZPTabBarCustomDelegate,MWPhotoBrowserDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong) ZPSmallView *smallBtn;
@property (nonatomic, strong) NSMutableArray *weiboStatus;
@property (nonatomic, strong) PopMenu *popMenu;;
@property (nonatomic, strong) NSCache *rowHightCache;
@property (nonatomic, strong) NSMutableArray *photos;

@end

@implementation ZPHomeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setLeftAndRightBarButtonItem];
    //设置titleView
    ZPTabBar *customTabbar = (ZPTabBar *) self.tabBarController.tabBar;
    customTabbar.customDelegate = self;
    [self setTitleView];
    [self setLogViewImageAndDegest];
    //加载微博数据
    [self loadWeiBoInfo];
    [self pullDownUpdate];
}
#pragma mark - 下拉/上拉刷新
- (void)pullDownUpdate {
    __weak typeof(self) weakSelf = self;
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
        //取出请求需要的参数
        ZPStatus *status = [weakSelf.weiboStatus firstObject];
        NSString *idstr = status.idstr;
        if (idstr == nil || [idstr isEqualToString: @""]) {
            idstr = @"0";
        }
        [weakSelf loadNewStatusWithIdstr:idstr header:YES];

    }];
    
    [self.tableView addLegendFooterWithRefreshingBlock:^{
        //取出请求需要的参数
        ZPStatus *status = [weakSelf.weiboStatus lastObject];
        NSUInteger idstrNum = status.idstr.integerValue;
        NSString *idstr = [NSString stringWithFormat:@"%tu",idstrNum - 1];
        [weakSelf loadNewStatusWithIdstr:idstr header:NO];
        
    }];
    
}

- (void)loadNewStatusWithIdstr:(NSString *)idstr header:(BOOL)header
{
    
    ZPNetworkingManager *manager1 = [ZPNetworkingManager downloadManager];
    
    [manager1 loadNewStatusWithIdstr:idstr header:header success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *dicts = responseObject[@"statuses"];
        NSArray *tempArr = [ZPStatus objectArrayWithKeyValuesArray:dicts];
        if (header) {
            // 插入到最前面
            NSRange range = NSMakeRange(0, tempArr.count);
            NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:range];
            [self.weiboStatus insertObjects:tempArr atIndexes:set];
            
            // 显示提醒文本
            [self showNewStatusCount: tempArr.count];
        }else{
            // 插入到末尾
            [self.weiboStatus addObjectsFromArray:tempArr];
        }
        [self.tableView reloadData];
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"获取微博数据失败"];
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];
    }];
}
// 显示刷新提醒
- (void)showNewStatusCount:(NSInteger)count
{
    // 1.创建Label
    UILabel *countLabel = [[UILabel alloc] init];
    // 2.设置Label的属性
    CGFloat labelW = self.view.width;
    CGFloat labelH = 30;
    CGFloat labelX = 0;
    CGFloat labelY = 64 - labelH;
    countLabel.frame = CGRectMake(labelX, labelY, labelW, labelH);
    NSString *text = nil;
    if (count == 0) {
        text = @"没有更多微博数据";
    }else
    {
        text = [NSString stringWithFormat:@"%tu 条新微博", count];
    }
    countLabel.text = text;
    
    countLabel.backgroundColor = [UIColor orangeColor];
    UINavigationBar *bar = self.navigationController.navigationBar;
    [self.navigationController.view insertSubview:countLabel belowSubview:bar];
    
    countLabel.textAlignment = NSTextAlignmentCenter;
    countLabel.textColor = [UIColor whiteColor];
    
    // 3.执行动画
    [UIView animateWithDuration:0.5 animations:^{
        // 让提醒问下向下移动
        countLabel.transform = CGAffineTransformMakeTranslation(0, labelH);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 delay:1 options:0 animations:^{
            // 让提醒文本向上移动
            countLabel.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            // 销毁提醒文本
            [countLabel removeFromSuperview];
        }];
    }];
}

- (void)tabbar:(ZPTabBar *)tabbar plusButtonClicked:(UIButton *)plusBtn
{
    [self showPopMenu];
}
//MARK: 发送微博 底部加号按钮
- (void)showPopMenu
{
    NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:3];
    MenuItem  *menuItem = [[MenuItem alloc] initWithTitle:@"文字" iconName:@"tabbar_compose_idea" glowColor:[UIColor grayColor] index:0];
    [items addObject:menuItem];
    
    menuItem = [[MenuItem alloc] initWithTitle:@"相册" iconName:@"tabbar_compose_photo" glowColor:[UIColor colorWithRed:0.000 green:0.840 blue:0.000 alpha:1.000] index:0];
    [items addObject:menuItem];
    
    menuItem = [[MenuItem alloc] initWithTitle:@"拍摄" iconName:@"tabbar_compose_camera" glowColor:[UIColor colorWithRed:0.687 green:0.000 blue:0.000 alpha:1.000] index:0];
    [items addObject:menuItem];
    
    menuItem = [[MenuItem alloc] initWithTitle:@"签到" iconName:@"tabbar_compose_lbs" glowColor:[UIColor colorWithRed:0.687 green:0.000 blue:0.000 alpha:1.000] index:0];
    [items addObject:menuItem];
    
    menuItem = [[MenuItem alloc] initWithTitle:@"点评" iconName:@"tabbar_compose_review" glowColor:[UIColor colorWithRed:0.687 green:0.000 blue:0.000 alpha:1.000] index:0];
    [items addObject:menuItem];
    
    menuItem = [[MenuItem alloc] initWithTitle:@"更多" iconName:@"tabbar_compose_more" glowColor:[UIColor colorWithRed:0.687 green:0.000 blue:0.000 alpha:1.000] index:0];
    [items addObject:menuItem];
    
    CGRect screenFrame = [UIScreen mainScreen].bounds;
    if (!_popMenu) {
        _popMenu = [[PopMenu alloc] initWithFrame:screenFrame items:items];
        _popMenu.menuAnimationType = kPopMenuAnimationTypeSina;
    }
    if (_popMenu.isShowed) {
        return;
    }
    __block typeof(self) weakSelf = self;
    _popMenu.didSelectedItemCompletion = ^(MenuItem *selectedItem) {
        switch (selectedItem.index) {
            case 0:
                [weakSelf pushView];
                break;
            case 1:
                [weakSelf tackPickture];
                break;
            case 2:
                [weakSelf tackPhoto];
                break;
            case 3:
                [weakSelf pushView];
                break;
            case 4:
                [weakSelf pushView];
                break;
            case 5:
                [weakSelf pushView];
                break;
            default:
                break;
        }
    };
    
    [_popMenu showMenuAtView:self.navigationController.tabBarController.view];
    [_popMenu showMenuAtView:self.navigationController.tabBarController.view startPoint:CGPointMake(CGRectGetWidth(screenFrame) - 60, CGRectGetHeight(screenFrame)) endPoint:CGPointMake(60, CGRectGetHeight(screenFrame))];
}
- (void)tackPhoto
{
    //先设定sourceType为相机，然后判断相机是否可用（ipod）没相机，不可用将sourceType设定为相片库
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    //sourceType = UIImagePickerControllerSourceTypeCamera; //照相机
    //sourceType = UIImagePickerControllerSourceTypePhotoLibrary; //图片库
    //sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum; //保存的相片
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
    picker.delegate = self;
    picker.allowsEditing = YES;//设置可编辑
    picker.sourceType = sourceType;
    [self presentViewController:picker animated:YES completion:nil];//进入照相界面
}
- (void)tackPickture
{
    UIStoryboard *picSB = [UIStoryboard storyboardWithName:@"ZPPictureSelectViewController" bundle:nil];
    UIViewController *picVC = picSB.instantiateInitialViewController;
    [self.navigationController presentViewController:picVC animated:YES completion:nil];
}
- (void)pushView
{
    //发送微博  控制器
    UIStoryboard *sendSB = [UIStoryboard storyboardWithName:@"ZPSendViewController" bundle:nil];
    ZPSendViewController *sendVC = sendSB.instantiateInitialViewController;
    [self.navigationController presentViewController:sendVC animated:YES completion:nil];
    
}
//MARK: 下载微博数据
- (void)loadWeiBoInfo
{
    ZPNetworkingManager *manager = [ZPNetworkingManager downloadManager];
    [manager loadWeiBoInfomation:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *dicts = responseObject[@"statuses"];
        self.weiboStatus = [[ZPStatus objectArrayWithKeyValuesArray:dicts] mutableCopy];
        [self.tableView reloadData];
    } failuer:^(NSURLSessionDataTask *task, NSError *error) {
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
//MARK: 顶部用户名标题
- (void)titleViewBtnClicked
{
    _btn.selected = YES;
    [self.smallBtn test:self.view button:_btn];
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
        /*
        //自定义图片浏览器
        UIStoryboard *browserSB = [UIStoryboard storyboardWithName:@"Browser" bundle:nil];
        ZPBroViewController *browserVC = browserSB.instantiateInitialViewController;
        if (statu.retweeted_status != nil) {
            browserVC.urlStrArr = statu.retweeted_status.pic_urls;
        }else{
            browserVC.urlStrArr = statu.pic_urls;
        }
        browserVC.indexPath = path;
        [weakSelf.navigationController presentViewController:browserVC animated:YES completion:nil];
         */
    //使用MWPhotoBrowser框架图片浏览器
        self.photos = nil;
        NSArray *urlArr = [NSArray array];
        if (statu.retweeted_status != nil) {
            urlArr = [statu.retweeted_status.pic_urls valueForKey:@"bmiddle_pic"];
            
        }else{
            urlArr = [statu.pic_urls valueForKey:@"bmiddle_pic"];
            
        }
        for (int i = 0; i < urlArr.count; i++) {
            NSURL *url = [NSURL URLWithString:urlArr[i]];
            MWPhoto *photo = [[MWPhoto alloc]initWithURL:url];
            [weakSelf.photos addObject:photo];
        }
        MWPhotoBrowser *photoBrowser = [[MWPhotoBrowser alloc]initWithDelegate:weakSelf];
        [photoBrowser setCurrentPhotoIndex:path.item];
        photoBrowser.displayActionButton = YES;
        photoBrowser.displayNavArrows = YES;
        photoBrowser.displaySelectionButtons = YES;
        photoBrowser.zoomPhotosToFill = YES;
        photoBrowser.alwaysShowControls = YES;
        photoBrowser.enableGrid = YES;
        photoBrowser.startOnGrid = YES;
        [weakSelf.navigationController pushViewController:photoBrowser animated:YES];
    };
    return picCell1;
}
#pragma mark - MWPhotoBrowserDelegate
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return self.photos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < self.photos.count)
        return [self.photos objectAtIndex:index];
    return nil;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZPStatus *statue = self.weiboStatus[indexPath.row];
    return statue.rowHight;
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
//MARK: 左右item

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
//MARK: 懒加载函数
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
        _weiboStatus = [[NSMutableArray alloc]init];
    }
    return _weiboStatus;
}
- (NSMutableArray *)photos
{
    if (_photos == nil) {
        _photos = [NSMutableArray array];
    }
    return _photos;
}
@end
