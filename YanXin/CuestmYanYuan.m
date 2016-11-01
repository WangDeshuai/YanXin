//
//  CuestmYanYuan.m
//  YanXin
//
//  Created by mac on 16/2/22.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "CuestmYanYuan.h"

@implementation CuestmYanYuan

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _lineImage=[UIImageView new];
        _lineImage.backgroundColor=[UIColor redColor];
        _lineImage.layer.cornerRadius=30;
        _lineImage.clipsToBounds=YES;
        
        _name=[UILabel new];
       
        _xingbieImage=[UIImageView new];
       
        _VIPimage = [UIImageView new];
        
        
        
        _zhiye=[UILabel new];
        _zhiye.backgroundColor=[UIColor colorWithRed:248/255.0 green:127/255.0 blue:4/255.0 alpha:1];
        _zhiye.textAlignment=1;
        _zhiye.textColor=[UIColor whiteColor];
        
        _jianjie=[UILabel new];
       // _jianjie.text=@"王源，1992年8月18日生于湖北省武汉市深泽镇理财村";
        _jianjie.textColor=[UIColor colorWithRed:185/255.0 green:185/255.0 blue:185/255.0 alpha:1];
        _jianjie.font=[UIFont systemFontOfSize:14];
    [self.contentView sd_addSubviews:@[_lineImage,_name,_xingbieImage,_zhiye,_jianjie,_VIPimage]];
        
        _lineImage.sd_layout
        .widthIs(60)
        .heightIs(60)
        .topSpaceToView(self.contentView,15)
        .leftSpaceToView(self.contentView,10);
     
       
        _name.sd_layout
        .topEqualToView(_lineImage)
        .leftSpaceToView(_lineImage,10)
        .heightIs(25);
        [_name setSingleLineAutoResizeWithMaxWidth:self.frame.size.width];
       
        
        _VIPimage.sd_layout
        .leftSpaceToView(_name,5)
        .topSpaceToView(self.contentView,22)
        .widthIs(38)
        .heightIs(14);
        
        _xingbieImage.sd_layout
        .leftEqualToView(_name)
        .topSpaceToView(_name,0)
        .widthIs(20)
        .heightIs(20);
        
        _zhiye.sd_layout
        .leftSpaceToView(_xingbieImage,5)
        .topEqualToView(_xingbieImage)
        .heightIs(20);
        [_zhiye setSingleLineAutoResizeWithMaxWidth:200];
        
        _jianjie.sd_layout
        .leftEqualToView(_name)
        .rightSpaceToView(self.contentView,3)
        .topSpaceToView(_xingbieImage,0)
        .heightIs(25);
       
        [self setupAutoHeightWithBottomView:_jianjie bottomMargin:10];
        // Initialization code
    }
    return self;
}

-(void)setModel:(yanyuanModel *)model
{
    _model=model;
    
    
    _name.text=model.name;
    _jianjie.text=model.introduction;
    
    CGFloat  fl = [ShuJuModel getWidthWithFontSize:17 height:30 string:model.name];
    _name.sd_layout.widthIs(fl);
    
   
     CGFloat  zy = [ShuJuModel getWidthWithFontSize:17 height:30 string:model.categoryname];
    _name.sd_layout.widthIs(zy);
     _zhiye.text=model.categoryname;
    _xingbieImage.image=model.xingbieImage;
    [_lineImage sd_setImageWithURL:[NSURL URLWithString:model.headimgurl] placeholderImage:[UIImage imageNamed:@"头像占位图"]];
    
    
    //屏蔽支付宝功能
    [ShuJuModel huoquVipTubiaosuccess:^(NSDictionary *dic) {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"content"]];
        if ([code isEqualToString:@"0"]) {
            
        }else{
            [_VIPimage sd_setImageWithURL:[NSURL URLWithString:model.vipname]];
            if ([model.viplevel isEqualToString:@"3"]) {
                _name.textColor=[UIColor colorWithRed:184/255.0 green:36/255.0 blue:232/255.0 alpha:1];
            }else if ([model.viplevel isEqualToString:@"2"]){
                _name.textColor=[UIColor colorWithRed:228/255.0 green:43/255.0 blue:23/255.0 alpha:1];
                
            }else if([model.viplevel isEqualToString:@"1"]){
                _name.textColor=[UIColor colorWithRed:208/255.0 green:163/255.0 blue:99/255.0 alpha:1];
            }
            else{
                _name.textColor=[UIColor blackColor];
            }

        }
        
        
    } error:nil];
    
    
    
    
//    NSString * s= [[NSUserDefaults standardUserDefaults]objectForKey:@"username"];
//    if ([s isEqualToString:@"15032735032"] || s ==nil) {
//        
//    }else
//    {
//         [_VIPimage sd_setImageWithURL:[NSURL URLWithString:model.vipname]];
//    }
    
    
   



}


-(void)setFrame:(CGRect)frame
{
    
    frame.origin.y+=5;
    frame.size.height-=10;
    frame.origin.x+=10;
    frame.size.width-=20;
    [super setFrame:frame ];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
