//
//  ZhiFuViewController.h
//  YanXin
//
//  Created by mac on 16/4/13.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZhiFuViewController : UIViewController
{
    UIButton * _lastBtn;
}
@property(nonatomic,copy)NSString * phoneNumber;
@property (weak, nonatomic) IBOutlet UIButton *vip1btn;
@property (weak, nonatomic) IBOutlet UIButton *vip2btn;
@property (weak, nonatomic) IBOutlet UIButton *vip3btn;
@property (weak, nonatomic) IBOutlet UIButton *CZguize;
@property (weak, nonatomic) IBOutlet UIButton *lijiChongzhi;
@property (weak, nonatomic) IBOutlet UILabel *xianshiyouhui;
@property (weak, nonatomic) IBOutlet UIImageView *image1;
@property (weak, nonatomic) IBOutlet UIImageView *image2;
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;

@end
