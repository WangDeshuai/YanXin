//
//  Custom.m
//  YanXin
//
//  Created by mac on 16/2/19.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "Custom.h"

@implementation Custom
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
      
        _nameLab=[UILabel new];
        
        _lineImage=[UIImageView new];
        _lineImage.image=[UIImage imageNamed:@"11.jpg"];
        _jianJieLab=[UILabel new];
        _jianJieLab.textColor=[UIColor colorWithRed:75/255.0 green:75/255.0  blue:75/255.0  alpha:.7];
        _jianJieLab.numberOfLines=3;
        _jianJieLab.font=[UIFont systemFontOfSize:13];
        _VIPImage =[UIImageView new];
        
        [self.contentView sd_addSubviews:@[_nameLab,_lineImage,_jianJieLab,_VIPImage]];
        
        _lineImage.sd_layout
        .topSpaceToView(self.contentView,15)
        .leftSpaceToView(self.contentView,15)
        .widthIs(70)
        .heightIs(70);
        
        _nameLab.sd_layout
        .topEqualToView(_lineImage)
        .leftSpaceToView(_lineImage,10)
        .heightIs(30);
      [_nameLab setSingleLineAutoResizeWithMaxWidth:250];
        
        _VIPImage.sd_layout
        .leftSpaceToView(_nameLab,3)
        .topSpaceToView(self.contentView,22)
        .widthIs(38)
        .heightIs(14);
        
        _jianJieLab.sd_layout
        .topSpaceToView(_nameLab,0)
        .leftEqualToView(_nameLab)
        .rightSpaceToView(self.contentView,30)
        .heightIs(40);
       
        // Initialization code
    }
    return self;
}

-(void)setModel:(YanShangModel *)model
{
    _model=model;
    [_lineImage sd_setImageWithURL:[NSURL URLWithString:model.imageName] placeholderImage:[UIImage imageNamed:@"1.jpg"]];
    _nameLab.text=model.titleName;
    
    
    CGFloat  fl = [ShuJuModel getWidthWithFontSize:17 height:30 string:model.titleName];
    if(fl>self.contentView.frame.size.width-120)
    {
        fl=self.contentView.frame.size.width-150;
    }
    _nameLab.sd_layout.widthIs(fl);
    
    //屏蔽支付宝功能
    [ShuJuModel huoquVipTubiaosuccess:^(NSDictionary *dic) {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"content"]];
        if ([code isEqualToString:@"0"]) {
            
        }else{
            [_VIPImage sd_setImageWithURL:[NSURL URLWithString:model.imageVIPName]];
            if ([model.viplevel isEqualToString:@"3"]) {
                _nameLab.textColor=[UIColor colorWithRed:184/255.0 green:36/255.0 blue:232/255.0 alpha:1];
            }else if ([model.viplevel isEqualToString:@"2"]){
                _nameLab.textColor=[UIColor colorWithRed:228/255.0 green:43/255.0 blue:23/255.0 alpha:1];
                
            }else if([model.viplevel isEqualToString:@"1"]){
                _nameLab.textColor=[UIColor colorWithRed:208/255.0 green:163/255.0 blue:99/255.0 alpha:1];
            }else{
                _nameLab.textColor=[UIColor blackColor];
            }

        }
        
        
    } error:nil];
    
    
    
//    NSString * s= [[NSUserDefaults standardUserDefaults]objectForKey:@"username"];
//    if ([s isEqualToString:@"15032735032"] || s ==nil) {
//        
//    }else
//    {
//       
//    }
    
    _jianJieLab.text=model.jianJie;
}




//-(void)setFrame:(CGRect)frame
//{
//    
//    frame.origin.y+=10;
//    frame.size.height-=10;
//    frame.origin.x+=10;
//    frame.size.width-=20;
//    [super setFrame:frame ];
//}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
