//
//  LZXViewController.h
//  引导页
//
//  Created by twzs on 16/6/23.
//  Copyright © 2016年 LZX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftSlideViewController.h"
#import "RootNavigationController.h"

@interface LZXViewController : UIViewController

/**************** 存放图片的数组  *******************/
@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, strong) UIViewController *controller;

@property (nonatomic, strong) RootNavigationController * mainNC;
@property (nonatomic, strong) LeftSlideViewController * leftSlideVC;


@end
