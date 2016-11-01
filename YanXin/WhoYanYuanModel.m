//
//  WhoYanYuanModel.m
//  YanXin
//
//  Created by mac on 16/3/31.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "WhoYanYuanModel.h"
#import "ShuJuModel.h"
@implementation WhoYanYuanModel
- (id)initWithDic:(NSDictionary *)dic{
    
    self = [super init];
    if (self)
    {
        
        NSString * xingbie =[NSString stringWithFormat:@"%@",[dic objectForKey:@"sex"]];
        if ([xingbie isEqualToString:@"0"]) {
            _sex=@"女";
        }else
        {
            _sex=@"男";
        }
       
        NSMutableArray * baiqian =[NSMutableArray new];
        
        [ShuJuModel huoquyanyuanWihBiaoQian:@"0" success:^(NSDictionary *dic) {
            NSArray * content =[dic objectForKey:@"content"];
            for (NSDictionary * dicc in content) {
               NSString *name= [dicc objectForKey:@"categoryname"];
                [baiqian addObject:name];
                
                NSLog(@"%@",name);
            }
            [[NSUserDefaults standardUserDefaults]setObject:baiqian forKey:@"biaoqiankey"];
            [[NSUserDefaults standardUserDefaults]synchronize];
        } error:^(NSError *error) {
            
        }];


        _name=[self string:[dic objectForKey:@"name"]];//[dic objectForKey:@"name"];
        _diqu=[self string:[dic objectForKey:@"cityname"]];//;
       
       
       
        _biaoqian=[self string:[dic objectForKey:@"categoryname"]];
        _imageURL=[self string:[dic objectForKey:@"headimgurl"]];
        
        _phoneNumber=[self string:[dic objectForKey:@"connecttel"]];
        _myjianjie=[self string:[dic objectForKey:@"introduction"]];
        _myjingli=[self string:[dic objectForKey:@"experience"]];
       
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
