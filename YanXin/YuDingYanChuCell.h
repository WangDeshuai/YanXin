//
//  YuDingYanChuCell.h
//  YanXin
//
//  Created by Macx on 17/2/15.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YuDingYanChuCell.h"
@interface YuDingYanChuCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView*)tableView CellID:(NSString*)cellID;
@property(nonatomic,strong)UILabel * titlelabel;
@property(nonatomic,strong)UITextField * textfield;
@property(nonatomic,strong)UITextView * textView;
@property(nonatomic,strong)UIButton * seleteBtn;
@end
