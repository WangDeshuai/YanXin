//
//  TouSu1.m
//  YanXin
//
//  Created by mac on 16/5/25.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "TouSu1.h"

@interface TouSu1 ()

{
    UITextView * xiangxi;
    UITextField * nameText;
    UITextField * phoneText;
}
@property(nonatomic,retain)UIScrollView * bgscroller;
@end

@implementation TouSu1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"投诉";
    self.view.backgroundColor=[UIColor whiteColor];
    UIButton*backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(5,27, 35, 35);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"goback_back_orange_on"] forState:0];
    [backBtn addTarget:self action:@selector(backClink) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBtn =[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem=leftBtn;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:biaoti]}];
    
    _bgscroller=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, KUAN, GAO)];
    _bgscroller.backgroundColor=[UIColor whiteColor];
    _bgscroller.contentSize=CGSizeMake(KUAN, GAO+100);
    [self.view addSubview:_bgscroller];
    UITapGestureRecognizer * tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    [_bgscroller addGestureRecognizer:tap];
    [self view1];
}
-(void)backClink{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)tap
{
    [_bgscroller endEditing:YES];
}
-(void)view1
{
    UILabel * label1 =[UILabel new];
    label1.alpha=.7;
    label1.font=[UIFont systemFontOfSize:15];
    label1.text=@"      如果您在该款APP中发现不良信息，例如：色情、骚扰、暴力恐怖、谣言、骗钱违禁品等违法行为，请在下面填上发布信息人的手机号与姓名，我们将进行核实,如核实正确，我们将对其作出相应的处分";
    [_bgscroller sd_addSubviews:@[label1]];
    
    label1.sd_layout
    .topSpaceToView(_bgscroller,30)
    .leftSpaceToView(_bgscroller,40)
    .rightSpaceToView(_bgscroller,40)
    .autoHeightRatio(0);
    
    UILabel * nameLabel =[UILabel new];
    nameLabel.text=@"姓  名:";
    UILabel * phoneNumber =[UILabel new];
    phoneNumber.text=@"手机号:";
    
    nameText =[UITextField new];
    nameText.placeholder=@"请输入姓名";
    nameText.backgroundColor=[UIColor grayColor];
    phoneText =[UITextField new];
    phoneText.placeholder=@"请输入手机号";
    phoneText.backgroundColor=[UIColor grayColor];
    nameText.alpha=.5;
    phoneText.alpha=.5;
    
    UILabel *xiangxilable =[UILabel new];
    xiangxilable.text=@"不良信息详细描述:";
    xiangxi= [UITextView new];
    xiangxi.backgroundColor=[UIColor grayColor];
    xiangxi.alpha=.5;
    xiangxi.text=@"请您描述详细信息....";
    [_bgscroller sd_addSubviews:@[nameLabel,nameText,phoneNumber,phoneText,xiangxilable,xiangxi]];
    
    nameLabel.sd_layout
    .topSpaceToView(label1,30)
    .leftEqualToView(label1)
    .widthIs(50)
    .heightIs(30);
    
    nameText.sd_layout
    .topEqualToView(nameLabel)
    .leftSpaceToView(nameLabel,20)
    .rightEqualToView(label1)
    .heightIs(30);
    
    
    phoneNumber.sd_layout
    .leftEqualToView(nameLabel)
    .topSpaceToView(nameLabel,20)
    .widthIs(60)
    .heightIs(30);
   
    phoneText.sd_layout
    .leftEqualToView(nameText)
    .topSpaceToView(nameText,20)
    .rightEqualToView(label1)
    .heightIs(30);
    
    xiangxilable.sd_layout
    .topSpaceToView(phoneNumber,20)
    .leftEqualToView(label1)
    .rightEqualToView(label1)
    .autoHeightRatio(0);
    
    xiangxi.sd_layout
    .leftEqualToView(label1)
    .rightEqualToView(label1)
    .heightIs(100)
    .topSpaceToView(xiangxilable,5);
    
    
    UIButton * button = [UIButton new];
    button.backgroundColor=[UIColor redColor];
    [button addTarget:self action:@selector(tousu:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"确认投诉" forState:0];
    [_bgscroller sd_addSubviews:@[button]];

     button.sd_layout
    .leftEqualToView(label1)
    .rightEqualToView(label1)
    .topSpaceToView(xiangxi,20)
    .heightIs(30);

    
    UILabel * zhuyi =[UILabel new];
    zhuyi.alpha=.9;
    zhuyi.textColor=[UIColor grayColor];
    zhuyi.font=[UIFont systemFontOfSize:14];
    zhuyi.text=@"注意:\n1.在演员详情页面可以查看到用户的手机号和姓名\n2.如果经过信息核实，发现你举报的用户没有违规行为，你将受到相应的处分\n3.请认真对待投诉事件，避免乱投、瞎投等恶略行为\4.你的投诉行为应基于善意，并代表你本人真实意思，与其它无关。";
    [_bgscroller sd_addSubviews:@[zhuyi]];
    
    zhuyi.sd_layout
    .bottomSpaceToView(_bgscroller,50)
    .leftSpaceToView(_bgscroller,10)
    .rightSpaceToView(_bgscroller,10)
    .autoHeightRatio(0);

}
-(void)tousu:(UIButton*)button
{
    UIAlertController * alert =[UIAlertController alertControllerWithTitle:@"提示" message:nil preferredStyle:UIAlertControllerStyleAlert];
   
    UIAlertAction * qq =[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        nameText.text=@"";
        phoneText.text=@"";
        xiangxi.text=@"请您描述详细信息....";

    }];
    
    [alert addAction:qq];
    
    if ( [nameText.text isEqualToString:@""] ||[phoneText.text isEqualToString:@""]) {
        NSLog(@"请填写完嘻嘻");
        alert.message=@"请填写完信息在提交";
        [self presentViewController:alert animated:YES completion:nil];
        
    }else{
        alert.message=@"感谢您的投诉\n我们将对您投诉的信息进行审核";
        [self presentViewController:alert animated:YES completion:nil];
        
        
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

@end
