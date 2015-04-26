//
//  ZPPicktureCollectionViewController.m
//  WeiBo
//
//  Created by 赵鹏 on 15/4/18.
//  Copyright (c) 2015年 赵鹏. All rights reserved.
//

#import "ZPPicktureCollectionViewController.h"
#import "ZPStatuePictureCollectionViewCell.h"

@interface ZPPicktureCollectionViewController () <UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *picFlowLayout;

@property (nonatomic, strong) NSMutableArray *picArr;
@end

@implementation ZPPicktureCollectionViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setFlowLayout];
    
    [self addNotification];
}
- (void)addNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addBtnClicked:) name:@"PictureCellAddButtonClicked" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteBtnClicked:) name:@"PictureCellDeleteButtonClicked" object:nil];

}


- (void)addBtnClicked:(NSNotification *)note
{    
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    [self.navigationController presentViewController:picker animated:YES completion:nil];
}
- (void)deleteBtnClicked:(NSNotification *)note
{
    ZPStatuePictureCollectionViewCell *cell = note.object;
    
    NSIndexPath *path = cell.indexPath;
    
    [self.picArr removeObjectAtIndex:path.item];
    
    [self.collectionView reloadData];
}
//选着完图片调用
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
}
//返回选着的图片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *img = info[UIImagePickerControllerOriginalImage];
    [self.picArr addObject:img];
    [self.collectionView reloadData];
    [self dismissViewControllerAnimated:YES completion:nil];
}
//取消的时候调用
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"PictureCellAddButtonClicked" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"PictureCellDeleteButtonClicked" object:nil];
}

- (void)setFlowLayout{
    CGFloat margin = 10;
    CGFloat cellW = ([UIScreen mainScreen].bounds.size.width - 4 * margin) / 3;
    CGFloat cellH = cellW;
    
    self.picFlowLayout.itemSize = CGSizeMake(cellW, cellH);
    self.picFlowLayout.minimumLineSpacing = 10;
    self.picFlowLayout.minimumInteritemSpacing = 10;
    self.picFlowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
}
#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.picArr.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZPStatuePictureCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Status_Pickture_Cell" forIndexPath:indexPath];
    if (indexPath.item == self.picArr.count) {
        cell.image = nil;
    }else{
        cell.image = self.picArr[indexPath.item];
    }
    cell.indexPath = indexPath;
    return cell;
}

- (NSMutableArray *)picArr
{
    if (_picArr == nil) {
        _picArr = [NSMutableArray array];
    }
    return _picArr;
}

@end
