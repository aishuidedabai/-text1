//
//  OtherViewController.m
//  Touch
//
//  Created by lanou3g on 15/12/14.
//  Copyright © 2015年 syx. All rights reserved.
//

#import "OtherViewController.h"
#import "RootNavigationController.h"
@interface OtherViewController ()

@end

@implementation OtherViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    //返回按钮的颜色
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    //设置返回键
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    self.navigationItem.backBarButtonItem = backItem;
    backItem.title = @"返回";
    RootNavigationController * rootNC = (RootNavigationController *)self.navigationController;
    rootNC.segmentControl.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    RootNavigationController * rootNC = (RootNavigationController *)self.navigationController;
    rootNC.segmentControl.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
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
