//
//  yanyuanModel.h
//  YanXin
//
//  Created by mac on 16/3/30.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface yanyuanModel : NSObject

@property(nonatomic,retain)NSString * name;
@property(nonatomic,retain)NSString * headimgurl;
@property(nonatomic,retain)NSString * sex;
@property(nonatomic,retain)NSString * categoryname;
@property(nonatomic,retain)NSString * introduction;
@property(nonatomic,retain)NSString * vipname;
@property(nonatomic,retain)UIImage *xingbieImage;
@property(nonatomic,retain)NSString * who;
@property(nonatomic,retain)NSString * viplevel;

- (id)initWithDic:(NSDictionary *)dic;
@end
