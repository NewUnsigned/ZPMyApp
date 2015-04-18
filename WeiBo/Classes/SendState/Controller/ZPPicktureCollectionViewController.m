//
//  ZPPicktureCollectionViewController.m
//  WeiBo
//
//  Created by 赵鹏 on 15/4/18.
//  Copyright (c) 2015年 赵鹏. All rights reserved.
//

#import "ZPPicktureCollectionViewController.h"
#import "ZPStatuePictureCollectionViewCell.h"

@interface ZPPicktureCollectionViewController ()

@end

@implementation ZPPicktureCollectionViewController

static NSString * const reuseIdentifier = @"Status_Pickture_Cell";

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.collectionView registerClass:[ZPStatuePictureCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
}

#pragma mark <UICollectionViewDataSource>

//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//    return 1;
//}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 8;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZPStatuePictureCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor redColor];
    
    return cell;
}


@end
