//
//  yanyuanModel.m
//  YanXin
//
//  Created by mac on 16/3/30.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "yanyuanModel.h"

@implementation yanyuanModel

- (id)initWithDic:(NSDictionary *)dic{
    
    self = [super init];
    if (self)
    {
        _categoryname=[self string:[dic objectForKey:@"categoryname"]];
       
        _vipname=[self string:[dic objectForKey:@"vipimgurl"]];//[dic objectForKey:@"vipimgurl"];
        _headimgurl=[self string:[dic objectForKey:@"headimgurl"]];
        _introduction=[self string:[dic objectForKey:@"introduction"]];
        _name=[self string:[dic objectForKey:@"name"]];//[dic objectForKey:@"name"];
        _sex=[self string:[dic objectForKey:@"sex"]];//[dic objectForKey:@"sex"];
        _who=[self string:[dic objectForKey:@"account"]];//[dic objectForKey:@"account"];
       
        NSString * yanse =[NSString stringWithFormat:@"%@",[dic objectForKey:@"viplevel"]];
         _viplevel=yanse;
        NSString * xingbie =[NSString stringWithFormat:@"%@",_sex];
        //NSLog(@"我是演员model性别%@",xingbie);
        if ([xingbie isEqualToString:@"0"]) {
            _xingbieImage=[UIImage imageNamed:@"female(1)"];
        }else
        {
            _xingbieImage=[UIImage imageNamed:@"male(1)"];
        }
       
        
        
    }
    
    
    return self;
    
}
//过滤一下
-(NSString*)string:(id)sss
{
    NSString * a=@"";
    if (sss==[NSNull null]) {
        a=@"";
    }else{
        a=sss;
    }
    return a;
}
@end
