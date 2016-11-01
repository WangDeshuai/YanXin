//
//  ShouYeViewController.m
//  YanXin
//
//  Created by mac on 16/2/18.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "ShouYeViewController.h"
#import "FirstCustom.h"
#import "ButtonSeclt.h"
#import "ImageBtn.h"
#import "MMZCViewController.h"
#import "DidSelectVC.h"
#import "XLPopMenuViewModel.h"
#import "XLPopMenuViewSingleton.h"
#import "FirstModel.h"
#import "SouSuoVC.h"
#import "ChooseCityViewController.h"
#import "YuDingChangDiViewController.h"
#import "LrdOutputView.h"
#import "BaseLunBoTuVC.h"
@interface ShouYeViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,LrdOutputViewDelegate,SDCycleScrollViewDelegate>
{
    //表示图
    UITableView *_tableView;
    
    //存储图片的数组
    NSMutableArray * _picArr;
    
    //表头的view用来放滚动视图和预约服务控件
    UIView * _view;
    //引擎类
    //4个button的背景图
    NSMutableArray * btnImag;
    //城市button
    UIButton * btnDW;
    //城市Label
    UILabel * cityLab;
    //城市箭头
    UIImageView * imageCity;
    UIButton * souBtn;
    FirstModel * firstModel;
    CGFloat  y;
   // UIButton * buttonBtn;
}
@property (nonatomic,strong) NSMutableArray *arr;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) NSMutableArray *tankuangArr;
@property (nonatomic, strong) LrdOutputView *outputView;

@end

@implementation ShouYeViewController
-(void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
//    NSString * ss =[[NSUserDefaults standardUserDefaults] objectForKey:@"youle"];
//   
//    NSLog(@"%@",ss);
//    
//    if (ss) {
//    //NSLog(@"没有有值");
//       
//    }else{
//        //NSLog(@"有值");
//         [ self setup];
//    }
//    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"shizzz"]) {
//        [btnDW setTitle:[[NSUserDefaults standardUserDefaults] objectForKey:@"shizzz"] forState:0];
//    }else{
//        return;
//    }
    
    
}
  
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.view.backgroundColor=[UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1];
    self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:0/255.0 green:170/255.0 blue:238/255.0 alpha:1];
    [self.navigationItem setTitle:@"首页"];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:biaoti]}];
  
   // NSString * ss =[[NSUserDefaults standardUserDefaults] objectForKey:@"youle"];
    //
       // NSLog(@"%@",ss);
    
       // if (ss) {
        //NSLog(@"没有有值");
    
       // }else{
            //NSLog(@"有值");
             [ self setup];
        //}
      _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, KUAN, GAO-46-64) style:UITableViewStylePlain];
    
    
    LrdCellModel *one = [[LrdCellModel alloc] initWithTitle:@"全部" imageName:@"all"];
    
    LrdCellModel *two = [[LrdCellModel alloc] initWithTitle:@"演出公告" imageName:@"yanchugongao"];
    LrdCellModel *three = [[LrdCellModel alloc] initWithTitle:@"演员公告" imageName:@"yanyuan"];
    LrdCellModel *four = [[LrdCellModel alloc] initWithTitle:@"设备公告" imageName:@"shebei"];
    LrdCellModel *five = [[LrdCellModel alloc] initWithTitle:@"场地公告" imageName:@"changdi1"];
    self.tankuangArr=[NSMutableArray new];
    [self.tankuangArr addObject:one];
    [self.tankuangArr addObject:two];
    [self.tankuangArr addObject:three];
    [self.tankuangArr addObject:four];
    [self.tankuangArr addObject:five];
    
    _dataArray=[[NSMutableArray alloc]init];
    btnImag=[[NSMutableArray alloc]initWithObjects:@"yan-chu",@"yan-yuan",@"she-bei",@"chang-di", nil];
    _picArr=[[NSMutableArray alloc]init];
   
    //导航条左按钮
    //导航条左按钮
    btnDW = [UIButton buttonWithType:UIButtonTypeCustom];
    btnDW.frame=CGRectMake(0, 0, KUAN/4, 35);
    btnDW.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    btnDW.titleEdgeInsets=UIEdgeInsetsMake(0, 0, 0, 0);
    [btnDW addTarget:self action:@selector(onClickChooseCity:) forControlEvents:UIControlEventTouchUpInside];
    NSString * sheng =[[NSUserDefaults standardUserDefaults]objectForKey:@"shengz"];
    NSString *shi = [[NSUserDefaults standardUserDefaults]objectForKey:@"shiz"];
    NSString *xian = [[NSUserDefaults standardUserDefaults]objectForKey:@"xianz"];
    
    
    
    if (sheng) {
        [btnDW setTitle:sheng forState:0];
    } if (shi){
        [btnDW setTitle:shi forState:0];
    } if (xian){
        [btnDW setTitle:xian forState:0];
    }
    if(shi==nil && sheng==nil&& xian==nil){
        [btnDW setTitle:@"全国" forState:0];
    }
    
    UIBarButtonItem * lestBtn =[[UIBarButtonItem alloc]initWithCustomView:btnDW];
    self.navigationItem.leftBarButtonItem=lestBtn;
    
    
    
    
