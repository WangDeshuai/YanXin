//
//  YanShangXiangQingCell.m
//  YanXin
//
//  Created by Macx on 17/2/16.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "YanShangXiangQingCell.h"

@implementation YanShangXiangQingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+(instancetype)cellWithTableView:(UITableView*)tableView CellID:(NSString*)cellID{
    YanShangXiangQingCell * cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell=[[YanShangXiangQingCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self startCell];
    }
    return self;
}

-(void)startCell{
    _leftImage=[UIImageView new];
    
    _titlelabel=[UILabel new];
    _nameLabel=[UILabel new];
    
    [self.contentView sd_addSubviews:@[_leftImage,_titlelabel,_nameLabel]];
    
    _leftImage.sd_layout
    .leftSpaceToView(self.contentView,15)
    .centerYEqualToView(self.contentView)
    .widthIs(14)
    .heightIs(14);
    
    _titlelabel.alpha=.7;
    _titlelabel.font=[UIFont systemFontOfSize:16];
    _titlelabel.sd_layout
    .leftSpaceToView(_leftImage,15)
    .centerYEqualToView(_leftImage)
    .widthIs(80)
    .heightIs(20);
    
    _nameLabel.alpha=.7;
    _nameLabel.font=[UIFont systemFontOfSize:15];
    _nameLabel.numberOfLines=0;
    _nameLabel.sd_layout
    .leftSpaceToView(_titlelabel,5)
    .rightSpaceToView(self.contentView,15)
    .centerYEqualToView(_titlelabel)
    .autoHeightRatio(0);
    [self setupAutoHeightWithBottomView:_nameLabel bottomMargin:2];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
