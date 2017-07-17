//
//  LoginAndRigistViewController.m
//  XiongMaoVPNPro
//
//  Created by 唐晓波的电脑 on 16/6/20.
//  Copyright © 2016年 ISOYasser. All rights reserved.
//

//登录注册
#import "LoginAndRigistViewController.h"

@interface LoginAndRigistViewController ()
{
    UIImageView* imgLeftHand;
    UIImageView* imgRightHand;
    UIImageView* imgLeftHandGone;
    UIImageView* imgRightHandGone;
    LogingAnimationType AnimationType;
}
@property (weak, nonatomic) IBOutlet UIView *login_view;

@end

@implementation LoginAndRigistViewController

-(void)zhuce
{
    XMLog(@"注册");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc] initWithTitle:@"注册" style:UIBarButtonItemStyleDone target:self action:@selector(zhuce)];
    self.navigationItem.rightBarButtonItem = shareItem;
    //返回按钮的颜色
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    self.view.backgroundColor=[UIColor whiteColor];
    
    self.view.backgroundColor=[UIColor whiteColor];
      [self UISetting];
    // Do any additional setup after loading the view.
    
    //订阅键盘通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWiddChangeFrame:) name:UIKeyboardDidChangeFrameNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWiddHidenFrame:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWiddChangeFrame:(NSNotification *)noti
{
    
//    CGRect keyboardFrameEnd = [noti.userInfo[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
//
    CGFloat  duration = [noti.userInfo[@""] floatValue];
//
//    CGFloat y = keyboardFrameEnd.origin.y - self.view.frame.size.height;
    
//    CGFloat ly = self.view.frame.size.height - self.login_view.
    [UIView animateWithDuration:duration animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, -100);
    }];
    
    
    
    //    {
    //        UIKeyboardAnimationCurveUserInfoKey = 7;
    //        UIKeyboardAnimationDurationUserInfoKey = "0.25";
    //        UIKeyboardBoundsUserInfoKey = "NSRect: {{0, 0}, {375, 258}}";
    //        UIKeyboardCenterBeginUserInfoKey = "NSPoint: {187.5, 538}";
    //        UIKeyboardCenterEndUserInfoKey = "NSPoint: {187.5, 796}";
    //        UIKeyboardFrameBeginUserInfoKey = "NSRect: {{0, 409}, {375, 258}}";
    //        UIKeyboardFrameEndUserInfoKey = "NSRect: {{0, 667}, {375, 258}}";
    //    }
}

- (void) keyboardWiddHidenFrame :(NSNotification *)noti{
    CGFloat  duration = [noti.userInfo[@""] floatValue];
        [UIView animateWithDuration:duration animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, 100);
    }];

}

-(void)UISetting{
    
    AnimationType = LogingAnimationType_NONE;
    UIColor* boColor = [UIColor colorWithRed:221.0/255.0 green:221.0/255.0 blue:221.0/255.0 alpha:100];
    
    _UserNameTextField.layer.borderColor = boColor.CGColor;
    _UserNameTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    _UserNameTextField.leftViewMode = UITextFieldViewModeAlways;
    UIImageView* imgUser = [[UIImageView alloc] initWithFrame:CGRectMake(11, 11, 22, 22)];
    imgUser.image = [UIImage imageNamed:@"iconfont-user"];
    [_UserNameTextField.leftView addSubview:imgUser];
    
    _PasswordTextField.layer.borderColor = boColor.CGColor;
    _PasswordTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    _PasswordTextField.leftViewMode = UITextFieldViewModeAlways;
    UIImageView* imgPwd = [[UIImageView alloc] initWithFrame:CGRectMake(11, 11, 22, 22)];
    imgPwd.image = [UIImage imageNamed:@"iconfont-password"];
    [_PasswordTextField.leftView addSubview:imgPwd];
    
    _loginView.layer.borderColor = boColor.CGColor;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    if ([textField isEqual:_PasswordTextField]) {
        AnimationType = LogingAnimationType_PWD;
        [self AnimationUserToPassword];
        
    }else{
        
        if (AnimationType == LogingAnimationType_NONE) {
            AnimationType = LogingAnimationType_USER;
            return;
        }
        AnimationType = LogingAnimationType_USER;
        [self AnimationPasswordToUser];
        
    }
    
}

#pragma mark 移开手动画
-(void)AnimationPasswordToUser{
    
    [UIView animateWithDuration:0.5f animations:^{
        
        self.left_look.frame = CGRectMake(self.left_look.frame.origin.x - 80, self.left_look.frame.origin.y, 40, 40);
        self.right_look.frame = CGRectMake(self.right_look.frame.origin.x + 40, self.right_look.frame.origin.y, 40, 40);
        
        self.right_hidden.frame = CGRectMake(self.right_hidden.frame.origin.x+55, self.right_hidden.frame.origin.y+40, 40, 66);
        self.left_hidden.frame = CGRectMake(self.left_hidden.frame.origin.x-60, self.left_hidden.frame.origin.y+40, 40, 66);
        
    } completion:^(BOOL finished) {
        
    }];
    
}


#pragma mark 捂眼
-(void)AnimationUserToPassword{
    [UIView animateWithDuration:0.5f animations:^{
        
        self.left_look.frame = CGRectMake(self.left_look.frame.origin.x + 80, self.left_look.frame.origin.y, 0, 0);
        self.right_look.frame = CGRectMake(self.right_look.frame.origin.x - 40, self.right_look.frame.origin.y, 0, 0);
        
        self.right_hidden.frame = CGRectMake(self.right_hidden.frame.origin.x-55, self.right_hidden.frame.origin.y-40, 40, 66);
        self.left_hidden.frame = CGRectMake(self.left_hidden.frame.origin.x+60, self.left_hidden.frame.origin.y-40, 40, 66);
        
    } completion:^(BOOL finished) {
        
    }];
}

- (IBAction)EndEDitTap:(id)sender {
    if (AnimationType == LogingAnimationType_PWD) {
        [self AnimationPasswordToUser];
    }
    AnimationType = LogingAnimationType_NONE;
    [self.view endEditing:YES];
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