//导航条右按钮
    
    souBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    souBtn.frame=CGRectMake(0, 3,20, 20);
    [souBtn setBackgroundImage:[UIImage imageNamed:@"fangdajing"] forState:UIControlStateNormal];
    [souBtn addTarget:self action:@selector(sousuo) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * right =[[UIBarButtonItem alloc]initWithCustomView:souBtn];
   self.navigationItem.rightBarButtonItem=right;
   
    
  //  _engine.delegate=self;
   //创建表视图
  
    _tableView.dataSource=self;
    _tableView.delegate=self;
   
    _tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
     _tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
   //高度是滚动视图与button的纵坐标相加
    _view = [[UIView alloc]initWithFrame:CGRectMake(0, 64, KUAN,KUAN/2+10+KUAN/2.5+20 )];
    _view.backgroundColor=[UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1];
    [self buttonYuYue];
    [self jieXi1];
    _tableView.tableHeaderView=_view;
    
    [self.view addSubview:_tableView];
   
  
  //  if ([[NSUserDefaults standardUserDefaults] objectForKey:@"shiz"]) {
        [self jieXiPublic:@"1" tiao:@"0"];
 //   }
    
    
   
}

-(void)footerRefresh
{
     [_tableView.footer endRefreshing];
    static int a = 1;
    a=a+1;
    NSString * conde =[NSString stringWithFormat:@"%d",a];
 //   NSLog(@"刷新>>>>>%ld",(long)number);
    if (number==0) {
        [self jieXiPublic:conde tiao:@"0"];
    }else
    {
        NSString * numbe =[NSString stringWithFormat:@"%ld",(long)number];
        [self jieXiPublic:conde tiao:numbe];
    }
}
//右按钮
-(void)sousuo
{
    SouSuoVC * svc =[[SouSuoVC alloc]init];
    svc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:svc animated:YES];
}

-(void)setup
{
    if ([CLLocationManager locationServicesEnabled]) {
        //NSLog(@"定位服务可用");
        _coder = [[CLGeocoder alloc]init];
        _manager = [[CLLocationManager alloc] init] ;
        _manager.delegate = self;
        //设置定位精度
        _manager.desiredAccuracy=kCLLocationAccuracyBest;
        _manager.distanceFilter = kCLLocationAccuracyHundredMeters;//每隔多少米定位一次（这里的设置为每隔百米)
        if (IOS8) {
            //使用应用程序期间允许访问位置数据
            [_manager requestWhenInUseAuthorization];
        }
        // 开始定位
        [_manager startUpdatingLocation];
        
    }
    else
    {
        NSLog(@"定位服务不可用");
    }
    
    
}




