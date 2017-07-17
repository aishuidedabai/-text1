//
//  LoginAndRigistViewController.h
//  XiongMaoVPNPro
//
//  Created by 唐晓波的电脑 on 16/6/20.
//  Copyright © 2016年 ISOYasser. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WPAutoSpringTextViewController.h"
typedef NS_ENUM(NSInteger, LogingAnimationType) {
    LogingAnimationType_NONE,
    LogingAnimationType_USER,
    LogingAnimationType_PWD
};


@interface LoginAndRigistViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *UserNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *PasswordTextField;

@property (weak, nonatomic) IBOutlet UIView *loginView;

@property (weak, nonatomic) IBOutlet UIImageView *left_hidden;
@property (weak, nonatomic) IBOutlet UIImageView *right_hidden;

@property (weak, nonatomic) IBOutlet UIImageView *left_look;
@property (weak, nonatomic) IBOutlet UIImageView *right_look;

@property (weak, nonatomic) IBOutlet UIButton *LoginButton;

@end
