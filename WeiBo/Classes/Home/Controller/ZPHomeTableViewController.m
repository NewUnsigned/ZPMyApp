//
//  ZPHomeTableViewController.m
//  WeiBo
//
//  Created by 赵鹏 on 15/4/8.
//  Copyright (c) 2015年 赵鹏. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"
#import "UIView+Extension.h"
#import "ZPButton.h"
#import "ZPHomeTableViewController.h"
#import "ZPSmallViewController.h"
#import "ZPSmallView.h"

@interface ZPHomeTableViewController () <ZPSmallViewDelegate>
@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong) ZPSmallView *smallBtn;
@end

@implementation ZPHomeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftAndRightBarButtonItem];
    //设置titleView
    [self setTitleView];
    
    // 因为进入程序后首页标题按钮位置不对,需要点击一次位置才正确,因此在进入程序的时候模拟了一次点击
    [self titleViewBtnClicked];
    
    [self setLogViewImageAndDegest];
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
    [_btn setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    [_btn setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateSelected];
    
    [_btn sizeToFit];
    [_btn addTarget:self action:@selector(titleViewBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)titleViewBtnClicked
{
    [self.smallBtn test:self.view button:_btn];
    self.smallBtn.delegate = self;
}
- (void)buttonClicked
{
    _btn.selected = !_btn.selected;
}

/*
- (void)addSmallView
{
    _window = [[UIWindow alloc]init];
    _window.frame = self.view.frame;//view的frame是变化的
    _window.hidden = NO;
    _window.windowLevel = UIWindowLevelAlert + 1;
    
    UIButton *smallBtn = [[UIButton alloc]init];
    [smallBtn addTarget:self action:@selector(smallBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    smallBtn.frame = self.view.frame;
    smallBtn.alpha = 0.2;
    smallBtn.backgroundColor = [UIColor grayColor];
    [_window addSubview:smallBtn];

    //TODO: frame需要重新设置
    UIImageView *imgView = [[UIImageView alloc]init];
    CGFloat imgViewW = self.view.width * 0.5;
    CGFloat imgViewH = self.view.height * 0.4;
    CGFloat imgViewX = _btn.x + _btn.width * 0.5 - imgViewW * 0.5;
    CGFloat imgViewY = _btn.y + _btn.height + 20;
    imgView.frame = CGRectMake(imgViewX, imgViewY, imgViewW, imgViewH);
    imgView.image = [UIImage imageNamed:@"popover_background"];
    imgView.userInteractionEnabled = YES;
    [_window addSubview:imgView];

    ZPSmallViewController *smallVC = [[ZPSmallViewController alloc]init];
    smallVC.view.frame = CGRectMake(10, 15, (imgViewW - 20), (imgViewH - 25));
    [imgView addSubview:smallVC.view];

}
- (void)smallBtnClicked
{
    _btn.selected = !_btn.selected;
    _window = nil;
}
 */
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WeiBo_Cell" forIndexPath:indexPath];
    
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
@end
