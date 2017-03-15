//
//  YuDingYanChuVC.m
//  YanXin
//
//  Created by Macx on 17/2/15.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "YuDingYanChuVC.h"
#import "YuDingYanChuCell.h"
#import "WHUCalendarPopView.h"
#import "ChooseCityViewController1.h"
@interface YuDingYanChuVC ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextViewDelegate,UITextFieldDelegate>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSArray * titleArr;
@property(nonatomic,strong)  WHUCalendarPopView*   pop;
@property (nonatomic,copy)NSString *timeRiQi;
@property(nonatomic,strong)UIImage * image1;

@end

@implementation YuDingYanChuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self daohangTiao];
    [self CreatArr];
    [self CreatTabelView];
    [self CreatCommBtn];
   
}

-(void)CreatArr{
    NSArray * arr1 =@[@"演出时间:",@"演出城市:",@"详细地址:"];
    NSArray * arr2 =@[@"演出主题:",@"演出要求:"];
    NSArray * arr3 =@[@"联  系  人:",@"联系方式:"];
    NSArray * arr4 =@[@"主题图片:\n(选     填)"];
    
   
    
    _titleArr=@[arr1,arr2,arr3,arr4];
}
#pragma mark --创建按钮
-(void)CreatCommBtn{
    UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
   // btn.backgroundColor=[UIColor redColor];
    btn.frame=CGRectMake((ScreenWidth-590/2)/2, ScreenHight-64-40, 590/2, 66/2);
    [btn addTarget:self action:@selector(commontBtn) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"立即预定" forState:0];
    [btn setBackgroundImage:[UIImage imageNamed:@"圆角矩形-按钮.png"] forState:0];
    [_tableView addSubview:btn];
}
#pragma mark --创建表
-(void)CreatTabelView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHight) style:UITableViewStylePlain];
    }
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.backgroundColor=COLOR;
    _tableView.keyboardDismissMode=UIScrollViewKeyboardDismissModeOnDrag;
    _tableView.tableFooterView=[UIView new];
    [self.view addSubview:_tableView];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _titleArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_titleArr[section] count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    YuDingYanChuCell * cell =[YuDingYanChuCell cellWithTableView:_tableView CellID:@"Cell"];
    cell.titlelabel.text=_titleArr[indexPath.section][indexPath.row];
    if (indexPath.section==0) {
        
        cell.textfield.hidden=YES;
        if (indexPath.row==0) {
            //演出时间
            cell.seleteBtn.hidden=NO;
           
           
          
            [cell.seleteBtn addTarget:self action:@selector(timeBtn:) forControlEvents:UIControlEventTouchUpInside];
            if (_timeRiQi==nil) {
                 [cell.seleteBtn setTitle:@"请选择您的演出时间" forState:0];
                cell.seleteBtn.titleLabel.font=[UIFont systemFontOfSize:16];
                [cell.seleteBtn setTitleColor:[UIColor lightGrayColor] forState:0];
            }else{
               [cell.seleteBtn setTitle:_timeRiQi forState:0];  
            }
           
        }else if (indexPath.row==1){
            cell.seleteBtn.hidden=NO;
            //演出城市
           
             [cell.seleteBtn addTarget:self action:@selector(cityBtn:) forControlEvents:UIControlEventTouchUpInside];
            cell.seleteBtn.titleLabel.font=[UIFont systemFontOfSize:16];
                       NSString *sheng=[[NSUserDefaults standardUserDefaults]objectForKey:@"shengyu"];
            NSString*shi= [[NSUserDefaults standardUserDefaults]objectForKey:@"shiyu"];
            if ([[NSUserDefaults standardUserDefaults]objectForKey:@"xianyu"]) {
                
                NSString * string = [NSString stringWithFormat:@"%@%@%@",sheng,shi,[[NSUserDefaults standardUserDefaults]objectForKey:@"xianyu"]];
                [ cell.seleteBtn setTitle:string forState:0];
                [ cell.seleteBtn setTitleColor:[UIColor blackColor] forState:0];
            }else{
                [cell.seleteBtn setTitle:@"请选择您的演出城市" forState:0];
                [cell.seleteBtn setTitleColor:[UIColor lightGrayColor] forState:0];

            }
            
        }else{
            cell.textfield.hidden=NO;
            cell.textfield.placeholder=@"请填写您的详细地点";
            
        }
     
        
    }else if (indexPath.section==1){
        cell.textfield.hidden=YES;
        cell.textView.hidden=NO;
        cell.textView.delegate=self;
        if (indexPath.row==0) {
            //演出主题
            cell.textView.text=@"请填写您的演出主题...";
            cell.textView.textColor=[UIColor lightGrayColor];
            cell.textView.tag=10;
        }else if (indexPath.row==1){
            //演出要求
            cell.textView.text=@"请填写您的演出要求....";
            cell.textView.tag=11;
            cell.textView.textColor=[UIColor lightGrayColor];
        }
        
        
    }else if (indexPath.section==2){
         cell.textView.hidden=YES;
        cell.textfield.delegate=self;
        if (indexPath.row==0) {
            //联系人
            cell.textfield.placeholder=@"请填写联系人的姓名";
            cell.textfield.tag=1;
        }else{
            //联系电话
             cell.textfield.placeholder=@"请填写联系人的电话";
            cell.textfield.tag=2;

        }
        
    }else if (indexPath.section==3) {
        cell.textView.hidden=YES;
        cell.textfield.hidden=YES;
        [cell sd_addSubviews:@[cell.seleteBtn]];
        cell.seleteBtn.hidden=NO;
        if (_image1==nil) {
             [cell.seleteBtn setBackgroundImage:[UIImage imageNamed:@"加号.png"] forState:0];
        }else{
             [cell.seleteBtn setBackgroundImage:_image1 forState:0];
        }
       
        cell.seleteBtn.sd_layout.widthIs(60).heightIs(60).rightSpaceToView(cell,ScreenWidth-170);
        [cell.seleteBtn addTarget:self action:@selector(imagePhoto) forControlEvents:UIControlEventTouchUpInside];
    }
    
   
    return cell;
}
-(void)viewWillAppear:(BOOL)animated
{
    [_tableView reloadData];
}
#pragma mark --选择日期时间的
-(void)timeBtn:(UIButton*)btn{
   
    _pop=[[WHUCalendarPopView alloc] init];
    __weak typeof(self)weakSelf=self;
   
    _pop.onDateSelectBlk=^(NSDate* date){
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd"];
        
        double shijianCha =[[NSDate date] timeIntervalSinceDate:date];
        int myInt = (int)shijianCha/60/60/24;
        if (myInt<0||myInt==0) {
            NSString *dateString = [format stringFromDate:date];
            _timeRiQi=dateString;
            
            [btn setTitle:dateString forState:0];
            [btn setTitleColor:[UIColor blackColor] forState:0];
        }else
        {
            
            UIAlertController * alerview =[UIAlertController alertControllerWithTitle:@"温馨提示" message:@"不能选择今天之前的日期" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction * queren =[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alerview addAction:queren];
            [weakSelf presentViewController:alerview animated:YES completion:nil];
        }
        
        
    };
     [_pop show];

}
#pragma mark --演出城市
-(void)cityBtn:(UIButton*)btn{
    ChooseCityViewController1 * vc =nil;
    vc.hidesBottomBarWhenPushed=YES;
    
    if (vc==nil) {
        vc=[ChooseCityViewController1 new];
        vc.yuyuebtn=@"yuyue";
    }
    [self.navigationController pushViewController:vc animated:YES];


   


}

#pragma mark --选择照片的
-(void)imagePhoto{
    UIImagePickerController *controller = [[UIImagePickerController alloc]init];
    controller.delegate = self;
    controller.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    controller.allowsEditing = YES;
    
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    _image1=image;
   
    [self dismissViewControllerAnimated:YES completion:nil];
    [_tableView reloadData];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker;
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 0;
    }else {
     return 5;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==1) {
        return 120;
    }else if (indexPath.section==3){
        return 70;
    }
    else{
        return 44;
    }
}