//位置发生改变的时候调用
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation * location =[locations lastObject];
    //  NSLog(@"维度是%f精度是%f",location.coordinate.latitude,location.coordinate.longitude);
    //维度
    CLLocationDegrees lat = location.coordinate.latitude;
    //精度
    CLLocationDegrees lon = location.coordinate.longitude;
    
    if([[NSUserDefaults standardUserDefaults]objectForKey:@"youyou"]){
    
        return;
    }else{
        [[NSUserDefaults standardUserDefaults]setObject:@"youl" forKey:@"youyou"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [WINDOW showHUDWithText:@"定位中..." Type:ShowLoading Enabled:YES];
       
        CLLocation * aLoc = [[CLLocation alloc]initWithLatitude:lat longitude:lon];
        [_coder reverseGeocodeLocation:aLoc completionHandler:^(NSArray *placemarks, NSError *error) {
            
            [placemarks enumerateObjectsUsingBlock:^(CLPlacemark * mark, NSUInteger idx, BOOL *stop) {
                NSString * shenga =[mark.addressDictionary objectForKey:@"Country"];
                 [WINDOW showHUDWithText:@"定位成功" Type:ShowDismiss Enabled:YES];
              //NSLog(@"Country%@",[mark.addressDictionary objectForKey:@"Country"]);
                [btnDW setTitle:shenga forState:0];
               // [self jieXiPublic:@"1" tiao:@"0"];
            }];
            
        }];

    }
    
    
    
    
    
    

    
}











//左按钮
- (void)onClickChooseCity:(UIButton*)btn {
    
    ChooseCityViewController * md =[ChooseCityViewController new];
    //md.shouYe=@"biaozhi";
    
    md.shouYeBlock=^(NSString*quanguo,NSString*ss){
        
        [btn setTitle:quanguo forState:0];
        NSLog(@"ss=%@",ss);
        if ([ss isEqualToString:@"1"]) {
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"shengz"];
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"shiz"];
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"xianz"];
            [[NSUserDefaults standardUserDefaults]synchronize];
        }else if ([ss isEqualToString:@"2"]){
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"shiz"];
             [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"xianz"];
            [[NSUserDefaults standardUserDefaults]synchronize];
        }else if ([ss isEqualToString:@"3"]){
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"xianz"];
            [[NSUserDefaults standardUserDefaults]synchronize];
        }
        else{
            [[NSUserDefaults standardUserDefaults]setObject:quanguo forKey:@"xianz"];
            [[NSUserDefaults standardUserDefaults]synchronize];
        }
         [self.dataArray removeAllObjects];
        [self jieXiPublic:@"1" tiao:@"0"];
    };
    [self.navigationController pushViewController:md animated:YES];
   

    
}
//解析演出公告的
-(void)jieXiPublic:(NSString*)page tiao:(NSString*)type //sheng:(NSString*)sheng shi:(NSString*)shi xian:(NSString*)xian
{
    NSString * sheng =[[NSUserDefaults standardUserDefaults]objectForKey:@"shengz"];
    NSString *shi = [[NSUserDefaults standardUserDefaults]objectForKey:@"shiz"];
    NSString *xian = [[NSUserDefaults standardUserDefaults]objectForKey:@"xianz"];
   // NSLog(@"%@%@%@",sheng,shi,xian);
    [ShuJuModel huoquFirstPage:page Tiao:type provname:sheng cityname:shi districtname:xian success:^(NSDictionary *dic) {
        
        NSMutableArray * conArr= [dic objectForKey:@"content"];
        for (NSDictionary * dicd in conArr) {
            firstModel =[[FirstModel alloc]initWithDic:dicd];
            [_dataArray addObject:firstModel];
        }
        NSLog(@"一开始数组的个数%lu",_dataArray.count);
        [_tableView reloadData];
    } error:^(NSError *error) {
        
    }];
    

    
}




