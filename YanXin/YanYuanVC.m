//
//  YanYuanVC.m
//  YanXin
//
//  Created by mac on 16/2/18.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "YanYuanVC.h"
#import "CuestmYanYuan.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
#import "YanYuanKongJian.h"
#import "yanyuanModel.h"
#import "SoSuoYanYuanViewController.h"
@interface YanYuanVC ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UISearchDisplayDelegate>
{
    UITableView * _tableView;
    
    //表的数据源
    NSMutableArray *dataArr;
    //热门推荐的数据源
    UIView * linView;
    UISearchBar * searchBar;
   
    yanyuanModel * model;
}
@end

@implementation YanYuanVC
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=NO;
   // [dataArr removeAllObjects];
  //  dataArr=nil;
     aaaa=1;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:0/255.0 green:170/255.0 blue:238/255.0 alpha:1];
   // [self.navigationItem setTitle:@"演员"];
    self.title=@"演员";
    
    
   // self.title=@"演员";
    //左按钮
    UIButton*backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(5,27, 35, 35);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"goback_back_orange_on"] forState:0];
    [backBtn addTarget:self action:@selector(backClink:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBtn =[[UIBarButtonItem alloc]initWithCustomView:backBtn];
     self.navigationItem.leftBarButtonItem=leftBtn;
    
   [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
  UIButton*  souBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    souBtn.frame=CGRectMake(0, 3,20, 20);
    [souBtn setBackgroundImage:[UIImage imageNamed:@"fangdajing"] forState:UIControlStateNormal];
    [souBtn addTarget:self action:@selector(sousuo) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * right =[[UIBarButtonItem alloc]initWithCustomView:souBtn];
    self.navigationItem.rightBarButtonItem=right;
    //表的创建
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, KUAN, GAO-64-46) style:UITableViewStylePlain];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.backgroundColor=[UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1];
    _tableView.backgroundColor=[UIColor whiteColor];
    _tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
   [self.view addSubview:_tableView];
  
    dataArr =[[NSMutableArray alloc]init];
//表头热门推荐
    UIView * view1 =[[UIView alloc]initWithFrame:CGRectMake(0, 64, 0,10+KUAN/12+(KUAN/12+5)*5)];
    view1.backgroundColor=[UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1];
    _tableView.tableHeaderView=view1;
//Label热门推荐
    UILabel * lab1 =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, KUAN, KUAN/12)];
    lab1.backgroundColor=[UIColor whiteColor];
    lab1.text=@"  热门推荐";
    [view1 addSubview:lab1];
    [self jiexiData:@"1" tiaoshu:@"10" leimu:@"0"];
    
    
   _tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
     _tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
    
    [ShuJuModel huoquyanyuanWihBiaoQian:@"1" success:^(NSDictionary *dic) {
        
        if(dic){
            NSMutableArray * remenAr=[[NSMutableArray alloc]init];
            NSMutableArray * taggg =[NSMutableArray new];
            NSMutableArray * contentDic = [dic objectForKey:@"content"];
            for (NSDictionary * d in contentDic ) {
                [remenAr addObject:[d objectForKey:@"categoryname"]];
                NSString * ss =[d objectForKey:@"num"];
                [taggg addObject:ss];
            }
            
            
            for (int i = 0 ; i<remenAr.count/3; i++)
            {
                for(int j = 0;j<3;j++)
                {
                    static int count = 0;
                    //
                    count ++;
                    //如果执行到某一次,不继续创建button直接retrun返回
                    if (count > 15)
                    {
                        return ;
                    }
                    UIButton * button1 = [UIButton buttonWithType:UIButtonTypeCustom];
                    button1.frame=CGRectMake(15+(KUAN/3.5+10)*j,10+KUAN/12+(KUAN/12+5)*i, KUAN/3.5, KUAN/12);
                    [button1 setTitle:remenAr[count-1] forState:UIControlStateNormal];
                    button1.titleLabel.font=[UIFont systemFontOfSize:15];
                    [button1 setTitleColor:[UIColor colorWithRed:0/255.0 green:170/255.0 blue:238/255.0 alpha:1] forState:UIControlStateNormal];
                    [button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
                    [button1 setBackgroundImage:[UIImage imageNamed:@"圆角矩形-按钮"] forState:UIControlStateSelected];
                    button1.tag=[taggg[count-1] integerValue];
                    [button1 addTarget:self action:@selector(buttonClink1:) forControlEvents:UIControlEventTouchUpInside];
                    button1.layer.cornerRadius=15;
                    button1.clipsToBounds=YES;
                    button1.backgroundColor=[UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1];
                    [view1 addSubview:button1];
                    if (i==0&j==0)
                    {
                        button1.selected=YES;
                        _lastBtn=button1;
                        aaaa=1;
                    }
                }
            }

        }
        
    } error:^(NSError *error) {
        
    }];
    
    
    UIButton * xiangShangBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    xiangShangBtn.frame=CGRectMake(KUAN-20-40, GAO-56-40, 40, 40);
    
    [xiangShangBtn setBackgroundImage:[UIImage imageNamed:@"向上箭头"] forState:0];
    [xiangShangBtn addTarget:self action:@selector(dingduan:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:xiangShangBtn];
    
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:biaoti]}];
}

