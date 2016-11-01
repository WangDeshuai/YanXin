//
//  ChongzhiModel.m
//  YanXin
//
//  Created by mac on 16/4/28.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ChongzhiModel.h"

@implementation ChongzhiModel
- (id)initWithDic:(NSDictionary *)dic{
    
    self = [super init];
    if (self)
    {
        _name=[dic objectForKey:@"name"];
        
        _price=[NSString stringWithFormat:@"%@",[dic objectForKey:@"price"]];
        
        _desc=[dic objectForKey:@"desc"];
        _idd=[dic objectForKey:@"id"];
        _dengjiID=[dic objectForKey:@"level"];
        _youhui= [NSString stringWithFormat:@"%@",[dic objectForKey:@"isShowNotice"]];
        
        if ([dic objectForKey:@"notice"]==[NSNull null]) {
            
        }else{
            _youhuidezi=[dic objectForKey:@"notice"];
        }
        
    }
    
    return self;
    
}
@end