//数据解析首页滚动视图
-(void)jieXi1
{
    NSMutableArray * titleName =[NSMutableArray new];
    [ShuJuModel getFirstImage:@"1" success:^(NSDictionary *dic) {
        
        NSArray *arr2 =[dic objectForKey:@"content"];
        for (NSDictionary * bgDic2 in arr2){
             Model1 *model1 = [[Model1 alloc]initWithDic:bgDic2];
            [_picArr addObject:model1];
            [titleName addObject:model1.titleName];
        }
        [self remoteImageLoaded:titleName];
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
//    BaseLunBoTuVC * basevc =[[BaseLunBoTuVC alloc]initWithFrame:CGRectMake(0, 0, KUAN, 200*GAO/667) imageArray:a];
//    basevc.pageType=3;
//    basevc.titleArray=array;
//    basevc.placeholderImage=[UIImage imageNamed:@"1@2x.jpg"];
//    basevc.currentIndexDidTapBlock=^(NSInteger index){
//        ImageBtn* imageVC =[[ImageBtn alloc]init];
//        imageVC.hidesBottomBarWhenPushed=YES;
//        Model1 * model = _picArr[index];
//        imageVC.urlStr=model.jumpUrl;
//        [self.navigationController pushViewController:imageVC animated:YES];
//    };
  //[_view addSubview:basevc];
 
    
    SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, KUAN, 200*GAO/667) delegate:self placeholderImage:[UIImage imageNamed:@"1@2x.jpg"]];
    cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    
      cycleScrollView2.titlesGroup = array;
    cycleScrollView2.currentPageDotColor = [UIColor whiteColor];
    [_view addSubview:cycleScrollView2];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        cycleScrollView2.imageURLStringsGroup = a;
    });
    
    
    cycleScrollView2.clickItemOperationBlock = ^(NSInteger index) {
       // NSLog(@">>>>>  %ld", (long)index);
        ImageBtn* imageVC =[[ImageBtn alloc]init];
        imageVC.hidesBottomBarWhenPushed=YES;
        Model1 * model = _picArr[index];
        imageVC.urlStr=model.jumpUrl;
        [self.navigationController pushViewController:imageVC animated:YES];
    };
  
}


//表的方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.dataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
        FirstCustom *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell1"];
        if (cell==nil)
        {
            cell=[[FirstCustom alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell1"];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            
        }
   
    FirstModel * mode=_dataArray[indexPath.row];
    cell.model=mode;

   return cell;
    
}
//返回的行高
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    FirstModel * mode=_dataArray[indexPath.row];
//    
//    
//    return [_tableView cellHeightForIndexPath:indexPath model:mode keyPath:@"model" cellClass:[FirstCustom class] contentViewWidth:[self  cellContentViewWith]];
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   // FirstModel * md =_dataArray[indexPath.row];
    
//    CGFloat aa =[_tableView cellHeightForIndexPath:indexPath model:md keyPath:@"model" cellClass:[FirstCustom class] contentViewWidth:[self  cellContentViewWith]];
//    
//    NSLog(@"这是返回的行高%f",aa);
    
    return [_tableView cellHeightForIndexPath:indexPath model:_dataArray[indexPath.row] keyPath:@"model" cellClass:[FirstCustom class] contentViewWidth:[self  cellContentViewWith]];
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
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, KUAN, 32)];
    view.backgroundColor=[UIColor whiteColor];
    UIImageView * imageView =[[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 24, 24*24/32)];
    imageView.image=[UIImage imageNamed:@"volume-on"];
    UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(55, 2, 150, 34)];
    label.text=@"演出公告";
    label.textColor=[UIColor colorWithRed:0/255.0 green:170/255.0 blue:238/255.0 alpha:.8];
    [view addSubview:imageView];
    [view addSubview:label];
    
    UIButton *  buttonBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    buttonBtn.frame=CGRectMake(KUAN-78, 2, 70, 30);
    [buttonBtn setTitle:@"全部" forState:0];
    if (publicName==nil) {
         [buttonBtn setTitle:@"全部" forState:0];
    }else{
         [buttonBtn setTitle:publicName forState:0];
    }
    [buttonBtn setTitleColor:[UIColor colorWithRed:0/255.0 green:170/255.0 blue:238/255.0 alpha:.8] forState:0];
    buttonBtn.titleLabel.font=[UIFont systemFontOfSize:14];
   
    [buttonBtn addTarget:self action:@selector(Clink:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:buttonBtn];
    UIView *linview =[[UIView alloc]initWithFrame:CGRectMake(10, 31, KUAN-10, 1)];
    linview.backgroundColor=[UIColor colorWithRed:75/255.0 green:75/255.0 blue:75/255.0 alpha:.2];
    [view addSubview:linview];
    
    return view;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    FirstModel * md =_dataArray[indexPath.row];
    DidSelectVC * vc =[DidSelectVC new];
    vc.model=md;
    vc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    y=_tableView.contentOffset.y;
    if (_tableView.contentOffset.y>370) {
        y=365.00;
    }
}
-(void)Clink:(UIButton*)btn
{  // btn.selected=!btn.selected;
    //NSLog(@">>>%@",_arr);
    
    NSLog(@"点击了");
    CGFloat x = KUAN-15;//btn.center.x;
    CGFloat a =0;
    if (KUAN<375) {
        a=500;
    }else{
        a=470;
    }
    
    CGFloat yy = a*GAO/667-y;//btn.frame.origin.y + btn.bounds.size.height + 10;
    NSLog(@"%f",y);
    _outputView = [[LrdOutputView alloc] initWithDataArray:self.tankuangArr origin:CGPointMake(x, yy) width:125 height:44 direction:kLrdOutputViewDirectionRight];
   
    _outputView.delegate = self;
    _outputView.dismissOperation = ^(){
        //设置成nil，以防内存泄露
        _outputView = nil;
    };
    [_outputView pop];
    
}


