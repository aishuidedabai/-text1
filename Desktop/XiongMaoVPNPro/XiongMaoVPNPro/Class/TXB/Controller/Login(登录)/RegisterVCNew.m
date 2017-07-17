//
//  RegisterVCNew.m
//  易林Video
//
//  Created by beijingduanluo on 15/12/19.
//  Copyright © 2015年 beijingduanluo. All rights reserved.
//

#import "RegisterVCNew.h"
#import "SHInvoker.h"
@interface RegisterVCNew ()
{
    int timeCount;
    NSTimer*timer;
}
@property(nonatomic,strong)UILabel *tipLabel;
@property(nonatomic,strong)UIButton *loginBtnReturn;
@property(nonatomic,strong)UIImageView *backImgV;
@property(nonatomic,strong)UIImageView *backView;
@property(nonatomic,strong)UITextField *phoneTextField;
@property(nonatomic,strong)UIImageView *phoneImgV;
@property(nonatomic,strong)UITextField *passwordText;
@property(nonatomic,strong)UIImageView *passwordImgV;
@property(nonatomic,strong)UIButton *loginBtn;

@property(nonatomic,strong)UITextField *yanzhengTextF;
@property(nonatomic,strong)UIButton *huoquBtn;
@property(nonatomic,copy)NSString *registStr;

@end

@implementation RegisterVCNew

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    _backImgV =[UIImageView addImgWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) AndImage:@"ditu"];
    [self.view addSubview:_backImgV];
    _backImgV.userInteractionEnabled = YES;
    _backView =[UIImageView addImgWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) AndImage:@"zuizhongbanquan"];
    [self.view addSubview:_backView];
    _backView.userInteractionEnabled = YES;
    
    _loginBtnReturn =[UIButton addBtnImage:@"login_Return_Left" AndFrame:CGRectMake(20*Height, 30*Height, 25*Width, 25*Height) WithTarget:self action:@selector(returnLoginBtn)];
    [_backView addSubview:_loginBtnReturn];
    
    _phoneTextField =[self addtextFieldWithHeight:150 AndImgStr:nil AndStr:@"请输入手机号码"];
    _phoneTextField.keyboardType =UIKeyboardTypeNumberPad;
    [_backView addSubview:_phoneTextField];
    
    _passwordText =[self addtextFieldWithHeight:200 AndImgStr:nil AndStr:@"请输入密码"];
    [_backView addSubview:_passwordText];
    
    _loginBtn =[UIButton addBtnImage:@"registerBtn" AndFrame:CGRectMake(30*Width, 300*Height, 260*Width, 36*Height) WithTarget:self action:@selector(registAccountButton)];
    [_backView addSubview:_loginBtn];
    
    _yanzhengTextF =[self textWithH:250 AndW:140 AndStr:@"输入验证码"];
    _yanzhengTextF.keyboardType =UIKeyboardTypeNumberPad;
    [_backView addSubview:_yanzhengTextF];
    
    
    _huoquBtn =[UIButton addBtnImage:nil AndFrame:CGRectMake(180*Width, 250*Width, 110*Width, 36*Height) WithTarget:self action:@selector(registYanZheng)];
    [_huoquBtn setBackgroundImage:[UIImage imageNamed:@"register_huoqu"] forState:UIControlStateNormal];
    [_huoquBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_huoquBtn setTitleColor:whitesColor forState:UIControlStateNormal];
    _huoquBtn.titleLabel.font =[UIFont systemFontOfSize:12*Width weight:1];
    [_backView addSubview:_huoquBtn];
    
    //验证提交之后的跑秒提示防止用户的重复提交数据有效时间60秒
    timeCount = 60;
    _tipLabel=[[UILabel alloc ]initWithFrame:CGRectMake(180*Width, 250*Height, 110*Width, 35*Height)];
    _tipLabel.textAlignment=NSTextAlignmentCenter;
    _tipLabel.text=[[NSString alloc]initWithFormat:@"%ds",timeCount];
    _tipLabel.textColor=[UIColor whiteColor];
    _tipLabel.layer.cornerRadius=3;
    _tipLabel.clipsToBounds=YES;
    _tipLabel.backgroundColor=[UIColor lightGrayColor];
    _tipLabel.hidden=YES;
    _tipLabel.font=[UIFont systemFontOfSize:14];
    [_backView addSubview:_tipLabel];
    
    
}





#pragma mark-->读秒开始
-(void)readSecond{
    _huoquBtn.hidden=YES;
    
    _tipLabel.hidden=NO;
    
    timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(dealTimer) userInfo:nil repeats:YES];
    timer.fireDate=[NSDate distantPast];
}

#pragma mark-->跑秒操作
-(void)dealTimer{
    
    _tipLabel.text=[[NSString alloc]initWithFormat:@"%ds",timeCount];
    timeCount=timeCount - 1;
    if(timeCount== 0){
        timer.fireDate=[NSDate distantFuture];
        timeCount= 60;
        _tipLabel.hidden=YES;
        _huoquBtn.hidden=NO;
    }
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_phoneTextField endEditing:YES];
    [_passwordText endEditing:YES];
    [_yanzhengTextF endEditing:YES];
    
}





