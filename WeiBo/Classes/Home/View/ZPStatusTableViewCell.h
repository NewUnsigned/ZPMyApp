//
//  ZPStatusTableViewCell.h
//  WeiBo
//
//  Created by 赵鹏 on 15/4/13.
//  Copyright (c) 2015年 赵鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZPStatus;

@interface ZPStatusTableViewCell : UITableViewCell
@property (nonatomic, strong) ZPStatus *status;

- (CGFloat)countCellRowHight:(ZPStatus *)status;
@end
