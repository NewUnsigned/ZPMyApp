//
//  ZPStatuePictureCollectionViewCell.m
//  WeiBo
//
//  Created by 赵鹏 on 15/4/18.
//  Copyright (c) 2015年 赵鹏. All rights reserved.
//

#import "ZPStatuePictureCollectionViewCell.h"
@interface ZPStatuePictureCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIButton *addBtnState;

@property (weak, nonatomic) IBOutlet UIButton *deleteBtnState;

- (IBAction)addBtnClicked:(id)sender;
- (IBAction)deleteBtnClicked:(id)sender;

@end
@implementation ZPStatuePictureCollectionViewCell


- (void)setImage:(UIImage *)image
{
    if (image == nil) {
        self.deleteBtnState.hidden = YES;
        self.addBtnState.userInteractionEnabled = YES;
        // 注意: 重用问题, 每次要中心设置加号按钮的图片
        [self.addBtnState setBackgroundImage:[UIImage imageNamed:@"compose_pic_add"] forState:UIControlStateNormal];
        [self.addBtnState setBackgroundImage:[UIImage imageNamed:@"compose_pic_add_highlighted"] forState:UIControlStateHighlighted];
    }else
    {
        self.deleteBtnState.hidden = NO;
        self.addBtnState.userInteractionEnabled = NO;
        [self.addBtnState setBackgroundImage:image forState:UIControlStateNormal];
    }
}

- (IBAction)addBtnClicked:(id)sender {
    //注册通知,当按钮被点击时通知控制器设置图片并更新cell
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PictureCellAddButtonClicked" object:self];
}

- (IBAction)deleteBtnClicked:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PictureCellDeleteButtonClicked" object:self];

}
@end
