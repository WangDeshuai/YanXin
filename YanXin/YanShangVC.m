//
//  YanShangVC.m
//  YanXin
//
//  Created by mac on 16/2/18.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "YanShangVC.h"
#import "ChildVC.h"
#import "ChangDiVC.h"
#import "SheBeiVC.h"
#import "YanShangSouSuoVC.h"
@interface YanShangVC ()<UIScrollViewDelegate>
{
    UISegmentedControl*segmentedControl;
    //大的滚动视图
    UIScrollView * _bigScroller;
    UIView * linView;
    UIView * view1;
    NSMutableArray * _numberArr;
  
    UIButton *souBtn;
}
@end

@implementation YanShangVC
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=YES;
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=NO;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:0/255.0 green:170/255.0 blue:238/255.0 alpha:1];
    [self segmentedControl];
    //大的滚动视图
    [self scrollView1];
   
    ChildVC * cvc = [[ChildVC alloc]init];
    cvc.yeshu=3;
    cvc.view.frame=CGRectMake(0, 0, KUAN, GAO);
    [_bigScroller addSubview:cvc.view];
    [self addChildViewController:cvc];
    
    SheBeiVC * shebVC=[[SheBeiVC alloc]init];
    shebVC.yeshu=4;
    shebVC.view.frame=CGRectMake(KUAN, 0, KUAN, GAO);
    [self addChildViewController:shebVC];
    
    ChangDiVC *vccc=[[ChangDiVC alloc]init];
    vccc.yeshu=5;
    vccc.view.frame=CGRectMake(KUAN*2, 0, KUAN, GAO);
    [self addChildViewController:vccc];

   
   
    
    
}



////大的滚动视图
-(void)scrollView1
{   _bigScroller =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, KUAN, GAO-46-64)];
    _bigScroller.delegate=self;
    _bigScroller.pagingEnabled=YES;
    _bigScroller.contentSize=CGSizeMake(KUAN*3, GAO-64-46);
    [self.view addSubview:_bigScroller];
    
}- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 根据滚动视图的偏移量,计算当前所在的点
    int i = scrollView.contentOffset.x/KUAN;
    UIButton * button =(UIButton*)[view1 viewWithTag:i+1];
    [self upDataWeb1:button];
}







-(void)segmentedControl
{
    
    view1 =[[UIView alloc]initWithFrame:CGRectMake(0, 0, KUAN, 64)];
    view1.backgroundColor=[UIColor colorWithRed:0/255.0 green:170/255.0 blue:238/255.0 alpha:1];
    [self.view addSubview:view1];
    
    souBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    souBtn.frame=CGRectMake(KUAN-36, 33,20, 20);
    [souBtn setBackgroundImage:[UIImage imageNamed:@"fangdajing"] forState:UIControlStateNormal];
    [souBtn addTarget:self action:@selector(sousuo) forControlEvents:UIControlEventTouchUpInside];
    [view1 addSubview:souBtn];

    //为了显示背景图片自定义navgationbar上面的三个按钮
    UIButton *but =[[UIButton alloc]initWithFrame:CGRectMake(5, 27, 35, 35)];
    [but setImage:[UIImage imageNamed:@"goback_back_orange_on"] forState:UIControlStateNormal];
    [but addTarget:self action:@selector(clickaddBtn:) forControlEvents:UIControlEventTouchUpInside];
    [view1 addSubview:but];

    
    
    NSArray * arr = [[NSArray alloc]initWithObjects:@"演出公司",@"演出设备",@"演出场地", nil];
  
    CGFloat a =0;
    if (KUAN<375) {
        a=40;
    }else if(KUAN==375){
        a=36;
    }else{
        a=32;
    }
    for (int i = 0; i<3; i++)
    {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame=[FrameAutoScaleLFL CGLFLMakeX:40+100*i Y:a width:100 height:20];
        [button setTitleColor:[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1] forState:UIControlStateNormal];
       [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        button.titleLabel.font=[UIFont systemFontOfSize:17];
        button.tag=i+1;
        [button setTitle:arr[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(upDataWeb1:) forControlEvents:UIControlEventTouchUpInside];
        [view1 addSubview:button ];
        if (i == 0)
        {
            // 获取第一个button的标题
            linView = [[UIView alloc]init];
            linView.backgroundColor = [UIColor whiteColor];
            linView.center = CGPointMake(button.center.x, button.center.y+16);
            linView.bounds = CGRectMake(0, 0,(KUAN-100-8)/3, 2);
            [view1 addSubview:linView];
            button.selected=YES;
            _lastBtn=button;
           
        }
    }

}
-(void)upDataWeb1:(UIButton*)button
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    _lastBtn.selected=NO;
    button.selected=YES;
    _lastBtn=button;
    linView.center = CGPointMake(button.center.x, button.center.y+16);
    linView.bounds = CGRectMake(0, 0,(KUAN-100-8)/3, 2);
    [UIView commitAnimations];
    _bigScroller.contentOffset=CGPointMake(KUAN*(button.tag-1), 0);
    if (button.tag==1) {
        ChildVC * chivc = self.childViewControllers[0];
        [_bigScroller addSubview:chivc.view];
    }
    if (button.tag==2) {
        SheBeiVC * shebe = self.childViewControllers[1];
        [_bigScroller addSubview:shebe.view];
    }
  
    if (button.tag==3) {
        ChangDiVC * aa =self.childViewControllers[2];
        [_bigScroller addSubview:aa.view];
    }

}
//右按钮
-(void)sousuo
{
    YanShangSouSuoVC * yanVC=[[YanShangSouSuoVC alloc]init];
    
    [self.navigationController pushViewController:yanVC animated:YES];
    
}
//左按钮
-(void)clickaddBtn:(UIButton *)button
{
    
    self.tabBarController.selectedIndex=0;
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
