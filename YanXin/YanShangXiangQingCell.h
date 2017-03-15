//
//  YanShangXiangQingCell.h
//  YanXin
//
//  Created by Macx on 17/2/16.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YanShangXiangQingCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView*)tableView CellID:(NSString*)cellID;
@property(nonatomic,strong)UIImageView * leftImage;
@property(nonatomic,strong)UILabel * titlelabel;
@property(nonatomic,strong)UILabel * nameLabel;
@end
