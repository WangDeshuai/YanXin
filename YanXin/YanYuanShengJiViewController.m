//
//  YanYuanShengJiViewController.m
//  YanXin
//
//  Created by mac on 16/4/11.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "YanYuanShengJiViewController.h"
#import "ZJAlertListView.h"

@interface YanYuanShengJiViewController ()<ZJAlertListViewDelegate,ZJAlertListViewDatasource,UITextViewDelegate>
{
     NSMutableArray * dataArr;
    UIButton * biaoqian;
    UITextView * jianjieText ;
    UITextView * jingliText;
    
}
@end

@implementation YanYuanShengJiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"升级演员";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:biaoti]}];
    
    [ShuJuModel  huoquyanyuanWihBiaoQian:@"0" success:^(NSDictionary *dic) {
        NSMutableArray * remenAr=[[NSMutableArray alloc]init];
        NSMutableArray *numberAr=[[NSMutableArray alloc]init];
        NSMutableArray * contentDic = [dic objectForKey:@"content"];
        for (NSDictionary * d in contentDic ) {
            [remenAr addObject:[d objectForKey:@"categoryname"]];
            [numberAr addObject:[d objectForKey:@"num"]];
           
        }
        [[NSUserDefaults standardUserDefaults] setObject:remenAr forKey:@"bq"];
        [[NSUserDefaults standardUserDefaults] setObject:numberAr forKey:@"num"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    } error:^(NSError *error) {
        
    }];
    UILabel * biaoq =[UILabel new];
    biaoq.text=@"  标签:";
    //左按钮
    UIButton*backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(5,27, 35, 35);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"goback_back_orange_on"] forState:0];
    [backBtn addTarget:self action:@selector(backClink) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBtn =[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem=leftBtn;

    
    biaoqian =[UIButton buttonWithType:UIButtonTypeCustom];
   // biaoqian.layer.borderWidth=1;
    [biaoqian addTarget:self action:@selector(biaoqiansa) forControlEvents:UIControlEventTouchUpInside];
    [biaoqian setTitleColor:[UIColor colorWithRed:76/255.0 green:76/255.0 blue:76/255.0 alpha:1] forState:0];
    biaoqian.titleLabel.font=[UIFont systemFontOfSize:15];
    biaoqian.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
    [biaoqian setTitle:@"选择" forState:0];
    biaoqian.titleEdgeInsets=UIEdgeInsetsMake(0, 0, 0, 10);
    
    UILabel * labeljianjie =[UILabel new];
    labeljianjie.backgroundColor= [UIColor colorWithRed:76/255.0 green:76/255.0 blue:76/255.0 alpha:.1];
    labeljianjie.text=@"  个人简介(必填)";
  
    jianjieText =[UITextView new];
    jianjieText.delegate=self;
    jianjieText.tag=10;
    jianjieText.font=[UIFont systemFontOfSize:15];
    jianjieText.textColor=[UIColor colorWithRed:76/255.0 green:76/255.0 blue:76/255.0 alpha:.5];
    jianjieText.text=@"可填写自己的特长,优势及参与的演艺活动....";
    
    UILabel * labeljingli =[UILabel new];
    labeljingli.text=@"  演艺经历(必填)";
    labeljingli.backgroundColor= [UIColor colorWithRed:76/255.0 green:76/255.0 blue:76/255.0 alpha:.1];
    
    
    jingliText =[UITextView new];
    jingliText.font=[UIFont systemFontOfSize:15];
    jingliText.tag=11;
    jingliText.textColor=[UIColor colorWithRed:76/255.0 green:76/255.0 blue:76/255.0 alpha:.5];
    jingliText.text=@"可填写自己参演的作品或获得的奖项....";
    jingliText.delegate=self;
    
    UIButton * saveBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    saveBtn.backgroundColor=[UIColor colorWithRed:38/255.0 green:182/255.0 blue:240/255.0 alpha:1];
    [saveBtn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    [saveBtn setTitle:@"保存" forState:0];
    
    UIView * linView =[UIView new];
    linView.backgroundColor=[UIColor colorWithRed:76/255.0 green:76/255.0 blue:76/255.0 alpha:.4];
    
    
    
    [self.view sd_addSubviews:@[biaoq,biaoqian,labeljianjie,labeljingli,jianjieText,jingliText,saveBtn,linView]];
    
    biaoq.sd_layout
    .leftSpaceToView(self.view,0)
    .autoWhiteRatio(0)
    .heightIs(30)
    .topSpaceToView(self.view,84);
    
    biaoqian.sd_layout
    .topEqualToView(biaoq)
    .leftSpaceToView(biaoq,5)
    .rightSpaceToView(self.view,15)
    .heightIs(30);
    
    
    labeljianjie.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .heightIs(35)
    .topSpaceToView(biaoqian,5);

  jianjieText.sd_layout
    .leftSpaceToView(self.view,10)
    .rightSpaceToView(self.view,5)
    .topSpaceToView(labeljianjie,0)
    .heightIs(120);
    
    labeljingli.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .heightIs(35)
    .topSpaceToView(jianjieText,0);
    
    jingliText.sd_layout
    .leftSpaceToView(self.view,10)
    .rightSpaceToView(self.view,5)
    .topSpaceToView(labeljingli,0)
    .heightIs(120);
    
    linView.sd_layout
    .leftSpaceToView(self.view,5)
    .rightSpaceToView(self.view,5)
    .heightIs(1)
    .topSpaceToView(jingliText,0);

    
    saveBtn.sd_layout
    .leftSpaceToView(self.view,10)
    .rightSpaceToView(self.view,10)
    .heightIs(30)
    .topSpaceToView(linView,20);
    

}
-(void)backClink
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)textViewDidBeginEditing:(UITextView*)textView
{
    if(textView.tag==10){
        if ([textView.text isEqualToString:@"可填写自己的特长,优势及参与的演艺活动...."])
        {
            textView.text=@"";
            textView.textColor=[UIColor blackColor];
        }
    
    }else if (textView.tag==11){
        if ([textView.text isEqualToString:@"可填写自己参演的作品或获得的奖项...."])
        {
            textView.text=@"";
            textView.textColor=[UIColor blackColor];
        }
    }
    
}
-(void)textViewDidEndEditing:(UITextView*)textView{
    
    if (textView.tag==10) {
        if(textView.text.length<1){
            textView.text=@"可填写自己的特长,优势及参与的演艺活动....";
            textView.textColor=[UIColor colorWithRed:76/255.0 green:76/255.0 blue:76/255.0 alpha:.5];
        }
    }else{
        if(textView.text.length<1){
            textView.text=@"可填写自己参演的作品或获得的奖项....";
            textView.textColor=[UIColor colorWithRed:76/255.0 green:76/255.0 blue:76/255.0 alpha:.5];
        }
        
        
    }
    
    


}



-(void)save
{
    if (jianjieText.text==nil || jingliText.text==nil ) {
        NSLog(@"输入信息为空");
    }else{
        
        NSString * bq =[NSString stringWithFormat:@"%ld",(long)self.selectedIndexPath.row];
        [ShuJuModel shengjibiaoqian:bq introduction:jianjieText.text experience:jingliText.text success:^(NSDictionary *dic) {
            NSString * code1 =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
            if ([code1 isEqualToString:@"1"]) {
                 [WINDOW showHUDWithText:@"升级成功,请等待审核" Type:ShowPhotoYes Enabled:YES];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [WINDOW showHUDWithText:[dic objectForKey:@"msg"] Type:ShowPhotoNo Enabled:YES];
            }
            
            
        } error:^(NSError *error) {
            
        }];
        
    }
   
    
    
    
}
-(void)biaoqiansa
{
  dataArr= [[NSUserDefaults standardUserDefaults] objectForKey:@"bq"];
    ZJAlertListView *alertList1 = [[ZJAlertListView alloc]initWithFrame:CGRectMake(0, 0, 250, 300)];
    alertList1.titleLabel.text = @"请选择您的职业";
    alertList1.datasource = self;
    alertList1.delegate = self;
    
    [alertList1 setDoneButtonWithBlock:^{
        NSIndexPath *selectedIndexPath = self.selectedIndexPath;
        
        [biaoqian setTitle:dataArr[selectedIndexPath.row] forState:0];
        [biaoqian setTitleColor:[UIColor blackColor] forState:0];
//        text2=dataArr[selectedIndexPath.row];
        [alertList1 dismiss];
    }];
    [alertList1 show];

}

#pragma mark -设置行数标签的选择
- (NSInteger)alertListTableView:(ZJAlertListView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArr.count;
}

- (UITableViewCell *)alertListTableView:(ZJAlertListView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableAlertListCellWithIdentifier:identifier];
    
    if (nil == cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if ( self.selectedIndexPath && NSOrderedSame == [self.selectedIndexPath compare:indexPath])
    {
        cell.imageView.image = [UIImage imageNamed:@"dx_checkbox_red_on"];
    }
    else
    {
        cell.imageView.image = [UIImage imageNamed:@"dx_checkbox_off"];
    }
    cell.textLabel.text=dataArr[indexPath.row];
    
    return cell;
}

- (void)alertListTableView:(ZJAlertListView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView alertListCellForRowAtIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:@"dx_checkbox_off"];
}

- (void)alertListTableView:(ZJAlertListView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedIndexPath = indexPath;
    UITableViewCell *cell = [tableView alertListCellForRowAtIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:@"dx_checkbox_red_on"];
}










-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view  endEditing:YES];
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
