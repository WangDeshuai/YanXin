//
//  SheBeiVC.m
//  YanXin
//
//  Created by mac on 16/3/19.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "SheBeiVC.h"
#import "SheBeiCell.h"
#import "YanShangModel.h"
#import "Custom.h"
#import "XiangXiViewController.h"
@interface SheBeiVC ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,SDCycleScrollViewDelegate>
{
    UITableView * _tableView;
    //引擎类
    NSMutableArray * _picArr;
    UIScrollView *smScll;
    UIPageControl  * _pageControl;
    NSTimer * _timer;
    UIView * view1 ;
    YanShangModel * model;
}
@property(nonatomic,retain)NSMutableArray * dataArray;
@end

@implementation SheBeiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor yellowColor];
    self.automaticallyAdjustsScrollViewInsets=NO;
    _picArr=[[NSMutableArray alloc]init];
    _dataArray=[[NSMutableArray alloc]init];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, KUAN, GAO) style:UITableViewStylePlain];
    _tableView.contentInset=UIEdgeInsetsMake(0, 0, 100, 0);
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.rowHeight=100;
    _tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
      _tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
     _tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    [self jieXi2];
    [self jieXiData:@"1"];
}
-(void)footerRefresh
{
    [_tableView.footer endRefreshing];
    static int a = 1;
    a=a+1;
    NSString * conde =[NSString stringWithFormat:@"%d",a];
    [self jieXiData:conde];

}
-(void)headerRefresh
{
    [_tableView.header endRefreshing];
    [_dataArray removeAllObjects];
    [self jieXiData:@"1"];
    [_tableView reloadData];
    
}
-(void)jieXiData:(NSString*)yeshu
{
    [ShuJuModel huoquSencondType:@"4" yeShu:yeshu success:^(NSDictionary *dic) {
        
        NSMutableArray * contentArr =[dic objectForKey:@"content"];
        for (NSDictionary * obDic in contentArr) {
            model=[[YanShangModel alloc]initWithDic:obDic];
            [_dataArray addObject:model];
        }
        [_tableView reloadData];
    } error:^(NSError *error) {
        
    }];
}







//数据解析首页滚动视图
-(void)jieXi2
{

    NSMutableArray * array =[NSMutableArray new];

    [ShuJuModel getFirstImage:@"3" success:^(NSDictionary *dic) {
        
        NSArray *arr2 =[dic objectForKey:@"content"];
        for (NSDictionary * bgDic2 in arr2){
            Model1 *model1 = [[Model1 alloc]initWithDic:bgDic2];
            [_picArr addObject:model1];
            [array addObject:model1.titleName];
        }
       // [self dingshiqi];
        [self remoteImageLoaded:array];
    } error:^(NSError *error) {
        
    }];





}



//获取网络图片
- (void)remoteImageLoaded:(NSMutableArray*)array{
    
    NSMutableArray * a =[NSMutableArray new];
    for (int i = 0; i<_picArr.count; i++) {
        Model1 *m =_picArr[i];
        [a addObject:m.picUrl];
    }
    
   // NSLog(@"这是%@",a);
//    
//    BaseLunBoTuVC * banner =[[BaseLunBoTuVC alloc]initWithFrame:CGRectMake(0, 0, KUAN, 200*GAO/667) imageArray:a];
//    banner.pageType=3;
//    banner.placeholderImage=[UIImage imageNamed:@"1@2x.jpg"];
//    banner.titleArray=array;
//    banner.currentIndexDidTapBlock=^(NSInteger index){
//        
//    };
//
//    
//    view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KUAN,banner.frame.size.height)];
//    view1.backgroundColor=[UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1];
//    [view1 addSubview:banner];
    SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, KUAN, 200*GAO/667) delegate:self placeholderImage:[UIImage imageNamed:@"1@2x.jpg"]];
    cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    
    cycleScrollView2.titlesGroup = array;
    cycleScrollView2.currentPageDotColor = [UIColor whiteColor];
    view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KUAN,cycleScrollView2.frame.size.height)];
    view1.backgroundColor=[UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1];
    [view1 addSubview:cycleScrollView2];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        cycleScrollView2.imageURLStringsGroup = a;
    });
    
    
    cycleScrollView2.clickItemOperationBlock = ^(NSInteger index) {
        // NSLog(@">>>>>  %ld", (long)index);
        //        ImageBtn* imageVC =[[ImageBtn alloc]init];
        //        imageVC.hidesBottomBarWhenPushed=YES;
        //        Model1 * model = _picArr[index];
        //        imageVC.urlStr=model.jumpUrl;
        //        [self.navigationController pushViewController:imageVC animated:YES];
    };
    

    
    
    
    
    _tableView.tableHeaderView=view1;
    //[self buttonYuYue:banner];
}








-(void)dingshiqi
{
    
    smScll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, KUAN, 200*GAO/667)];
    smScll.pagingEnabled=YES;
    smScll.showsHorizontalScrollIndicator=NO;
    smScll.delegate=self;
    view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KUAN, 200*GAO/667)];
    _tableView.tableHeaderView=view1;
    [self.view addSubview:_tableView];
    _tableView.tableHeaderView=view1;
    
    for (int i =0;i<_picArr.count;i++){
        
        Model1 * mmd = _picArr[i];
        UIButton * imgView = [UIButton buttonWithType:UIButtonTypeCustom];
        imgView.frame = CGRectMake(KUAN*i, 0, KUAN, 200*GAO/667);
        [imgView setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:mmd.picUrl]];
        
        [smScll addSubview:imgView];
    }
    smScll.contentSize=CGSizeMake(KUAN*_picArr.count, 0);
    [view1 addSubview:smScll];
    _pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(0,smScll.frame.size.height-15, KUAN, 20)];
    _pageControl.numberOfPages=_picArr.count;
    _pageControl.pageIndicatorTintColor=[UIColor whiteColor];
    _pageControl.currentPageIndicatorTintColor=[UIColor redColor];
    _pageControl.currentPage=0;
    [view1 addSubview:_pageControl];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(changeImage) userInfo:nil repeats:YES];
}
- (void)changeImage
{
    static int offset_x = 375;
    // 判断scrollView是否到达边界位置
    if ( smScll.contentOffset.x == KUAN*(_picArr.count-1))
    {
        //取反
        offset_x = -KUAN;
    }
    // 判断scrollView是否到达边界位置
    if (smScll.contentOffset.x == 0) {
        
        offset_x = KUAN;
    }
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    smScll.contentOffset = CGPointMake(smScll.contentOffset.x+offset_x, 0);
    _pageControl.currentPage = smScll.contentOffset.x/KUAN;
    [UIView commitAnimations];
}
// 将要开始拖拽
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    // 销毁定时器
    [_timer invalidate];
    _timer = nil;
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (_timer==nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(changeImage) userInfo:nil repeats:YES];
    }
    int index = scrollView.contentOffset.x/KUAN;
    _pageControl.currentPage=index;
}
//表的方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Custom*cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell=[[Custom alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    YanShangModel * md =_dataArray[indexPath.row];
    cell.model=md;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XiangXiViewController * vc =[XiangXiViewController new];
    vc.navigationController.navigationBarHidden=NO;
    vc.hidesBottomBarWhenPushed=YES;
    vc.model=_dataArray[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];;
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
