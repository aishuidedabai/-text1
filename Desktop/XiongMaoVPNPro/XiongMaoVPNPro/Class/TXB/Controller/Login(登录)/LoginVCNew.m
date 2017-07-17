//
//  LoginVCNew.m
//  易林Video
//
//  Created by beijingduanluo on 15/12/19.
//  Copyright © 2015年 beijingduanluo. All rights reserved.
//

#import "LoginVCNew.h"
#import "RegisterVCNew.h"
#import "ForgetPassWordVCNew.h"
#import "EncryptAndEcode.h"
@interface LoginVCNew ()
@property(nonatomic,strong)UIImageView *backImgV;
@property(nonatomic,strong)UIImageView *backView;
@property(nonatomic,strong)UITextField *phoneTextField;
@property(nonatomic,strong)UIImageView *phoneImgV;
@property(nonatomic,strong)UITextField *passwordText;
@property(nonatomic,strong)UIImageView *passwordImgV;
@property(nonatomic,strong)UIButton *loginBtn;
@property(nonatomic,strong)UIButton *forgetPassWordBtn;
@property(nonatomic,strong)UIButton *registBtn;
@property(nonatomic,strong)UIImageView *headImgV;
@property(nonatomic,strong)UIButton *returnTopBtn;
@property(nonatomic,strong)UIButton *loginBtnReturn;

@end

@implementation LoginVCNew
{
    NSDictionary *info;
}


-(void)returnLoginBtn
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
   
    _backImgV =[UIImageView addImgWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) AndImage:@"ditu"];
    [self.view addSubview:_backImgV];
    _backImgV.userInteractionEnabled = YES;
    
    
    _backView =[UIImageView addImgWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) AndImage:@"zuizhongbanquan"];
    [self.view addSubview:_backView];
    _backView.userInteractionEnabled = YES;
    
    _headImgV =[UIImageView addImgWithFrame:CGRectMake(125*Width, 90*Height, 70*Width, 70*Height) AndImage:@"leftbar_default"];
    [_backView addSubview:_headImgV];
    
    _phoneTextField =[self addtextFieldWithHeight:200 AndImgStr:nil AndStr:@"请输入手机号码"];
    
    
   
 
 
    _phoneTextField.keyboardType =UIKeyboardTypeNumberPad;
    [_backView addSubview:_phoneTextField];
    
    _passwordText =[self addtextFieldWithHeight:250 AndImgStr:nil AndStr:@"请输入密码"];
    _passwordText.secureTextEntry = YES;
    [_backView addSubview:_passwordText];
    
    _loginBtn =[UIButton addBtnImage:@"loginBtn" AndFrame:CGRectMake(30*Width, 300*Height, 260*Width, 36*Height) WithTarget:self action:@selector(loginAccountButton)];
    [_backView addSubview:_loginBtn];
    
    _forgetPassWordBtn =[UIButton addBtnImage:nil AndFrame:CGRectMake(215*Width, 340*Height, 90*Width, 20*Height) WithTarget:self action:@selector(forgetPasswordClick)];
    [_forgetPassWordBtn setTitle:@"忘记密码 ?" forState:UIControlStateNormal];
    _forgetPassWordBtn.titleLabel.font =[UIFont systemFontOfSize:12*Width weight:0.5];
    [_backView addSubview:_forgetPassWordBtn];
    
    _registBtn =[UIButton addBtnImage:@"register_loginBtn" AndFrame:CGRectMake(110*Width, 380*Height, 100*Width, 15*Height) WithTarget:self action:@selector(registAccountInterface)];
    [_backView addSubview:_registBtn];
    
    _loginBtnReturn =[UIButton addBtnImage:@"login_Return_Left" AndFrame:CGRectMake(20*Height, 30*Height, 25*Width, 25*Height) WithTarget:self action:@selector(returnLoginBtn)];
    [_backView addSubview:_loginBtnReturn];

    
    
}
-(void)returnLoginBtnsss
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)forgetPasswordClick{
    ForgetPassWordVCNew *forget=[[ForgetPassWordVCNew alloc]init];
    [self presentViewController:forget animated:YES completion:nil];
}
//注册接口
-(void)registAccountInterface
{
    RegisterVCNew *regist=[[RegisterVCNew alloc]init];
    [self presentViewController:regist animated:YES completion:nil];
    
}
//登录方法
-(void)loginAccountButton
{
    
//    NSString *userName =[FormValidator checkMobile:_phoneTextField.text];
//    NSString *passWord=[FormValidator checkPassword:_passwordText.text];
//    if ([_phoneTextField.text isEqualToString:@""]||_phoneTextField.text == nil||[_passwordText.text isEqualToString:@""]||_passwordText.text == nil) {
//        [FormValidator showAlertWithStr:@"用户名或密码不能为空"];
//        return;
//    }else{
//        if (userName) {
//            [FormValidator showAlertWithStr:userName];
//            return;
//        }
//        if (passWord) {
//            [FormValidator showAlertWithStr:passWord];
//            return;
//        }
//    }
    [self loginAccountInter];
    
    
}


