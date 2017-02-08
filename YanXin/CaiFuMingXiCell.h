//
//  CaiFuMingXiCell.h
//  YanXin
//
//  Created by Macx on 17/2/8.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YiHuoDeModel.h"
@interface CaiFuMingXiCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView*)tableView CellID:(NSString*)cellID;
@property(nonatomic,strong)YiHuoDeModel * model;
@end