- (void)didSelectedAtIndexPath:(NSIndexPath *)indexPath {
    
    
    LrdCellModel * md =_tankuangArr[indexPath.row];
    publicName=md.title;
   
     number=indexPath.row;
    NSString * type =[NSString stringWithFormat:@"%ld",(long)indexPath.row];
     [_dataArray removeAllObjects];
      [_tableView reloadData];
    [self jieXiPublic:@"1" tiao:type];
     [_tableView reloadData];
   
}




//button预约
-(void)buttonYuYue//:(UIView*)view1
{
   
    for (int i = 0 ; i<2; i++) {
        
        for(int j = 0;j<2;j++)
        {
            static int count = -1;
            count++;
            
            UIButton * button1 = [UIButton buttonWithType:UIButtonTypeCustom];
            button1.tag=count;
            button1.frame=CGRectMake(12+(KUAN/2-15+5)*j, 200*GAO/667+5+(KUAN/5+5)*i, KUAN/2-15, KUAN/5);
            [button1 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            button1.layer.cornerRadius=8;
            button1.clipsToBounds=YES;
            [button1 setBackgroundImage:[UIImage imageNamed:btnImag[count]] forState:UIControlStateNormal];
            
            [_view addSubview:button1];
        }
    }
    
}
//四个按钮
-(void)buttonClick:(UIButton*)button
{
  //  NSLog(@">>>>>>%d",button.tag);
    
    NSString *na =   [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    if (na==nil) {
        MMZCViewController * vc =[MMZCViewController new];
        [self presentViewController:vc animated:YES completion:nil];
    }
    else{
      //  NSLog(@"%lu",button.tag);
//        if (button.tag==3) {
//            
//            YuDingChangDiViewController * yd =[YuDingChangDiViewController new];
//            yd.hidesBottomBarWhenPushed=YES;
//           // yd.number=button.tag;
//            [self.navigationController pushViewController:yd animated:YES];
//            
//            
//        }else{
            ButtonSeclt * vc =[[ButtonSeclt alloc]init];
            vc.hidesBottomBarWhenPushed=YES;
            vc.number=button.tag;
            [self.navigationController pushViewController:vc animated:YES];
        //}
        
   
    }
}


-(UIImage *)compressImageWith:(UIImage *)image width:(float)width height:(float)height
{
    float imageWidth = image.size.width;
    float imageHeight = image.size.height;
    
    float widthScale = imageWidth /width;
    float heightScale = imageHeight /height;
    
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    
    if (widthScale > heightScale) {
        [image drawInRect:CGRectMake(0, 0, imageWidth /heightScale , height)];
    }
    else {
        [image drawInRect:CGRectMake(0, 0, width , imageHeight /widthScale)];
    }
    
    // 从当前context中创建一个改变大小后的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //[newImage retain];
    [newImage copy];
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    return newImage;
    
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
