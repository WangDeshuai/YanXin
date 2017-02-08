//
//  YiHuoDeModel.h
//  YanXin
//
//  Created by Macx on 17/1/19.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YiHuoDeModel : NSObject
//已获得
@property(nonatomic,copy)NSString * name;//姓名
@property(nonatomic,copy)NSString * headUrl;//头像
@property(nonatomic,copy)NSString * price;//价格
@property(nonatomic,strong)UIImage * vipImage;//会员级别
@property(nonatomic,strong)UIImage * friendImage;//好友直接间接
@property(nonatomic,copy)NSString * time;//时间
-(id)initWithYiHuoDeDic:(NSDictionary*)dic;
#pragma mark --财富明细
@property(nonatomic,copy)NSString * idd;//提现记录ID
@property(nonatomic,copy)NSString * extractMoney;//提现金额
@property(nonatomic,copy)NSString * timeName;//提现时间
@property(nonatomic,copy)NSString * alipayName;//支付宝名称
@property(nonatomic,copy)NSString * alipayStype;//支付状态 1.已支付0.处理中
-(id)initWithMingXiDic:(NSDictionary*)dic;
@end
