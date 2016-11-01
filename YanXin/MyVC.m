//
//  MyVC.m
//  YanXin
//
//  Created by mac on 16/2/18.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "MyVC.h"
#import "MMZCViewController.h"
#import "Message1.h"
#import "MySheZhiVC.h"
#import "YanYuanKongJian.h"
#import "YanYuanShengJiViewController.h"
#import "MessageModel.h"
#import "ZhiFuViewController.h"
#import "HelpViewController.h"
#import "JuBaoVC.h"
#import "UMSocial.h"
@interface MyVC ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
    MessageModel* model;
}
@end

@implementation MyVC
-(void)viewDidAppear:(BOOL)animated
{
//    [_tableView reloadData];
//    if (na==nil){
//        //没有登录
//        return;
//    }
//    else{
//         //登录成功
//    }

}
-(void)viewWillAppear:(BOOL)animated
{
   
    na=[[NSUserDefaults standardUserDefaults]objectForKey:@"username"];
     [_tableView reloadData];
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"username"]){
        [ShuJuModel myMessageWithsuccess:^(NSDictionary *dic) {
            NSDictionary * contentDic =[dic objectForKey:@"content"];
           model=[[MessageModel alloc]initWithDic:contentDic];
          [[NSUserDefaults standardUserDefaults] setObject:model.shenFen forKey:@"yanyuanma"];
            
            if (![model.huiyuan isEqualToString:@"0"]) {
                 
                [[NSUserDefaults standardUserDefaults] setObject:model.huiyuan forKey:@"huiyuanma"];
            }
            if (![model.name isEqualToString:@""]) {
               
                [[NSUserDefaults standardUserDefaults] setObject:model.name forKey:@"benrenname"];
            }
            [[NSUserDefaults standardUserDefaults]synchronize];
            [_tableView reloadData];
        } error:nil];

    }else{
        
        NSLog(@"没有登录");
    }
    
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:0/255.0 green:170/255.0 blue:238/255.0 alpha:1];
       self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"我";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:biaoti]}];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KUAN, GAO-46) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    


}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
        
    }else if(section==1)
    {
        
        NSString * s =[[NSUserDefaults standardUserDefaults]objectForKey:@"username"];
        if ([s isEqualToString:@"15032735032"] || s==nil) {
            return 2;
        }else{
           return 3;
        }
       
    }else
    {
        NSString * s =[[NSUserDefaults standardUserDefaults]objectForKey:@"username"];
        if ([s isEqualToString:@"15032735032"] || s==nil) {
            return 3;
        }
        else{
            return 3;
        }
       
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 0;
    }else
    {
        return 20;
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        UIImageView * LineImage=[[UIImageView alloc]init];
        LineImage.tag=10;
        [cell addSubview:LineImage];
        
        UILabel * label=[[UILabel alloc]init];
        label.tag=11;
        [cell addSubview:label];
        
        UILabel * phoneLab=[[UILabel alloc]init];
        phoneLab.tag=12;
        [cell addSubview:phoneLab];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    }
    
    
    if (indexPath.section==0) {
        UIImageView * lineImage=(UIImageView*)[cell viewWithTag:10];
        lineImage.layer.cornerRadius=30;
        lineImage.clipsToBounds=YES;
       // NSLog(@"%@",model.lineImage);
        NSString*nn=  [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
        if (nn) {
             [lineImage sd_setImageWithURL:[NSURL URLWithString:model.lineImage] placeholderImage:[UIImage imageNamed:@"头像占位图"]];
        }else{
            lineImage.image=[UIImage imageNamed:@"头像占位图"];
        }
        
       
        lineImage.frame=CGRectMake(10, 10, 60, 60);
        UILabel * labe =(UILabel*)[cell viewWithTag:11];
        UILabel * name =(UILabel*)[cell viewWithTag:12];
        labe.frame=CGRectMake(80, 15, 55, 30);
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"username"]==nil) {
            //未登陆
            labe.text=@"未登录";
            labe.frame=CGRectMake(80, 30, 55, 30);
            name.hidden=YES;
        }else
        {
            labe.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
            labe.frame=CGRectMake(80, 15, 120, 20);
            name.hidden=NO;
            name.frame=CGRectMake(80, 40, 55, 30);
            name.text=model.name;
            
        }
        

        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    else if(indexPath.section==1){
       
        if (indexPath.row==2) {
            UIImageView * lineImage=(UIImageView*)[cell viewWithTag:10];
            lineImage.image=[UIImage imageNamed:@"会员充值"];
            lineImage.frame=CGRectMake(10, 10, 22, 22);
            
           
            
            UILabel * labe =(UILabel*)[cell viewWithTag:11];
            labe.font=[UIFont systemFontOfSize:15];
            labe.frame=CGRectMake(40, 10, 60, 22);
            labe.text=@"充值会员";


        }else if (indexPath.row==1){
            
            UIImageView * lineImage=(UIImageView*)[cell viewWithTag:10];
            lineImage.image=[UIImage imageNamed:@"升级为演员"];
            lineImage.frame=CGRectMake(10, 10, 22, 22);
            UILabel * labe =(UILabel*)[cell viewWithTag:11];
            labe.font=[UIFont systemFontOfSize:15];
            labe.frame=CGRectMake(40, 10, 100, 22);
            labe.text=@"升级为演员";
        }
        else
        {
           // cell.textLabel.text=@"充值规则";
            UIImageView * lineImage=(UIImageView*)[cell viewWithTag:10];
            lineImage.image=[UIImage imageNamed:@"相册"];
            lineImage.frame=CGRectMake(10, 10, 22, 22);
            UILabel * labe =(UILabel*)[cell viewWithTag:11];
            labe.font=[UIFont systemFontOfSize:15];
            labe.frame=CGRectMake(40, 10, 60, 22);
            labe.text=@"相册";
        }
        
    }else
    {
        
        if (indexPath.row==0) {
            UIImageView * lineImage=(UIImageView*)[cell viewWithTag:10];
            lineImage.image=[UIImage imageNamed:@"帮助"];
            lineImage.frame=CGRectMake(10, 10, 22, 22);
            UILabel * labe =(UILabel*)[cell viewWithTag:11];
            labe.font=[UIFont systemFontOfSize:15];
            labe.frame=CGRectMake(40, 10, 60, 22);
            labe.text=@"帮助";
        }else if(indexPath.row==1)
        {
            UIImageView * lineImage=(UIImageView*)[cell viewWithTag:10];
            lineImage.image=[UIImage imageNamed:@"设置"];
            lineImage.frame=CGRectMake(10, 10, 22, 22);
            UILabel * labe =(UILabel*)[cell viewWithTag:11];
            labe.font=[UIFont systemFontOfSize:15];
            labe.frame=CGRectMake(40, 10, 60, 22);
            labe.text=@"设置";
        }else{
            UIImageView * lineImage=(UIImageView*)[cell viewWithTag:10];
            UILabel * labe =(UILabel*)[cell viewWithTag:11];
            //屏蔽支付宝功能
            [ShuJuModel huoquVipTubiaosuccess:^(NSDictionary *dic) {
                NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"content"]];
                if ([code isEqualToString:@"0"]) {
                    //[self ceshi];
                    lineImage.image=[UIImage imageNamed:@"升级为演员"];
                    lineImage.frame=CGRectMake(10, 10, 22, 22);
                    
                    labe.font=[UIFont systemFontOfSize:15];
                    labe.frame=CGRectMake(40, 10, 120, 22);
                    labe.text=@"投诉";
                }else{
                    //[self help];
                    lineImage.image=[UIImage imageNamed:@"share1"];
                    lineImage.frame=CGRectMake(10, 10, 22, 22);
                    
                    labe.font=[UIFont systemFontOfSize:15];
                    labe.frame=CGRectMake(40, 10, 120, 22);
                    labe.text=@"分享给朋友";
                }
                
                
            } error:nil];
            
           
        }
    
    
    
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    na=[[NSUserDefaults standardUserDefaults] objectForKey:@"username"];

    UIAlertController * alerview= [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"您不是演员，请先升级为演员" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * action1 =[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alerview addAction:action1];
    if (indexPath.section==0)
    {

        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"username"]==nil) {
            //跳转登陆界面
            MMZCViewController * dvc = [[MMZCViewController alloc]init];
            [self presentViewController:dvc animated:YES completion:nil];
        }
        else{
        //跳转个人信息页
            Message1 *message =[[Message1 alloc]init];
            message.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:message animated:YES];
        }
    }else if(indexPath.section==1){
        if (indexPath.row==2)
        {
            //会员充值
            if (!na) {
                MMZCViewController * dvc = [[MMZCViewController alloc]init];
                [self presentViewController:dvc animated:YES completion:nil];
            }else{
            ZhiFuViewController * zvc =[ZhiFuViewController new];
            zvc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:zvc animated:YES];
            }
        }
        else if (indexPath.row==1){
            //升级演员的
            if (!na) {
                MMZCViewController * dvc = [[MMZCViewController alloc]init];
                [self presentViewController:dvc animated:YES completion:nil];
            }else{
                if ([[NSUserDefaults standardUserDefaults]objectForKey:@"huiyuanma"]) {
                    YanYuanShengJiViewController * yvc =[[YanYuanShengJiViewController alloc]init];
                    yvc.hidesBottomBarWhenPushed=YES;
                    [self.navigationController pushViewController:yvc animated:YES];
                }else{
                    //NSLog(@"不是会员");
                    [self presentViewController:alerview animated:YES completion:nil];
                }
                
            
            }
        }
        else
        {
            //相册
            if (!na) {
                MMZCViewController * dvc = [[MMZCViewController alloc]init];
                [self presentViewController:dvc animated:YES completion:nil];
            }else{
                
                NSString * huiyuan =[[NSUserDefaults standardUserDefaults]objectForKey:@"huiyuanma"];
                NSString * yanyuanm=[[NSUserDefaults standardUserDefaults]objectForKey:@"yanyuanma"];
                
                NSLog(@"是不是会员%@",yanyuanm);
                if ([huiyuan isEqualToString:@"0"] || huiyuan==nil) {
                  
                    [self presentViewController:alerview animated:YES completion:^{
                        
                    }];
                
                }else{
                    //NSLog(@"会员");
                    
                    //在看看是不是演员
                    if ([yanyuanm isEqualToString:@"2"]) {
                        
                        YanYuanKongJian *kvc =[YanYuanKongJian new];
                        kvc.phone1=model.phone;
                        kvc.hidesBottomBarWhenPushed=YES;
                        [self.navigationController pushViewController:kvc animated:YES];
                    }else{
                        [self presentViewController:alerview animated:YES completion:nil];
                    }
                    
                    
                    
                    
                    
                }
            }
        }
    }
    else//第三个区了
    {
        if (indexPath.row==0)
        {
            
            if (!na) {
                MMZCViewController * dvc = [[MMZCViewController alloc]init];
                [self presentViewController:dvc animated:YES completion:nil];
            }else{
                //帮助
                HelpViewController * hvc =[HelpViewController new];
                hvc.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:hvc animated:YES];
            
            }
           
            
        }else if(indexPath.row==1)
        {
            //设置
            if (!na) {
                MMZCViewController * dvc = [[MMZCViewController alloc]init];
                [self presentViewController:dvc animated:YES completion:nil];
            }else{
            MySheZhiVC * vc = [MySheZhiVC new];
            vc.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
        else{
            
            [ShuJuModel huoquVipTubiaosuccess:^(NSDictionary *dic) {
                NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"content"]];
                if ([code isEqualToString:@"0"]) {
                    //举报内容
                    if (!na) {
                        MMZCViewController * dvc = [[MMZCViewController alloc]init];
                        [self presentViewController:dvc animated:YES completion:nil];
                    }else{
                        JuBaoVC * vc =[JuBaoVC new];
                        vc.hidesBottomBarWhenPushed=YES;
                        [self.navigationController pushViewController:vc animated:YES];
                    }
                    
                }else{
                    //[self help];
                    NSLog(@"分享成功");
                    [UMSocialSnsService presentSnsIconSheetView:self
                        appKey:@"57200c43e0f55afeba001afb"
                        shareText:@""
                        shareImage:[UIImage imageNamed:@"1.jpg"]
                        shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSina,UMShareToQQ,UMShareToQzone]delegate:nil];
                    
                }
                
                
            } error:nil];
            
            
            
            
            
            
            
            
            
            
          
        }
    
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 80;
    }else
    {
        return 44;
    }
}



-(void)lianjie1
{

//    [UMSocialSnsService presentSnsIconSheetView:self
//                                         appKey:@"56d9229667e58e14410023fe"
//                                      shareText:@"(分享自党建)"
//                                     shareImage:[UIImage imageNamed:@"icon.png"]
//                                shareToSnsNames:[NSArray arrayWithObjects:
//                                                 UMShareToSina,UMShareToTencent,UMShareToRenren,UMShareToEmail,UMShareToWechatTimeline,UMShareToQQ,UMShareToDouban,UMShareToSms,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQzone,nil]
//                                       delegate:self];
}
//弹出列表方法presentSnsIconSheetView需要设置delegate为self
-(BOOL)isDirectShareInIconActionSheet
{
    return YES;
}
//-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
//{
//    //根据`responseCode`得到发送结果,如果分享成功
//    if(response.responseCode == UMSResponseCodeSuccess)
//    {
//        //得到分享到的微博平台名
//        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
//    }
//}
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
