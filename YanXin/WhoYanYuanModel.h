//
//  WhoYanYuanModel.h
//  YanXin
//
//  Created by mac on 16/3/31.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WhoYanYuanModel : NSObject
@property(nonatomic,copy)NSString * name;
@property(nonatomic,copy)NSString * sex;
@property(nonatomic,copy)NSString * phoneNumber;
@property(nonatomic,copy)NSString * diqu;
@property(nonatomic,copy)NSString * biaoqian;
@property(nonatomic,copy)NSString * myjianjie;
@property(nonatomic,copy)NSString * myjingli;
@property(nonatomic,copy)NSString * imageURL;

- (id)initWithDic:(NSDictionary *)dic;

@end
