//
//  PhotoViewController.m
//  YanXin
//
//  Created by Macx on 17/1/19.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "PhotoViewController.h"
#import "AddImageCCell.h"
#import "SGImagePickerController.h"//相片选择
#import "UpDownVidioVC.h"
#import "PhotoYuLanView.h"
static NSString *headerViewIdentifier = @"hederview";
@interface PhotoViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)NSMutableArray * photoArray;
@property(nonatomic,strong)UICollectionView * collectionView;
@property(nonatomic,assign)int AAA;
@property (nonatomic, strong) MJRefreshComponent *myRefreshView;
@property(nonatomic,strong)NSMutableArray * upImageArr;//图片
@property(nonatomic,strong)NSMutableArray * vidioArr;//视频
@property(nonatomic,strong)NSMutableArray * iddArr;//用来删除的
@end

@implementation PhotoViewController

-(void)viewWillAppear:(BOOL)animated
{
    NSLog(@"输出看看%@>>>%@",_phoneNum,[NSUSE_DEFO objectForKey:@"username"]);
    if (_phoneNum==[NSUSE_DEFO objectForKey:@"username"]) {
        [self CreatUpDownBtn];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self daohangTiao];
    _dataArray=[NSMutableArray new];
    _iddArr=[NSMutableArray new];
    [self CreatCollectionView];
    
    
    


}

-(void)CreatUpDownBtn{
    UIButton * upImageBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    upImageBtn.layer.borderWidth=1;
    upImageBtn.layer.borderColor=DAO_COLOR.CGColor;
    upImageBtn.sd_cornerRadius=@(5);
    [upImageBtn addTarget:self action:@selector(shangUp) forControlEvents:UIControlEventTouchUpInside];
    [upImageBtn setTitleColor:DAO_COLOR forState:0];
    if (_tagg==1) {
       [upImageBtn setTitle:@"点击上传图片" forState:0];
    }else{
       [upImageBtn setTitle:@"点击上传视频" forState:0];
    }
   
    [_collectionView sd_addSubviews:@[upImageBtn]];
    upImageBtn.sd_layout
    .centerXEqualToView(_collectionView)
    .topSpaceToView(_collectionView,15)
    .widthIs(ScreenWidth-100)
    .heightIs(45);
    
}
#pragma mark --上传图片
-(void)shangUp{
    
    if (_tagg==1) {
        
        //就只需要这2步即可完成照片多选操作
        SGImagePickerController *picker = [[SGImagePickerController alloc] init];
        picker.maxCount = 4;
        [picker setDidFinishSelectImages:^(NSMutableArray *images)
         {
             NSLog(@"输出%lu",images.count);
             _upImageArr=images;
             for (UIImage *image in images) {
                 [_dataArray addObject:image];
             }
             _dataArray=(NSMutableArray *)[[_dataArray reverseObjectEnumerator] allObjects];
             [_collectionView reloadData];
         }];
        [self presentViewController:picker animated:YES completion:nil];
    }else{
        UpDownVidioVC * vc =[ UpDownVidioVC new];
        vc.imageArrBlock=^(NSMutableArray * array){
            _vidioArr=array;
            for (NSString * str in array) {
                UIImageView * imageview =[UIImageView new];
                [imageview sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"video_bg"]];
                
                [_dataArray addObject:imageview.image];
            }
            _dataArray=(NSMutableArray *)[[_dataArray reverseObjectEnumerator] allObjects];
            [_collectionView reloadData];
        };
        [self.navigationController pushViewController:vc animated:YES];
    }
   
    
}

#pragma mark --- 演员界面numTag==1 --获取相册(视频)
-(void)getPhotoDataPage:(NSString*)page{
    [Engine ChaKanYanYuanPhotoVitioAccount:_phoneNum Type:[NSString stringWithFormat:@"%lu",_tagg] Page:page PageNum:@"10" success:^(NSDictionary *dic) {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        NSMutableArray * array2 =[NSMutableArray new];
        if ([code isEqualToString:@"1"]) {
            NSArray * contentArr =[dic objectForKey:@"content"];
            for (NSDictionary * dicc in contentArr) {
                 NSString * urlStr =[ToolClass isString:[NSString stringWithFormat:@"%@",[dicc objectForKey:@"url"]]];
                NSString * idd =[ToolClass isString:[NSString stringWithFormat:@"%@",[dicc objectForKey:@"id"]]];
                [_iddArr addObject:idd];
                UIImageView * imageview =[UIImageView new];
                if (_tagg==1) {
                     [imageview sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"messege_bg"]];
                }else{
                     [imageview sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"video_bg"]];
                }
               
                [array2 addObject:imageview.image];
            }
            if (self.myRefreshView == _collectionView.header) {
                _dataArray = array2;
                _collectionView.footer.hidden = _dataArray.count==0?YES:NO;
            }else if(self.myRefreshView == _collectionView.footer){
                [_dataArray addObjectsFromArray:array2];
            }
            
             [_myRefreshView  endRefreshing];
            [_collectionView reloadData];
        }else
        {
             [_myRefreshView  endRefreshing];
            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
        }
    } error:^(NSError *error) {
         [_myRefreshView  endRefreshing];
    }];
}

