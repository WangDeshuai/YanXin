//
//  HelpViewController.m
//  YanXin
//
//  Created by mac on 16/4/23.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "HelpViewController.h"

@interface HelpViewController ()

@end

@implementation HelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //self.navigationController.automaticallyAdjustsScrollViewInsets=NO;
   
    self.title=@"帮助";
    
    //左按钮
    UIButton*backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(5,27, 35, 35);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"goback_back_orange_on"] forState:0];
    [backBtn addTarget:self action:@selector(backClink) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBtn =[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem=leftBtn;
    
//    
//    NSString * s =[[NSUserDefaults standardUserDefaults]objectForKey:@"username"];
//    if ([s isEqualToString:@"15032735032"] || s==nil) {
//        NSLog(@"测试");
//        [self ceshi];
//    }else{
//        [self help];
//    }
    
    //屏蔽支付宝功能
    [ShuJuModel huoquVipTubiaosuccess:^(NSDictionary *dic) {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"content"]];
        if ([code isEqualToString:@"0"]) {
            [self ceshi];
        }else{
             [self help];
        }
        
        
    } error:nil];





}


-(void)ceshi
{
    self.label1.text=@"1.下载演信APP后，进行注册，通过手机号完成注册。\n2.用户在进入预定界面之前，首先要登录并成为演员，方可进行预定。";
    self.label1.numberOfLines=0;
    self.label1.adjustsFontSizeToFitWidth=YES;
   
    self.chongzhilabe.text=@"关于投诉";
    self.label2.text=@"如果您在该款APP中发现不良信息，例如：色情、骚扰、暴力恐怖、谣言、骗钱违禁品等违法行为，请在我的界面投诉选项中进行投诉，我们会根据您投诉的内容进行核实处理";
//    self.label2.numberOfLines=0;
//    self.label2.adjustsFontSizeToFitWidth=YES;
  //  self.helpView2.hidden=YES;

    self.label3.text=@"1.注册演信APP一定要填写真实姓名及手机号，这样方便商家或个人之间联系。\n2.注册者默认同意该款APP的服务条款。";
    self.label3.numberOfLines=0;
    self.label3.adjustsFontSizeToFitWidth=YES;


}



-(void)help
{
    self.label1.text=@"1.下载演信APP后，进行注册，通过手机号完成注册。\n2.用户在进入预定界面之前，首先要登录并充值成为演信会员，方可进行预定。";
    self.label1.numberOfLines=0;
    self.label1.adjustsFontSizeToFitWidth=YES;
    
    self.label2.text=@"1.具体充值规则详情请查看充值规则界面。\n2.用户只有充值成为演信会员，才能发表动态、评论。\n3.演员充值成为演信会员后即可在演员界面显示个人信息。\n4.充值方式目前只支持支付宝支付与微信支付";
    self.label2.numberOfLines=0;
    self.label2.adjustsFontSizeToFitWidth=YES;
    
    self.label3.text=@"1.注册该款APP一定要填写真实姓名及手机号，这样方便商家或个人之间联系。\n2.演员使用真实姓名和手机号，方便商家快速与之联系。";
    self.label3.numberOfLines=0;
    self.label3.adjustsFontSizeToFitWidth=YES;

    
}
-(void)backClink
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