//判断手机号是否注册
-(void)registYanZheng
{
    if ([_phoneTextField.text isEqualToString:@""]||_phoneTextField.text == nil) {
        [FormValidator showAlertWithStr:@"请输入手机号"];
        
    }else{
        
        NSDictionary *parameters1 = @{@"phone":_phoneTextField.text};
        NSLog(@"----%@",parameters1);
        [EncryptAndEcode httpUrl:@"http://api.xiongmaoapi.com/api/xiongmao/check_phone_exists/" AndPostparameters:parameters1 block:^(NSDictionary *responseObject) {
            NSString *str=[NSString stringWithFormat:@"%@",[responseObject valueForKey:@"success"]];
            if([str isEqualToString:@"0"])
            {
                LXAlertView *alert1=[[LXAlertView alloc] initWithTitle:@"提示" message:[responseObject valueForKey:@"msg"] cancelBtnTitle:@"取消" otherBtnTitle:@"确定" clickIndexBlock:^(NSInteger clickIndex) {
                    XMLog(@"点击index====%ld",clickIndex);
                }];
                alert1.animationStyle=LXASAnimationLeftShake;
                [alert1 showLXAlertView];
            }
            else{
                [self huoquyanzhengma];
            }
        
            
        }];
        
    }
    
}
//获取验证码
-(void)huoquyanzhengma
{
    
            NSDictionary *parameters = @{@"sms_type":@"SMS_REG",@"phone":_phoneTextField.text};
            [EncryptAndEcode httpUrl:@"http://api.xiongmaoapi.com/api/xiongmao/send_sms/" AndPostparameters:parameters block:^(NSDictionary *responseObject) {
                [self readSecond];//读秒操作
               // self.registStr = [responseObject objectForKey:@"yanzheng"];
              
            }];
    
}



//用户注册
-(void)registAccountButton
{
    if ([_phoneTextField.text isEqualToString:@""]||_phoneTextField.text ==nil ||[_passwordText.text isEqualToString:@""]||_passwordText.text == nil|| [_yanzhengTextF.text isEqualToString:@""]||_yanzhengTextF.text == nil) {
        [FormValidator showAlertWithStr:@"手机号、昵称或者密码不能为空"];
        return;
    }
//    else if(!([_yanzhengTextF.text intValue]==[self.registStr intValue])){
//        //NSLog(@"%@,%@",_registYZ.text,_registStr);
//        [FormValidator showAlertWithStr:@"请输入正确验证码"];
//        return;
//        
//    }
    else if(_passwordText.text.length <6 ){
        [FormValidator showAlertWithStr:@"密码必须6位以上"];
    }else{
        [self registAccountInterface];
    }
    
}

//注册接口
-(void)registAccountInterface
{

    
    NSDictionary *parameters = @{@"username":_phoneTextField.text,@"password":_passwordText.text,@"code":_yanzhengTextF.text,@"phone":_phoneTextField.text,@"device_type":@"IPHONE"};
    [EncryptAndEcode httpUrl:@"http://api.xiongmaoapi.com/api/xiongmao/reg/" AndPostparameters:parameters block:^(NSDictionary *responseObject) {
        
        
        NSString *str=[NSString stringWithFormat:@"%@",[responseObject valueForKey:@"success"]];
        NSLog(@"----------这里是服务器信息------%@",responseObject);
        if([str isEqualToString:@"0"])
        {
            LXAlertView *alert1=[[LXAlertView alloc] initWithTitle:@"提示" message:[responseObject valueForKey:@"msg"] cancelBtnTitle:@"取消" otherBtnTitle:@"确定" clickIndexBlock:^(NSInteger clickIndex) {
                XMLog(@"点击index====%ld",clickIndex);
            }];
            alert1.animationStyle=LXASAnimationLeftShake;
            [alert1 showLXAlertView];
        }
        else{
            
            LXAlertView *alert1=[[LXAlertView alloc] initWithTitle:@"提示" message:@"注册成功" cancelBtnTitle:@"取消" otherBtnTitle:@"确定" clickIndexBlock:^(NSInteger clickIndex) {
                if(clickIndex==1)
                {
                    [self dismissViewControllerAnimated:YES completion:nil];
                }
                else{
                    [self dismissViewControllerAnimated:YES completion:nil];
                }
            }];
            alert1.animationStyle=LXASAnimationTopShake;
            [alert1 showLXAlertView];
            
            //存进去沙盒
            NSDictionary *dd=@{SHInvokerUserInfoPhoneNo:_phoneTextField.text,SHInvokerUserInfoUserId:[responseObject valueForKey:@"uid"]};
            [SHInvoker saveUserInfo:dd];

        }

    }];
    
    
}



-(UITextField *)addtextFieldWithHeight:(CGFloat)heigh AndImgStr:(NSString *)imgStr AndStr:(NSString *)str
{
    UIImageView *imgBack =[UIImageView addImgWithFrame:CGRectMake(30*Width, heigh*Height, 260*Width, 36*Height) AndImage:@"login_Register_Bord"];
    [_backView addSubview:imgBack];
    
    
    UITextField *textF=[UITextField addTextFieldWithFrame:CGRectMake(30*Width, (heigh+0.5)*Height, 260*Width, 35*Height) AndStr:str AndFont:14 AndTextColor:whitesColor];
    [_backView addSubview:textF];
    
    
    return textF;
}
-(UITextField *)textWithH:(CGFloat)heigh AndW:(CGFloat)Widh AndStr:(NSString *)str
{
    UIImageView *imgBack =[UIImageView addImgWithFrame:CGRectMake(30*Width, heigh*Height, Widh*Width, 36*Height) AndImage:@"login_Register_Bord"];
    [_backView addSubview:imgBack];
    UITextField *textF=[UITextField addTextFieldWithFrame:CGRectMake(30*Width, (heigh+0.5)*Height, Widh*Width, 35*Height) AndStr:str AndFont:14 AndTextColor:whitesColor];
    
    return textF;
    
}

-(void)returnLoginBtn
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_phoneTextField endEditing:YES];
    [_passwordText endEditing:YES];
    [_yanzhengTextF endEditing:YES];
    self.navigationController.navigationBarHidden = NO;
}

@end