#pragma mark --演出公司界面numTag==2 获取相册视频
-(void)getWangLuoQingQiuVidoPage:(NSString*)page{
    //Type:1演zhaop 2视频
    NSLog(@"%lu",_tagg);
    [Engine ChanKanYanShangAnLiAccount:_phoneNum Type:[NSString stringWithFormat:@"%lu",_tagg] Page:page PageNum:@"10" success:^(NSDictionary *dic) {
        
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"1"]) {
            NSArray * contentArr =[dic objectForKey:@"content"];
            NSMutableArray * array2 =[NSMutableArray new];
            for (NSDictionary * dicc in contentArr) {
                NSString * urlStr =[ToolClass isString:[NSString stringWithFormat:@"%@",[dicc objectForKey:@"case_url"]]];
                
                NSString * idd =[ToolClass isString:[NSString stringWithFormat:@"%@",[dicc objectForKey:@"id"]]];
                [_iddArr addObject:idd];
                
                UIImageView * imageview =[UIImageView new];
                if (_tagg==1) {
                    [imageview sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"messege_bg"]];
                }else{
                    [imageview sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"video_bg"]];
                }
                 [array2 addObject:imageview.image];
            }
        
            if (self.myRefreshView == _collectionView.header) {
                _dataArray = array2;
                _collectionView.footer.hidden = _dataArray.count==0?YES:NO;
            }else if(self.myRefreshView == _collectionView.footer){
                [_dataArray addObjectsFromArray:array2];
            }
            
            [_myRefreshView  endRefreshing];
            [_collectionView reloadData];
            
            
            
            
        } else
        {
            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
        }
        
    } error:^(NSError *error) {
        
    }];
}
-(void)CreatCollectionView{
    UICollectionViewFlowLayout * flowLawyou =[UICollectionViewFlowLayout new];
    int d =((ScreenWidth-20)-(5*2))/3;
    //item大小
    flowLawyou.itemSize = CGSizeMake(d, d);
    //行间距
    flowLawyou.minimumLineSpacing=5;//行间距
    flowLawyou.minimumInteritemSpacing=5;//列间距
    if (_phoneNum==[NSUSE_DEFO objectForKey:@"username"]) {
         flowLawyou.sectionInset = UIEdgeInsetsMake(10+65, 10, 10,10);
    }else{
         flowLawyou.sectionInset = UIEdgeInsetsMake(10, 10, 10,10);
    }
   
    //集合 表（视图）继承与 UIScrollView
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHight) collectionViewLayout:flowLawyou];
    _collectionView.pagingEnabled = NO;
    _collectionView.delegate = self;
    
    _collectionView.dataSource = self;
    //默认是黑色的，需要设置才能显示
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_collectionView];
    
    [_collectionView registerClass:[AddImageCCell class] forCellWithReuseIdentifier:@"cell"];
    
    
    //刷新操作
    __weak typeof (self) weakSelf =self;
    _collectionView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        NSLog(@"往下拉了");
        _AAA=1;
        weakSelf.myRefreshView = weakSelf.collectionView.header;
        if (_numTag==2) {
            [self getWangLuoQingQiuVidoPage:[NSString stringWithFormat:@"%d",_AAA]];
        }else{
          [self getPhotoDataPage:[NSString stringWithFormat:@"%d",_AAA]];
        }
        

    }];
    
    // 马上进入刷新状态
    [_collectionView.header beginRefreshing];
    //..上拉刷新
    _collectionView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.myRefreshView = weakSelf.collectionView.footer;
        NSLog(@"往上拉了加载更多");
        _AAA=_AAA+1;
        
        if (_numTag==2) {
            [self getWangLuoQingQiuVidoPage:[NSString stringWithFormat:@"%d",_AAA]];
        }else{
            [self getPhotoDataPage:[NSString stringWithFormat:@"%d",_AAA]];
        }
        
    }];
    _collectionView.footer.hidden = YES;
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return [_dataArray count];
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    AddImageCCell * cell= [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor=[UIColor magentaColor];
    cell.imageView.image=_dataArray[indexPath.row];
    cell.TapBlock=^(UILongPressGestureRecognizer * tapp){
        if (_phoneNum==[NSUSE_DEFO objectForKey:@"username"]) {
            if (tapp.state==UIGestureRecognizerStateBegan) {
                //删除的时候不不需要区分视频、图片，只要id
                NSLog(@"长按了%@",_iddArr[indexPath.row]);
                UIAlertController * actionView =[UIAlertController alertControllerWithTitle:@"温馨提示" message:@"是否确认删除" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction * action1 =[UIAlertAction actionWithTitle:@"是" style:0 handler:^(UIAlertAction * _Nonnull action) {
                    [LCProgressHUD showLoading:@"请稍后..."];
                    
                    [Engine deleteImageOrVivoID:_iddArr[indexPath.row] success:^(NSDictionary *dic) {
                        [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
                        NSLog(@"输出删除%@",_dataArray[indexPath.row]);
                        [_dataArray removeObject:_dataArray[indexPath.row]];
                        [_collectionView reloadData];
                    } error:^(NSError *error) {
                        
                    }];
                }];
                UIAlertAction * action2 =[UIAlertAction actionWithTitle:@"否" style:0 handler:nil];
                [actionView addAction:action2];
                [actionView addAction:action1];
                [self presentViewController:actionView animated:YES completion:nil];
                
            }
            
        }
      
        
        
    };
    return cell;
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //图片
    
    PhotoYuLanView * vc =[[PhotoYuLanView alloc]initWithFangDa:_dataArray NSindex:indexPath.row Tagg:2];
     __weak __typeof(vc)weakSelf = vc;
    vc.dissBlock=^(){
        [weakSelf dissmiss];
    };
    [vc show];
}

#pragma mark --右按钮上传
-(void)rightClick{
    if (_tagg==1) {
        //相册
       [self photoJsonStr]; 
    }else{
        //视频
       [self shiPinIntenextData];
    }
    
    
}
#pragma mark --图片转换字符串
-(void)photoJsonStr{
    if (_upImageArr.count==0) {
        [LCProgressHUD showMessage:@"没有选择照片"];
    }else{
        NSMutableArray * arrzhao =[NSMutableArray new];
        for (int i =0; i<_upImageArr.count; i++ ) {
            UIImage * image =_upImageArr[i];
            NSData * imgData=  UIImageJPEGRepresentation(image, 0);
            NSString * endStr =[imgData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
            [arrzhao addObject:endStr];
        }
        //上传照片获取地址
        [LCProgressHUD showLoading:@"请稍后..."];
        [Engine ShangChuanImageArrStr:[ToolClass getJsonStringFromObject:arrzhao] success:^(NSDictionary *dic) {
            
            NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
            if ([code isEqualToString:@"1"]) {
                //图片地址数组
                NSArray * contentArr =[dic objectForKey:@"content"];
                NSMutableArray * shangChuanPhoto =[NSMutableArray new];
                for (int i=0; i<contentArr.count; i++) {
                    NSString * imageName =[NSString stringWithFormat:@"img%d",i];
                    NSMutableDictionary * imageDic =[NSMutableDictionary new];
                    [imageDic setObject:imageName forKey:@"img_name"];
                    [imageDic setObject:contentArr[i] forKey:@"img_url"];
                    [shangChuanPhoto addObject:imageDic];
                }
                
                NSLog(@"输出图片格式%@",[ToolClass getJsonStringFromObject:shangChuanPhoto]);
                [LCProgressHUD showMessage:@"请稍后..."];
                [Engine ShangChuanImageStr:[ToolClass getJsonStringFromObject:shangChuanPhoto] success:^(NSDictionary *dic) {
                     [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
                    
                } error:^(NSError *error) {
                    
                }];
               
            }else
            {
                [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
            }
        } error:^(NSError *error) {
            
        }];
        
    }
    
    
    
    
    
    /*
     
     
     */
    
    
    
    
    
    
}
#pragma mark --视频转换字符串
-(void)shiPinIntenextData{
   // NSString * jsonVivo =nil;
    if (_vidioArr.count==0) {
        [LCProgressHUD showMessage:@"您还没有添加视频"];
    }else{
        
        NSMutableArray * shangChuanVidio =[NSMutableArray new];
        for (int i =0; i<_vidioArr.count; i++) {
            NSString * imageName =[NSString stringWithFormat:@"video%d",i];
            NSMutableDictionary * imageDic =[NSMutableDictionary new];
            [imageDic setObject:imageName forKey:@"video_name"];
            [imageDic setObject:_vidioArr[i] forKey:@"video_url"];
            [shangChuanVidio addObject:imageDic];
        }
        [LCProgressHUD showLoading:@"请稍后..."];
        [Engine shangChuanVivo:[ToolClass getJsonStringFromObject:shangChuanVidio] success:^(NSDictionary *dic) {
            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
        } error:^(NSError *error) {
            
        }];
    }
    
  
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
#pragma mark --导航条创建
-(void)daohangTiao{
    self.navigationController.navigationBar.barTintColor=DAO_COLOR;
    self.view.backgroundColor=COLOR;
    if (_tagg==1) {
        self.title=@"查看相册";
    }else{
        self.title=@"查看视频";
    }
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:biaoti]}];
    //返回按钮
    UIButton*backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(5,27, 35, 35);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"goback_back_orange_on"] forState:0];
    [backBtn addTarget:self action:@selector(backClink) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBtn =[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem=leftBtn;
    //右按钮
    if (_phoneNum==[NSUSE_DEFO objectForKey:@"username"]) {
        UIButton*right=[UIButton buttonWithType:UIButtonTypeCustom];
        right.frame=CGRectMake(5,27, 65, 35);
        [right setTitle:@"上传" forState:0];
        [right addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem * rightBtn =[[UIBarButtonItem alloc]initWithCustomView:right];
        self.navigationItem.rightBarButtonItem=rightBtn;
    }
   
}
-(void)backClink{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