-(void)dingduan:(UIButton*)btn{
    [_tableView setContentOffset:CGPointZero animated:YES];
}

-(void)headerRefresh
{
    [_tableView.header endRefreshing];
    [dataArr removeAllObjects];
     NSString * leibie =[NSString stringWithFormat:@"%d",btnTag];
     [_tableView reloadData];
    [self jiexiData:@"1" tiaoshu:@"10" leimu:leibie];
    
}

//右按钮
-(void)sousuo
{
    SoSuoYanYuanViewController * svc =[[SoSuoYanYuanViewController alloc]init];
    svc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:svc animated:YES];
}
-(void)jiexiData:(NSString*)page tiaoshu:(NSString*)tiaos leimu:(NSString*)leimu
{
   
    
    [ShuJuModel chaxunYanyiquanPage:page Tiaogshu:tiaos Leimu:leimu success:^(NSDictionary *dic) {
       // [dataArr removeAllObjects];
        if (dic) {
            NSMutableArray * contentArr =[dic objectForKey:@"content"];
            for (NSDictionary * di in contentArr ){
                model=[[yanyuanModel alloc]initWithDic:di];
                [dataArr addObject:model];
                // NSLog(@"www%@",model.categoryname);
            }
            [_tableView reloadData];
        }
    } error:^(NSError *error) {
        
    }];
    
}
//左按钮
-(void)backClink:(UIButton*)btn
{
    self.tabBarController.selectedIndex=0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    CuestmYanYuan *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[CuestmYanYuan alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    cell.model=dataArr[indexPath.row];
   
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    
   yanyuanModel *str = dataArr[indexPath.row];
    
    return [_tableView cellHeightForIndexPath:indexPath model:str keyPath:@"model" cellClass:[CuestmYanYuan class] contentViewWidth:[self  cellContentViewWith]];
}
- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    // 适配ios7
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}




//点击表格的方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    yanyuanModel * mode22 =dataArr[indexPath.row];
    
    YanYuanKongJian * vc =[YanYuanKongJian new];
 //   vc.counter=mode22.who;
    vc.model12=mode22;
    vc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)buttonClink1:(UIButton*)button
{
    _lastBtn.selected=NO;
    button.selected=YES;
    _lastBtn=button;
    NSString * leimu =[NSString stringWithFormat:@"%ld",(long)button.tag];
    aaaa=1;
   // NSLog(@"btaNum= %ld",(long)button.tag);
   btnTag=(int) button.tag ;
    [dataArr removeAllObjects];
    [self jiexiData:@"1" tiaoshu:@"10" leimu:leimu];
}
-(void)footerRefresh
{
    [_tableView.footer endRefreshing];
   // int a = 1;
    //a=a+1;
    aaaa++;
   // NSLog(@"下拉加载刷新的%d",aaaa);
    NSLog(@"类目%d",btnTag);
   NSString * conde =[NSString stringWithFormat:@"%d",aaaa];
    NSString * leibie =[NSString stringWithFormat:@"%d",btnTag];
    [self jiexiData:conde tiaoshu:@"10" leimu:leibie];
   [_tableView reloadData];
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
