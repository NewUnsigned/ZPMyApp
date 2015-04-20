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
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *picFlowLayout;

@end

@implementation ZPPicktureCollectionViewController

static NSString * const reuseIdentifier = @"Status_Pickture_Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.collectionView registerClass:[ZPStatuePictureCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    self.picFlowLayout.itemSize = CGSizeMake(90, 90);
    self.picFlowLayout.minimumLineSpacing = 10;
    self.picFlowLayout.minimumInteritemSpacing = 10;
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZPStatuePictureCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor redColor];
    cell.image = [UIImage imageNamed:@"00"];
    return cell;
}


@end
