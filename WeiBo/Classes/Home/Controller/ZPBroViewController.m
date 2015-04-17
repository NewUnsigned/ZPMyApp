//
//  ZPBroViewController.m
//  WeiBo
//
//  Created by 赵鹏 on 15/4/16.
//  Copyright (c) 2015年 赵鹏. All rights reserved.
//

#import "ZPBroViewController.h"
#import "ZPBroCollectionViewCell.h"
#import "ZPPhoto.h"
@interface ZPBroViewController () <UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *colView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *colFlowLayout;
@property (nonatomic, strong) UIImageView *imgView;
@end

@implementation ZPBroViewController
- (IBAction)closeBrowse {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)savePhoto {
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    UIImageView *imgView = scrollView.subviews.lastObject;
    return imgView;
}

#pragma mark - UICollectionViewDataSource
//
- (void)viewDidLoad
{
    [super viewDidLoad];
    //设置流水布局
    self.colFlowLayout.itemSize = self.view.frame.size;
    self.colFlowLayout.minimumInteritemSpacing = 0;
    self.colFlowLayout.minimumLineSpacing = 0;
    self.colFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //设置分页
    self.colView.pagingEnabled = YES;
    self.colView.bounces = NO;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return self.urlStrArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZPBroCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Collection_Cell" forIndexPath:indexPath];
    
    [self configureCell:cell forItemAtIndexPath:indexPath];

    return cell;
}
//设置cell
- (void)configureCell:(ZPBroCollectionViewCell *)cell
   forItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZPPhoto *photoName = self.urlStrArr[indexPath.item];
    cell.imgUrlString = photoName.thumbnail_pic;
    cell.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1];

}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
