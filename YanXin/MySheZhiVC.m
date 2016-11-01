//
//  MySheZhiVC.m
//  YanXin
//
//  Created by mac on 16/3/23.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "MySheZhiVC.h"
#import "XiuGaiPassWordVC.h"
#import "MMZCViewController.h"
#import "MyVC.h"
@interface MySheZhiVC ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
{
    UITableView * _tableView;
}
@end

@implementation MySheZhiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:0/255.0 green:170/255.0 blue:238/255.0 alpha:1];
   self.title=@"设置";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:biaoti]}];
    UIButton*backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(5,27, 35, 35);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"goback_back_orange_on"] forState:0];
    [backBtn addTarget:self action:@selector(backClink) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBtn =[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem=leftBtn;
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, KUAN, GAO) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];
  _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 2;
    }
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
        
    }
    
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            cell.textLabel.text=@"修改密码";
        }
        else
        {
           // cell.textLabel.text=@"清除缓存";
            cell.textLabel.text=[NSString stringWithFormat:@"清除缓存(%.2fM)",[NSString getFileSizeWithPath:[NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Library/Caches"]]]];
           
          //  NSLog(@"%@",NSHomeDirectory());
            
        }
    }
    else
    {
        if (indexPath.row==0) {
            cell.textLabel.text=@"联系我们";
        }
        else if(indexPath.row==1)
        {
            cell.textLabel.text=@"退出当前账号";
        }else
        {
            cell.textLabel.text=@"关于";
            cell.detailTextLabel.text=@"版本号1.1.1";
        }
    }
     cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            //修改密码
            XiuGaiPassWordVC * vc =[XiuGaiPassWordVC new];
             vc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:vc animated:YES];
            
            
        }else
        {
            //清除缓存
            UIAlertView * alview = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"是否清楚缓存" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alview.tag=indexPath.row;
            [alview show];
        }
    }
    
    else{
        
            if (indexPath.row==0) {
                //联系我们
              NSString *allString = [NSString stringWithFormat:@"tel:18519186222"];
                NSString*telUrl = [allString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
             [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telUrl]];
                
            }else if(indexPath.row==1){
               //退出
            UIAlertView * alview1 = [[UIAlertView alloc]initWithTitle:nil message:@"是否退出" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alview1.tag=10;
            [alview1 show];
            }else
            {
                
                 //关于
            }
    }
    
    
    
}
//警告框的代理
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        
        return;
    }else if (buttonIndex==1 && alertView.tag==1 )
    {
        //清楚缓存
        UIAlertView* alertViewc = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:[NSString stringWithFormat:@"清理成功，共清理(%.2fM)垃圾",[NSString getFileSizeWithPath:[NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Library/Caches"]]]] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertViewc show];
        NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        
        NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
        
        for (NSString *p in files) {
            NSError *error;
            NSString *path = [cachPath stringByAppendingPathComponent:p];
            if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
            }
        }
        
        
        return;
    }
    else if (buttonIndex==1 && alertView.tag==10 )
    {
       
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"yanyuanma"];
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"username"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"benrenname"];
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"huiyuanma"];
      
        [[NSUserDefaults standardUserDefaults] synchronize];
       
        [LCProgressHUD showSuccess:@"退出成功"];
       // [self.navigationController popToRootViewControllerAnimated:YES];
        
    }
       [_tableView reloadData];
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
