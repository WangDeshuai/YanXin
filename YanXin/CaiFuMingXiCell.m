//
//  CaiFuMingXiCell.m
//  YanXin
//
//  Created by Macx on 17/2/8.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "CaiFuMingXiCell.h"
@interface CaiFuMingXiCell()
@property(nonatomic,strong)UILabel *priceLabel;
@property(nonatomic,strong)UILabel * stype;
@property(nonatomic,strong)UILabel * timeLabel;

@end
@implementation CaiFuMingXiCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+(instancetype)cellWithTableView:(UITableView*)tableView CellID:(NSString*)cellID{
    CaiFuMingXiCell * cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell=[[CaiFuMingXiCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setup];
    }
    return self;
}
-(void)setup{
    _priceLabel=[UILabel new];
    _stype=[UILabel new];
    _timeLabel=[UILabel new];
    [self.contentView sd_addSubviews:@[_priceLabel,_stype,_timeLabel]];
    
    _priceLabel.font=[UIFont systemFontOfSize:15];
    _priceLabel.alpha=.7;
    _stype.font=[UIFont systemFontOfSize:15];
    _stype.alpha=.7;
    _timeLabel.font=[UIFont systemFontOfSize:15];
    _timeLabel.alpha=.7;
    
    _priceLabel.sd_layout
    .leftSpaceToView(self.contentView,15)
    .centerYEqualToView(self.contentView)
    .heightIs(20);
    [_priceLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    _stype.sd_layout
    .leftSpaceToView(_priceLabel,10)
    .centerYEqualToView(_priceLabel)
    .heightIs(20);
    [_stype setSingleLineAutoResizeWithMaxWidth:200];
    
    _timeLabel.sd_layout
    .rightSpaceToView(self.contentView,15)
    .centerYEqualToView(self.contentView)
    .heightIs(20);
    [_timeLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    
    
}
-(void)setModel:(YiHuoDeModel *)model
{
    _model=model;
    _priceLabel.text=[NSString stringWithFormat:@"提现%@元",model.extractMoney];
    
    _stype.text=[NSString stringWithFormat:@"(%@)",model.alipayStype];
    _timeLabel.text=_model.timeName;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
