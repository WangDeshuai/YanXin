//
//  ZhiFuViewController.m
//  YanXin
//
//  Created by mac on 16/4/13.
//  Copyright © 2016年 mac. All rights reserved.
//
#import "ZhiFuViewController.h"
#import "Order.h"
#import <AlipaySDK/AlipaySDK.h>
#import "DataSigner.h"
#import "ChongZhiGuiZeVC.h"
#import "ChongzhiModel.h"
#import "WXApi.h"
#import "WXApiObject.h"
#import <ifaddrs.h>
#import <arpa/inet.h>
#import "WeiXinModel.h"
@interface ZhiFuViewController ()
{
    ChongzhiModel *_model;
    UIView * bggview;
}
@property(nonatomic,retain)NSMutableArray * dataArr;
@end

@implementation ZhiFuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
       NSString * userName =[[NSUserDefaults standardUserDefaults]objectForKey:@"username"];
   // NSLog(@"我是登陆的手机号%@",userName);
    self.title=@"会员充值";

    //左按钮
    UIButton*backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(5,27, 35, 35);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"goback_back_orange_on"] forState:0];
    [backBtn addTarget:self action:@selector(backClink) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBtn =[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem=leftBtn;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:biaoti]}];
    if ([userName isEqualToString:@"15032735032"]) {
       // NSLog(@"请联系客服");
        
        [self ceshi];
        
    }else{
        [self chongzhi];
    }

}


-(void)ceshi
{
    bggview =[[UIView alloc]initWithFrame:CGRectMake(0, 0, KUAN, GAO)];
    bggview.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:bggview];
    UIView * view =[UIView new];
    view.backgroundColor=[UIColor grayColor];
    view.alpha=.5;
    [bggview sd_addSubviews:@[view]];
    view.sd_layout
    .leftSpaceToView(bggview,34)
    .rightSpaceToView(bggview,30)
    .topSpaceToView(bggview,94)
    .bottomSpaceToView(bggview,60);
    
    UILabel * label =[UILabel new];
    label.text=@"       尊敬的用户您好，欢迎来到充值界面，如果您需要充值或者想要了解充值规则，请您联系我们的客服电话\n电话:0311-88810785\nQ Q:254129572";
    label.font=[UIFont systemFontOfSize:20];
    label.textColor=[UIColor whiteColor];
    
    UILabel * label1 =[UILabel new];
    label1.text=@"";
    label1.font=[UIFont systemFontOfSize:17];
    label1.textColor=[UIColor whiteColor];
    
    [view sd_addSubviews:@[label]];
    
    label.sd_layout
    .topSpaceToView(view,50)
    .autoHeightRatio(0)
    .leftSpaceToView(view,30)
    .rightSpaceToView(view,30);
   
    
    
}



