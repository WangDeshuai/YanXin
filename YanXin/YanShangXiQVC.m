//
//  YanShangXiQVC.m
//  YanXin
//
//  Created by Macx on 17/1/17.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "YanShangXiQVC.h"
#import "SGTopTitleView.h"
#import "GongSiJianJieVC.h"
#import "SuccessAnLiViC.h"
#import "YanShangXiangQingCell.h"
#import "XiangCeTableViewCell.h"
#import "PhotoYuLanView.h"
#import "PhotoViewController.h"
@interface YanShangXiQVC ()<SGTopTitleViewDelegate,UIScrollViewDelegate,UITableViewDelegate, UITableViewDataSource>
@property(nonatomic,strong)UIScrollView * bgScrollView;
@property(nonatomic,strong)UIView * bgView;
@property (nonatomic, strong) SGTopTitleView *topTitleView;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) UIScrollView *mainScrollView;
//////////新建立
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * nameArray;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)NSMutableArray * imageArray;
@property(nonatomic,strong)UIButton * lastBtn;
//获取照片
@property(nonatomic,strong)NSMutableArray * photoArray;
//获取视频
@property(nonatomic,strong)NSMutableArray * vivtoArray;

@end

@implementation YanShangXiQVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self daohangTiao];
    _bgView=self.view;
    [self CreatArray];
    [self CreatTabelView];
    [self getWangLuoQingQiu];
  

  
}
#pragma mark --创建数组
-(void)CreatArray{
    _nameArray=[[NSMutableArray alloc]initWithObjects:@"",@"联  系  人:",@"联系电话:",@"联系地址:", nil];
    _dataArray=[NSMutableArray new];
    _imageArray=[[NSMutableArray alloc]initWithObjects:@"",@"ycgg_person",@"ycgg_phone",@"ycgg_place", nil];
    _photoArray=[NSMutableArray new];
    _vivtoArray=[NSMutableArray new];
}


#pragma mark --获取网络请求
//图片
-(void)getWangLuoQingQiu{
    //_accountPhone
    [Engine ChanKanYanShangAnLiAccount:_accountPhone Type:@"1" Page:@"1" PageNum:@"6" success:^(NSDictionary *dic) {
        
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"1"]) {
            NSArray * contentArr =[dic objectForKey:@"content"];
            for (NSDictionary * dicc in contentArr) {
                NSString * imageStr =[dicc objectForKey:@"case_url"];
                [_photoArray addObject:imageStr];
            }
        }else
        {
            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
        }
        [_tableView reloadData];
    } error:^(NSError *error) {
        
    }];
}
//视频
-(void)getWangLuoQingQiuVidoPage{
    
    [Engine ChanKanYanShangAnLiAccount:_accountPhone Type:@"2" Page:@"1" PageNum:@"6" success:^(NSDictionary *dic) {
        
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"1"]) {
            NSArray * contentArr =[dic objectForKey:@"content"];
            for (NSDictionary * dicc in contentArr) {
                NSString * imageStr =[ToolClass isString:[NSString stringWithFormat:@"%@",[dicc objectForKey:@"cover_picture"]]];
                [_vivtoArray addObject:imageStr];
            }
            [_tableView reloadData];
        }else
        {
            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
        }
        
    } error:^(NSError *error) {
        
    }];
}







-(void)shuJuJieXi{
    [Engine chaKanXiangQingMessageAccount:_accountPhone success:^(NSDictionary *dic) {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"1"]) {
            NSDictionary * dicc =[dic objectForKey:@"content"];
           // nameLabel.text=[ToolClass isString:[NSString stringWithFormat:@"%@",[dicc objectForKey:@"introduction"]]];
            [_dataArray addObject:[ToolClass isString:[NSString stringWithFormat:@"%@",[dicc objectForKey:@"introduction"]]]];
            [_dataArray addObject:[ToolClass isString:[NSString stringWithFormat:@"%@",[dicc objectForKey:@"linkman"]]]];
            [_dataArray addObject:[ToolClass isString:[NSString stringWithFormat:@"%@",[dicc objectForKey:@"connecttel"]]]];
            [_dataArray addObject:[ToolClass isString:[NSString stringWithFormat:@"%@",[dicc objectForKey:@"address"]]]];
            [_tableView reloadData];
        }else
        {
            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
        }
    } error:^(NSError *error) {
        
    }];
}


