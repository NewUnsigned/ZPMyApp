//
//  ZPStatuePictureCollectionViewCell.m
//  WeiBo
//
//  Created by 赵鹏 on 15/4/18.
//  Copyright (c) 2015年 赵鹏. All rights reserved.
//

#import "ZPStatuePictureCollectionViewCell.h"
@interface ZPStatuePictureCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIButton *pictureBtn;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;

- (IBAction)deleteBtnClicked:(id)sender;
@end
@implementation ZPStatuePictureCollectionViewCell

- (void)deleteBtnClicked:(id)sender
{
    
}

- (void)setImage:(UIImage *)image
{
    if (image == nil) {
        self.deleteBtn.hidden = YES;
        
        // 注意: 重用问题, 每次要中心设置加号按钮的图片
        [self.pictureBtn setBackgroundImage:[UIImage imageNamed:@"compose_pic_add"] forState:UIControlStateNormal];
        [self.pictureBtn setBackgroundImage:[UIImage imageNamed:@"compose_pic_add_highlighted"] forState:UIControlStateHighlighted];
    }else
    {
        self.deleteBtn.hidden = NO;
        [self.pictureBtn setBackgroundImage:image forState:UIControlStateNormal];
    }
}

@end