-(void)chongzhi
{
    
    
    
    self.image2.hidden=YES;
    self.button1.tag=1;
    self.button2.tag=2;
    [self.button1 addTarget:self action:@selector(buttonClink:) forControlEvents:UIControlEventTouchUpInside];
    [self.button2 addTarget:self action:@selector(buttonClink:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.vip1btn setBackgroundImage:[UIImage imageNamed:@"vip1_b"] forState:UIControlStateSelected];
    //[self.vip1btn setTitleColor:[UIColor colorWithRed:36/255.0 green:180/255.0 blue:238/255.0 alpha:1] forState:UIControlStateSelected];
    [self.vip1btn setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
    [self.vip2btn setBackgroundImage:[UIImage imageNamed:@"vip2_b"] forState:UIControlStateSelected];
    [self.vip2btn setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
    [self.vip3btn setBackgroundImage:[UIImage imageNamed:@"vip3_b"] forState:UIControlStateSelected];
    [self.vip3btn setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
    _dataArr=[[NSMutableArray alloc]init];
    self.vip1btn.selected=YES;
    _lastBtn=self.vip1btn;
    
    [ShuJuModel chongzhiGuizesuccess:^(NSDictionary *dic) {
        NSArray * contetarr =[dic objectForKey:@"content"];
        for (NSDictionary * dicc in contetarr) {
            _model=[[ChongzhiModel alloc]initWithDic:dicc];
            [_dataArr addObject:_model];
            NSLog(@"价格%@",_model.name);
        }
        if ([_model.youhui isEqualToString:@"1"]) {
            self.xianshiyouhui.hidden=NO;
            self.xianshiyouhui.text=_model.youhuidezi;
        }else if([_model.youhui isEqualToString:@"0"]){
            self.xianshiyouhui.hidden=YES;
            self.xianshiyouhui.text=_model.youhuidezi;

        }
        //self.xianshiyouhui
        
        ChongzhiModel * m=_dataArr[0];
        [_vip1btn setTitle:[NSString stringWithFormat:@"%@元",m.price] forState:0];
        
        ChongzhiModel * mm=_dataArr[1];
        [_vip2btn setTitle:[NSString stringWithFormat:@"%@元",mm.price] forState:0];
        
        ChongzhiModel * mmm=_dataArr[2];
        [_vip3btn setTitle:[NSString stringWithFormat:@"%@元",mmm.price] forState:0];
        
    } error:^(NSError *error) {
        
    }];
}

-(void)buttonClink:(UIButton*)btn{
    if (btn.tag==2) {
        self.image2.hidden=NO;
        self.image1.hidden=YES;
    }else if (btn.tag==1){
        self.image2.hidden=YES;
        self.image1.hidden=NO;
    }
    
    
}
- (IBAction)chongzhiGuiZe:(UIButton *)sender {
    
    ChongZhiGuiZeVC * czgz=[ChongZhiGuiZeVC new];
    //czgz.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:czgz animated:YES];
}

-(void)backClink
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)vipbtn:(UIButton *)sender {
    _lastBtn.selected=NO;
    sender.selected=YES;
    _lastBtn=sender;
    self.lijiChongzhi.tag=sender.tag;
   
}
-(void)zhifujiemian:(NSString*)dingdan biaotii:(NSString*)bt jiage:(NSString*)jiage miaoshu:(NSString*)mshu
{
    NSString *partner = @"2088221733436902"; //PID
    
    NSString *seller = @"8014776@qq.com"; //收款账户，手机号或者邮箱
    NSString*privateKey= @"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAMaDpkazfuHj+Tk9piULoIAVSkLh6b+Xi9QzwWYJZeLAjd4rDkFtVvOvljvRYLksxH/U8X1t/5BoJxtvFij6kG2tMX2gEbPZbbuTT8VjAoK1N6jZkOOtdPUeVgR763NheR0ao50uR6F0alGCI2fsRhKmwHA/udNDf1kdNuMhML8pAgMBAAECgYEAtIiroibBYIukbrMrMwuU5ob2J0cu/kfDKbP70WEAoKv/GSpM56GZbzqjRTlQXndhKOQuzqRHxDuEPUXUgGYHC6y1+3WcSEQbzphWp5Km4u/vmVud0UYRLh1o5t+d961y/GkzJcgqrn2PrcmMNukH2+Tr4wax+RFz66sdR+KBqIECQQDvEI9hAuVJjsfPI7QPZ8sttVY9BeUAex2D2Ow5VAwUPBB9IPo2t0R0COZZZTJl0CHGkjM46X1W9DaS9PZ5cQlxAkEA1JO1AWsI2uzpuTJegZmaFzDYYH2XAsRU2Y9K3UJQUgiMndsWnWEYg1QX4dvbaiBF25cHgoVOvZRaGl8M5oV1OQJAdhnAOzSrAQPAQdxpf5LPFO2YhNz8nJg1pITtbgTPUs+5dZdtBMrUzl33LgKIOzPu+6IOG/d9LA/JRiAuAyCMgQJBAL3H5MgQU8aHzh3dvwu7IxtjKznxxbjdqNbWm8KvKmAia8+eQjFc9vKASBYHH3s+tr9VtYmsE+EiqdJzW2QOb9kCQGNWNCotHBsyClfS+dRi5OFF+dEymHIyTjpwNJZFcrFW2MiujlBJQhyPUCKZNntAewL7AsapAX67DTMq4OLQNqs=";// 私钥
    
    
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.sellerID = seller;
    order.outTradeNO = dingdan;//[self generateTradeNO]; //订单ID（由商家自行制定）
    order.subject = bt; //商品标题
    order.body = mshu; //商品描述
    order.totalFee = jiage;//@"0.01"; //商品价格
    order.notifyURL = @"http://119.29.83.154:8080/YanXinManage/charge/app_alipayCallBack.action"; //回调URL
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showURL = @"m.alipay.com";
    
    NSString *appScheme = @"yanxin";
    
    //将商品信息拼接成字符串   该方法支付宝已经封好
    NSString *orderSpec = [order description];
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    //调用签名
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",orderSpec, signedString, @"RSA"];
        
        //上面提到好的后台，会把订单字符串直接传给我们，而我们要做的其实也就只剩下这一步了
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            
           // NSLog(@">>>%@",resultDic);
            if ([[resultDic objectForKey:@"resultStatus"] isEqualToString:@"9000"]) {
                //9000为支付成功
                UIAlertController * alercon =[UIAlertController alertControllerWithTitle:@"温馨提示" message:@"充值成功，请重新登录" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction * que =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                [alercon addAction:que];
                [self presentViewController:alercon animated:YES completion:nil];
            }
        }];
    }

    
    
}


- (IBAction)chongZhiBtn:(UIButton *)sender {
   
    //[self zhifujiemian:@"wfrsgfvsdg" biaotii:@"www" jiage:@"0.11" miaoshu:@"dfsfs"];
    UIAlertController * actionView;
    if (actionView==nil) {
        actionView=[UIAlertController alertControllerWithTitle:@"提示" message:nil preferredStyle:UIAlertControllerStyleAlert];
    }
    
    UIAlertAction * action =[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [actionView addAction:action];
    
     ChongzhiModel * md =_dataArr[sender.tag];
    if (_image1.hidden==NO) {
        //NSLog(@"这是支付宝支付");
        
       
       
        [ShuJuModel zhifulianjieVIPID:md.idd success:^(NSDictionary *dic) {
           // NSLog(@"%@",dic);
            if ([[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]] isEqualToString:@"1"]) {
                 NSString * dingdanhao =[dic objectForKey:@"content"];
               // NSLog(@"?>>>%@",dingdanhao);
                [self zhifujiemian:dingdanhao biaotii:md.name jiage:md.price miaoshu:md.desc];
            }else{
                actionView.message=[dic objectForKey:@"msg"];;
                [self presentViewController:actionView animated:YES completion:nil];
            }
            

        } error:^(NSError *error) {
            
        }];
    }else{
        NSLog(@"这是微信支付");
        NSString * account =[[NSUserDefaults standardUserDefaults]objectForKey:@"username"];
        NSString * vipid= md.idd;
      int qian = (int)[md.price integerValue] *100;//注意单位是分,需要转换为元
        NSString * jiage =[NSString stringWithFormat:@"%d",qian];
         NSLog(@"我的ip地址是%@",[self getIPAddress]);
        NSLog(@"账号是%@",account);
        NSLog(@"vipID,%@",vipid);
        NSLog(@"价格是%@",jiage);
      //  NSLog(@"描述%@",md.name);
//        [self getIPAddress]
        [ShuJuModel weixinZhiFuAccount:account vipID:vipid JiaGe:jiage APPIp:[self getIPAddress]  Body:md.name success:^(NSDictionary *dic) {
            NSString * s =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
            if ([s isEqualToString:@"1"])
            {
              NSDictionary * dicc= [dic objectForKey:@"content"];
                WeiXinModel * md =[[ WeiXinModel alloc]initWithZhiFuDic:dicc];
                PayReq *request = [[PayReq alloc] init];
                request.partnerId = md.partnerid;
                request.prepayId=  md.prepayid;
                request.package = md.package;
                request.nonceStr=  md.noncestr;
                request.timeStamp= md.timestamp.intValue;
                request.sign= md.sign;
                [WXApi sendReq:request];
                
                
            }else{
               
                UIAlertController * actionView =[UIAlertController alertControllerWithTitle:@"提示" message: [dic objectForKey:@"msg"] preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction * action =[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:nil];
                [actionView addAction:action];
                [self presentViewController:actionView animated:YES completion:nil];
                
            }
//
        } error:nil];
        
        
        
    }
    
}
- (NSString *)getIPAddress {
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
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
