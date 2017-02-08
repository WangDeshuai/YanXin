//
//  HelpViewController.m
//  YanXin
//
//  Created by Macx on 17/1/26.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "HelpViewController.h"

@interface HelpViewController ()

@end

@implementation HelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self daohangTiao];
    
    UILabel * nameLable =[UILabel new];
    nameLable.text=@"本软件本着健康和谐向上为宗旨，是一款试用用演员和演商之间相互预定的App。在演艺圈处可以发表自己的心情和一些动态。(本着无骚扰、暴力、色情等违法行为，如果一经发现某演员有违规现象，请前往演员详情界面右上角有投诉按钮进行举报投诉，严重者会被永久封号!!!)";
    nameLable.font=[UIFont systemFontOfSize:16];
    nameLable.numberOfLines=0;
    [self.view sd_addSubviews:@[nameLable]];
    nameLable.sd_layout
    .leftSpaceToView(self.view,30)
    .rightSpaceToView(self.view,30)
    .topSpaceToView(self.view,120)
    .autoHeightRatio(0);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --导航条创建
-(void)daohangTiao{
    self.navigationController.navigationBar.barTintColor=DAO_COLOR;
    self.view.backgroundColor=COLOR;
    self.title=@"说明";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:biaoti]}];
    //返回按钮
    UIButton*backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(5,27, 35, 35);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"goback_back_orange_on"] forState:0];
    [backBtn addTarget:self action:@selector(backClink) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBtn =[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem=leftBtn;
    
}
-(void)backClink{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
