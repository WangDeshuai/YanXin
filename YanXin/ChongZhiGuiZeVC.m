//
//  ChongZhiGuiZeVC.m
//  YanXin
//
//  Created by mac on 16/4/28.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ChongZhiGuiZeVC.h"

@interface ChongZhiGuiZeVC ()

@end

@implementation ChongZhiGuiZeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor  colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1];
    self.title=@"充值规则";
    UIImageView * imageview  =[UIImageView new];
    imageview.image=[UIImage imageNamed:@"chongzhi"];
    [self.view sd_addSubviews:@[imageview]];
    //左按钮
    UIButton*backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(5,27, 35, 35);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"goback_back_orange_on"] forState:0];
    [backBtn addTarget:self action:@selector(backClink) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBtn =[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem=leftBtn;
    
    imageview.sd_layout
    .topSpaceToView(self.view,84)
    .leftSpaceToView(self.view,30)
    .rightSpaceToView(self.view,30)
    .bottomSpaceToView(self.view,30);

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
