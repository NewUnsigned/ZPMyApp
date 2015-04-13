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
@interface ZPStatusTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *vipImage;
@property (weak, nonatomic) IBOutlet UILabel *statueSource;
@property (weak, nonatomic) IBOutlet UILabel *statueText;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation ZPStatusTableViewCell

- (void)setStatus:(ZPStatus *)status
{
    _status = status;
    NSURL *url = [NSURL URLWithString:status.user.profile_image_url];
    [self.iconImage sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"00"]];
    self.nameLabel.text = status.user.name;
    self.statueSource.text = status.source;
    self.statueText.text = status.text;
    self.timeLabel.text = status.created_at;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