#pragma mark --提交按钮
-(void)commontBtn{
   
    NSLog(@"类型%@", [NSString stringWithFormat:@"%lu",_number+1]);
    NSLog(@"演出时间是>>%@",_timeRiQi);
    //演出地点
    YuDingYanChuCell * cell2 =[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    //演出主题
     YuDingYanChuCell * cell3 =[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    //演出要求
    YuDingYanChuCell * cell4 =[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]];
    //联系人
    YuDingYanChuCell * cell5 =[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
    //电话
     YuDingYanChuCell * cell6 =[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:2]];
     NSData * data =UIImageJPEGRepresentation(_image1, 0);
    NSLog(@"演出地点%@",cell2.textfield.text);
    NSLog(@"演出主题%@",cell3.textView.text);
    NSLog(@"演出要求%@",cell4.textView.text);
     NSLog(@"联系人%@",cell5.textfield.text);
     NSLog(@"电话%@",cell6.textfield.text);
    [LCProgressHUD showLoading:@"请稍后..."];
    [ShuJuModel saveYuDingMyMessageWithTime:[ToolClass isString:_timeRiQi] Address:[ToolClass isString:cell2.textfield.text] zhuTi:[ToolClass isString:cell3.textView.text] YaoQiu:[ToolClass isString:cell4.textView.text] Name:[ToolClass isString:cell5.textfield.text] Phone:[ToolClass isString:cell6.textfield.text] Type:[NSString stringWithFormat:@"%lu",_number+1] Image:data success:^(NSDictionary *dic) {
        [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
         NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"1"]) {
            [self.navigationController popViewControllerAnimated:YES];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"xianyu"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"shiyu"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"shengyu"];
            [[NSUserDefaults standardUserDefaults]synchronize];
        }
        
    } error:^(NSError *error) {
        
    }];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




