//
//  JuBaoVC.m
//  YanXin
//
//  Created by mac on 16/5/24.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JuBaoVC.h"
#import "TouSu1.h"
#import "TouSu2.h"
@interface JuBaoVC ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,retain)UITableView * tableView;
@end

@implementation JuBaoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //左按钮
    self.title=@"投诉";
    self.view.backgroundColor=[UIColor whiteColor];
    UIButton*backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(5,27, 35, 35);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"goback_back_orange_on"] forState:0];
    [backBtn addTarget:self action:@selector(backClink) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBtn =[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem=leftBtn;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:biaoti]}];
    [self view1];
}
-(void)backClink{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)view1{
    
    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, KUAN, GAO-64) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.row==0) {
        cell.textLabel.text=@"发现不良信息需要投诉";
    }
//    }if(indexPath.row==1){
//        cell.textLabel.text=@"其它原因需要投诉";
//    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row==0) {
        TouSu1 * vc =[TouSu1 new];
        [self.navigationController pushViewController:vc animated:YES];
    }
//    }else{
//        TouSu2 * vc =[TouSu2 new];
//        [self.navigationController pushViewController:vc animated:YES];
//    }
    
   
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