#pragma mark --表头
-(UIView*)CreatTableViewHead{
    UIView * headView=[UIView new];
    headView.backgroundColor=[UIColor yellowColor];
    headView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,64)
    .heightIs(216);
    
    UIImageView * headImage =[UIImageView new];
        //headImage.image=_titleImage;
    [headImage sd_setImageWithURL:[NSURL URLWithString:_titleImage] placeholderImage:[UIImage imageNamed:@"messege_bg"]];
    [headView sd_addSubviews:@[headImage]];
    headImage.sd_layout
    .centerXEqualToView(headView)
    .topSpaceToView(headView,0)
    .widthIs(ScreenWidth)
    .heightIs(216);

    
    
    
    
    return headView;
}

-(void)CreatTabelView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHight) style:UITableViewStylePlain];
    }
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.backgroundColor=COLOR;
    _tableView.tableFooterView=[UIView new];
    _tableView.tableHeaderView=[self CreatTableViewHead];
    
    [self.view addSubview:_tableView];
    [self shuJuJieXi];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (_lastBtn.tag==0) {
        return _dataArray.count;
    }else{
        return 1;
    }
    
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    if (_lastBtn.tag==0) {
        
        YanShangXiangQingCell * cell1 =[YanShangXiangQingCell cellWithTableView:tableView CellID:@"Cell"];
        cell1.leftImage.image=[UIImage imageNamed:_imageArray[indexPath.row]];
        cell1.titlelabel.text=_nameArray[indexPath.row];
        cell1.nameLabel.text=_dataArray[indexPath.row];
         cell1.nameLabel.textColor=[UIColor blackColor];
        if (indexPath.row==0) {
            [cell1 sd_addSubviews:@[ cell1.nameLabel]];
            cell1.nameLabel.numberOfLines=0;
            cell1.nameLabel.font=[UIFont systemFontOfSize:15];
            cell1.nameLabel.alpha=.6;
            cell1.nameLabel.sd_layout
            .rightSpaceToView(cell1,15)
            .widthIs(ScreenWidth-30)
            .autoHeightRatio(0);
            
        }else if (indexPath.row==2) {
            cell1.nameLabel.textColor=DAO_COLOR;
        }
        
        
        return cell1;
    }else{
       
        XiangCeTableViewCell * cell3 =[XiangCeTableViewCell cellWithTableView:_tableView CellID:@"Cell3"];
        cell3.backgroundColor=[UIColor whiteColor];
        NSMutableArray * daArr =[NSMutableArray new];
        if (_photoArray.count!=0) {
            [daArr addObject:_photoArray];
        }
        if (_vivtoArray.count!=0) {
            [daArr addObject:_vivtoArray];
        }
        
        if (daArr.count!=0) {
            cell3.dataArr=daArr;
        }
        [self didPhotoYuLan:cell3];//点击图片预览
        [self moreBtn:cell3];//点击查看更多
        return cell3;
    }
    
    
   
}
#pragma mark--点击查看更多(相册、视频)
-(void)moreBtn:(XiangCeTableViewCell*)cell{
    cell.moreBtnBlock=^(UIButton * btn){
        //照片
        PhotoViewController * vc =[PhotoViewController new];
        vc.numTag=2;
        vc.phoneNum=_accountPhone;
        vc.tagg=btn.tag+1;//1相册，2视频
        [self.navigationController pushViewController:vc animated:YES];
        
    };
    
    
}
#pragma mark --点击图片放大预览
-(void)didPhotoYuLan:(XiangCeTableViewCell*)cell {
    cell.IndePathBlock=^(NSIndexPath*indepath){
        if (indepath.section==0) {
            //图片
            /*
             tagg==1说明，数组中存的是url
             tagg==2说明，数组中存的是image,
             */
            PhotoYuLanView * vc =[[PhotoYuLanView alloc]initWithFangDa:_photoArray NSindex:indepath.row Tagg:1];
            __weak __typeof(vc)weakSelf = vc;
            vc.dissBlock=^(){
                [weakSelf dissmiss];
            };
            [vc show];
        }else
        {
            //视频
            NSURL *movieUrl = [NSURL URLWithString:_vivtoArray[indepath.row]];
            [[UIApplication sharedApplication] openURL:movieUrl];
        }
        
        
        
    };
    
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (_lastBtn.tag==0) {
        if (indexPath.row==0) {
         return [ToolClass HeightForText:_dataArray[0] withSizeOfLabelFont:15 withWidthOfContent:ScreenWidth-30];
        }else if (indexPath.row==3){
            return [ToolClass HeightForText:_dataArray[3] withSizeOfLabelFont:15 withWidthOfContent:ScreenWidth-30] +30;
        }
        else {
            return  44;
        }
        
        
        
    }else{
        if (indexPath.row==0) {
          return  ScreenHight-216-44-44-34;;
        }
       return 44;
    }
    
    
    
//    if (indexPath.row==0) {
//        
//        if (_lastBtn.tag==0) {
//             return [ToolClass HeightForText:_dataArray[0] withSizeOfLabelFont:15 withWidthOfContent:ScreenWidth-30];
//            
//        }
//        else{
//            return  ScreenHight-216-44-44-34;;
//        }
//    
//            
//    }else{
//        return 44;
//    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (indexPath.row==2) {
        NSString * str= [NSString stringWithFormat:@"拨打：%@",_dataArray[2]];
        UIAlertController * actionView =[UIAlertController alertControllerWithTitle:@"" message:str preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * action1 =[UIAlertAction actionWithTitle:@"是" style:0 handler:^(UIAlertAction * _Nonnull action) {
            [ToolClass tellPhone:str];
        }];
        UIAlertAction * action2 =[UIAlertAction actionWithTitle:@"否" style:0 handler:nil];
        [actionView addAction:action2];
        [actionView addAction:action1];
        [self presentViewController:actionView animated:YES completion:nil];
    }
    
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{//84 161 246
    UIView * headView =[UIView new];
    headView.backgroundColor=COLOR;
    UIView * linView =[UIView new];
    linView.backgroundColor=[UIColor whiteColor];//JXColor(84, 161, 246, 1);
    [headView sd_addSubviews:@[linView]];
    linView.sd_layout
    .centerYEqualToView(headView)
    .centerXEqualToView(headView)
    .heightIs(40)
    .widthIs(2);
    
    NSArray * imageArr=@[@"ycgs_jj",@"gsjj_al_click"];
    NSArray * seleteImageArr=@[@"ycgs_jj_click",@"ycgs_al"];
    int d =(ScreenWidth-87*2)/3;
    for (int i =0 ;i<2;i++) {
        UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundImage:[UIImage imageNamed:imageArr[i]] forState:0];
        [btn setBackgroundImage:[UIImage imageNamed:seleteImageArr[i]] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(buttonClink:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag=i;
        
        if (_lastBtn.tag==1) {
            if (i==1) {
                btn.selected=YES;
                _lastBtn=btn;
            }
        }else{
            if (i==0) {
                btn.selected=YES;
                _lastBtn=btn;
            }
        }
        
        [headView sd_addSubviews:@[btn]];
        btn.sd_layout
        .leftSpaceToView(headView,d+(d+87)*i)
        .centerYEqualToView(headView)
        .widthIs(87)
        .heightIs(17);
    }
    
    
    return headView;
}
#pragma mark --演出公司 演出案例 切换按钮
-(void)buttonClink:(UIButton*)btn{
    _lastBtn.selected=NO;
    btn.selected=YES;
    _lastBtn=btn;
    [_tableView reloadData];
}

















//#pragma mark --初始化
//-(void)CreatView{
//    [self CreatImageView];
//    [self setupChildViewController];
//    self.titles = @[@"公司简介",@"成功案例"];
//    self.topTitleView = [SGTopTitleView topTitleViewWithFrame:CGRectMake(20, 64+216-22,ScreenWidth-40, 44)];
//    _topTitleView.layer.cornerRadius=5;
//    _topTitleView.clipsToBounds=YES;
//    _topTitleView.staticTitleArr = [NSArray arrayWithArray:_titles];
//    _topTitleView.backgroundColor=[UIColor whiteColor];
//    _topTitleView.delegate_SG = self;
//    [_bgView addSubview:_topTitleView];
//    // 创建底部滚动视图
//    self.mainScrollView = [[UIScrollView alloc] init];
//    _mainScrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
//    _mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width * _titles.count, 0);
//    _mainScrollView.backgroundColor = [UIColor clearColor];
//    // 开启分页
//    _mainScrollView.pagingEnabled = YES;
//    // 没有弹簧效果
//    _mainScrollView.bounces = NO;
//    // 隐藏水平滚动条
//    _mainScrollView.showsHorizontalScrollIndicator = NO;
//    // 设置代理
//    _mainScrollView.delegate = self;
//    
//    [_bgView addSubview:_mainScrollView];
//    
//    GongSiJianJieVC *oneVC = [[GongSiJianJieVC alloc] init];
//    oneVC.accountPhone=_accountPhone;
//    [self.mainScrollView addSubview:oneVC.view];
//    [self addChildViewController:oneVC];
//    [_bgView insertSubview:_mainScrollView belowSubview:_topTitleView];
//}
//
//
//#pragma mark --创建图片标题
//-(void)CreatImageView{
//    UIImageView * headImage =[UIImageView new];
//    //headImage.image=_titleImage;
//    [headImage sd_setImageWithURL:[NSURL URLWithString:_titleImage] placeholderImage:[UIImage imageNamed:@"messege_bg"]];
//    [_bgView sd_addSubviews:@[headImage]];
//    headImage.sd_layout
//    .centerXEqualToView(_bgView)
//    .topSpaceToView(_bgView,54)
//    .widthIs(ScreenWidth)
//    .heightIs(216);
//    
//    
//    
//    
//}
//#pragma mark - - - SGTopScrollMenu代理方法
//- (void)SGTopTitleView:(SGTopTitleView *)topTitleView didSelectTitleAtIndex:(NSInteger)index{
//    
//    // 1 计算滚动的位置
//    CGFloat offsetX = index * self.view.frame.size.width;
//    self.mainScrollView.contentOffset = CGPointMake(offsetX, 0);
//    
//    // 2.给对应位置添加对应子控制器
//    [self showVc:index];
//}
//// 显示控制器的view
//- (void)showVc:(NSInteger)index {
//    
//    CGFloat offsetX = index * self.view.frame.size.width;
//    
//    UIViewController *vc = self.childViewControllers[index];
//    
//    // 判断控制器的view有没有加载过,如果已经加载过,就不需要加载
//    if (vc.isViewLoaded) return;
//    
//    [self.mainScrollView addSubview:vc.view];
//    vc.view.frame = CGRectMake(offsetX, 0, self.view.frame.size.width, self.view.frame.size.height);
//}
//
//// 添加所有子控制器
//- (void)setupChildViewController {
//    
//    GongSiJianJieVC *oneVC = [[GongSiJianJieVC alloc] init];
//     oneVC.accountPhone=_accountPhone;
//    [self addChildViewController:oneVC];
//    
//    
//    SuccessAnLiViC *twoVC = [[SuccessAnLiViC alloc] init];
//     twoVC.accountPhone=_accountPhone;
//    [self addChildViewController:twoVC];
//    
//}
//
//
//#pragma mark - UIScrollViewDelegate
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    
//    // 计算滚动到哪一页
//    NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
//    
//    // 1.添加子控制器view
//    [self showVc:index];
//    
//    // 2.把对应的标题选中
//    UILabel *selLabel = self.topTitleView.allTitleLabel[index];
//    
//    // 3.滚动时，改变标题选中
//    [self.topTitleView staticTitleLabelSelecteded:selLabel];
//    
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
#pragma mark --导航条创建
-(void)daohangTiao{
    self.navigationController.navigationBar.barTintColor=DAO_COLOR;
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=_titleName;
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
