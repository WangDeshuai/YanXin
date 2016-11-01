//
//  ChongzhiModel.h
//  YanXin
//
//  Created by mac on 16/4/28.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChongzhiModel : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *idd;
@property (nonatomic, copy) NSString *dengjiID;
@property(nonatomic,copy)NSString * youhui;
@property(nonatomic,copy)NSString * youhuidezi;

- (id)initWithDic:(NSDictionary *)dic;
@end
