//
//  YanShangModel.m
//  YanXin
//
//  Created by mac on 16/4/6.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "YanShangModel.h"

@implementation YanShangModel
- (id)initWithDic:(NSDictionary *)dic{
    
    self = [super init];
    if (self)
    {
     _titleName=[dic objectForKey:@"name"];
     _imageName=[dic objectForKey:@"showimgurl"];
     _imageVIPName=[dic objectForKey:@"vipimgurl"];
     _jianJie=[dic objectForKey:@"introduction"];
        _anliArr=[dic objectForKey:@"successcase"];
       _name=[dic objectForKey:@"linkman"];
       _phone=[dic objectForKey:@"connecttel"];
       _dizhi=[dic objectForKey:@"address"];
        _viplevel=[NSString stringWithFormat:@"%@",[dic objectForKey:@"viplevel"]];
        _huiyishi=[dic objectForKey:@"meetingRoom"];
        _kefang=[dic objectForKey:@"guestRoom"];
        
    }
    
    return self;
    
}

@end
