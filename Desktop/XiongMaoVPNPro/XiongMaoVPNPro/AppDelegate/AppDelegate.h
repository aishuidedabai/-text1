//
//  AppDelegate.h
//  XiongMaoVPNPro
//
//  Created by ISOYasser on 16/6/17.
//  Copyright © 2016年 ISOYasser. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftSlideViewController.h"
#import "RootNavigationController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) RootNavigationController * mainNC;
@property (nonatomic, strong) LeftSlideViewController * leftSlideVC;
@property NSInteger currentIndex;

@end