-(void)textViewDidBeginEditing:(UITextView*)textView
{
    if(textView.tag==10){
        if ([textView.text isEqualToString:@"请填写您的演出主题..."])
        {
            textView.text=@"";
            textView.textColor=[UIColor blackColor];
        }
        
    }else if (textView.tag==11){
        if ([textView.text isEqualToString:@"请填写您的演出要求...."])
        {
            textView.text=@"";
            textView.textColor=[UIColor blackColor];
        }
    }
    
}
-(void)textViewDidEndEditing:(UITextView*)textView{
    
    if (textView.tag==10) {
        if(textView.text.length<1){
            textView.text=@"请填写您的演出主题...";
            textView.textColor=[UIColor colorWithRed:76/255.0 green:76/255.0 blue:76/255.0 alpha:.5];
        }
    }else{
        if(textView.text.length<1){
            textView.text=@"请填写您的演出要求....";
            textView.textColor=[UIColor colorWithRed:76/255.0 green:76/255.0 blue:76/255.0 alpha:.5];
        }
        
        
    }
    
    
}
#pragma mark --文本框代理
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if(textField.tag==1){
        [UIView animateWithDuration:.3 animations:^{
            _tableView.contentOffset=CGPointMake(0, 160);
            
        }];
    }else if (textField.tag==2){
        [UIView animateWithDuration:.3 animations:^{
            _tableView.contentOffset=CGPointMake(0, 180);
        }];
    }
    //
    
    
    
    return YES;
}
#pragma mark --导航条创建
-(void)daohangTiao{
    self.navigationController.navigationBar.barTintColor=DAO_COLOR;
    self.view.backgroundColor=COLOR;
    if (_number==0) {
         self.title=@"预定演出";
    }else if (_number==1){
         self.title=@"预定演员";
    }else if (_number==2){
         self.title=@"预定设备";
    }
   
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
