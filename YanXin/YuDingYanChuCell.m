//
//  YuDingYanChuCell.m
//  YanXin
//
//  Created by Macx on 17/2/15.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "YuDingYanChuCell.h"

@implementation YuDingYanChuCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+(instancetype)cellWithTableView:(UITableView*)tableView CellID:(NSString*)cellID{
    YuDingYanChuCell * cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell=[[YuDingYanChuCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
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
    _titlelabel=[UILabel new];
    _textfield=[UITextField new];
    _textView=[UITextView new];
    _seleteBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _textView.layer.borderWidth=1;
    _textView.layer.borderColor=COLOR.CGColor;
    
    [self.contentView sd_addSubviews:@[_titlelabel,_textView,_textfield,_seleteBtn]];
   // _titlelabel.backgroundColor=[UIColor magentaColor];
    _titlelabel.sd_layout
    .leftSpaceToView(self.contentView,15)
    .topSpaceToView(self.contentView,10)
    .widthIs(100)
    .autoHeightRatio(0);
//    .heightIs(20);
    
   // _textfield.backgroundColor=[UIColor redColor];
    _textfield.sd_layout
    .leftSpaceToView(_titlelabel,0)
    .centerYEqualToView(_titlelabel)
    .rightSpaceToView(self.contentView,15)
    .heightIs(30);
    
    _textView.hidden=YES;
    //_textView.backgroundColor=[UIColor yellowColor];
    _textView.sd_layout
    .leftEqualToView(_textfield)
    .topEqualToView(_titlelabel)
    .rightSpaceToView(self.contentView,15)
    .heightIs(100);
    
    _seleteBtn.hidden=YES;
    _seleteBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    _seleteBtn.titleEdgeInsets=UIEdgeInsetsMake(-2, 2, 0, 0);
    //_seleteBtn.backgroundColor=[UIColor greenColor];
    _seleteBtn.sd_layout
    .leftEqualToView(_textView)
    .rightSpaceToView(self.contentView,15)
    .centerYEqualToView(_titlelabel)
    .heightIs(30);
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