//登陆接口
-(void)loginAccountInter
{
    [self.view endEditing:YES];

   
     NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
    NSLog(@"--版本号-----%@",currentVersion);
    NSDictionary *parameters = @{@"device_type":@"IPHONE",@"username":_phoneTextField.text,@"password":_passwordText.text,@"hardware_sn":deviceUUID,@"soft_version":currentVersion};
    XMLog(@"--------------%@",parameters);
    [EncryptAndEcode httpUrl:@"http://api.xiongmaoapi.com/api/xiongmao/login/" AndPostparameters:parameters block:^(NSDictionary *responseObject) {
        
        
        NSLog(@"----------这里是服务器信息------%@",responseObject);
        NSString *str=[NSString stringWithFormat:@"%@",[responseObject valueForKey:@"success"]];
        if([str isEqualToString:@"0"])
        {
            LXAlertView *alert1=[[LXAlertView alloc] initWithTitle:@"提示" message:[responseObject valueForKey:@"msg"] cancelBtnTitle:@"取消" otherBtnTitle:@"确定" clickIndexBlock:^(NSInteger clickIndex) {
            }];
            alert1.animationStyle=LXASAnimationLeftShake;
            [alert1 showLXAlertView];
        }
        else{
            NSNotification *notification =[NSNotification notificationWithName:@"登录" object:nil userInfo:nil];
            //通过通知中心发送通知
            [[NSNotificationCenter defaultCenter] postNotification:notification];
            
            LXAlertView *alert1=[[LXAlertView alloc] initWithTitle:@"提示" message:@"登录成功" cancelBtnTitle:@"取消" otherBtnTitle:@"确定" clickIndexBlock:^(NSInteger clickIndex) {
                
                 [self.navigationController popViewControllerAnimated:YES];
                
            }];
            alert1.animationStyle=LXASAnimationTopShake;
            [alert1 showLXAlertView];
            //存进去沙盒
            NSDictionary *dd=@{SHInvokerUserInfoPhoneNo:_phoneTextField.text,SHInvokerUserInfoStatus:_passwordText.text};
            [SHInvoker saveUserInfo:dd];
            
        }

        
        
    }];


}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_phoneTextField endEditing:YES];
    [_passwordText endEditing:YES];
    
}

-(UITextField *)addtextFieldWithHeight:(CGFloat)heigh AndImgStr:(NSString *)imgStr AndStr:(NSString *)str
{
    UIImageView *imgBack =[UIImageView addImgWithFrame:CGRectMake(30*Width, heigh*Height, 260*Width, 36*Height) AndImage:@"login_Register_Bord"];
    [_backView addSubview:imgBack];
    
    UITextField *textF =[UITextField addTextFieldWithFrame:CGRectMake(30*Width, (heigh+0.5)*Height, 260*Width, 35*Height) AndStr:str AndFont:14 AndTextColor:whitesColor];
    [_backView addSubview:textF];
    
    
    return textF;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
       info= [SHInvoker getUserInfo];

    NSString *str=[NSString stringWithFormat:@"%@",[info valueForKey:@"phone"]];
    
    if(str==nil||str==NULL|| [str isEqualToString:@"(null)"])
    {
        str=@"";
    }
    _phoneTextField.text=str;
  
    
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [self.view endEditing:YES];
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = YES;
    
}
@end
