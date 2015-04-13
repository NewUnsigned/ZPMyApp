//
//  ZPStatusTableViewCell.m
//  WeiBo
//
//  Created by 赵鹏 on 15/4/13.
//  Copyright (c) 2015年 赵鹏. All rights reserved.
//

#import "ZPStatusTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "ZPStatus.h"
#import "ZPUser.h"
#import "ZPPhoto.h"
#import "UIView+Extension.h"
#import "ZPPictureCollectionViewCell.h"
@interface ZPStatusTableViewCell () <UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *colViewFlowLayout;
@property (weak, nonatomic) IBOutlet UICollectionView           *collectionCell;
@property (weak, nonatomic) IBOutlet UIImageView                *iconImage;
@property (weak, nonatomic) IBOutlet UIImageView                *vipImage;
@property (weak, nonatomic) IBOutlet UILabel                    *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel                    *statueSource;
@property (weak, nonatomic) IBOutlet UILabel                    *statueText;
@property (weak, nonatomic) IBOutlet UILabel                    *timeLabel;
@property (nonatomic, strong) NSArray *picArr;
@property (nonatomic,   copy) NSString *picName;
@end

@implementation ZPStatusTableViewCell

- (instancetype)init
{
    self = [super init];
    _colViewFlowLayout.minimumLineSpacing = 10;
    _colViewFlowLayout.minimumInteritemSpacing = 10;
    _colViewFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.picArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZPPhoto *picname;
    if (self.picArr.count != 0 &&self.picArr != nil ) {
        picname = self.picArr[indexPath.item];
    }
    ZPPictureCollectionViewCell *picCell1 = [collectionView dequeueReusableCellWithReuseIdentifier:@"Picture_Cell" forIndexPath:indexPath];
    picCell1.picImageName = picname.thumbnail_pic;
    CGRect colFrame = self.collectionCell.frame;
    colFrame.size.height = ((self.picArr.count ) / 3 + 1) * 100;
    self.collectionCell.frame = colFrame;
    return picCell1;
}

- (void)setStatus:(ZPStatus *)status
{
    _status = status;
    NSURL *url = [NSURL URLWithString:status.user.profile_image_url];
    [self.iconImage sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"00"]];
    self.iconImage.layer.cornerRadius = 22;
    self.iconImage.layer.masksToBounds = YES;
    self.nameLabel.text = status.user.name;
    self.statueSource.text = status.source;
    self.statueText.text = status.text;
    self.timeLabel.text = status.created_at;
    self.picArr = status.pic_urls;
    if (self.picArr.count == 0) {
        self.collectionCell.hidden = YES;
    }else{
        self.collectionCell.hidden = NO;
    }

}
- (NSArray *)picArr
{
    if (_picArr == nil) {
        _picArr = [[NSArray alloc]init];
    }
    return _picArr;
}

@end
