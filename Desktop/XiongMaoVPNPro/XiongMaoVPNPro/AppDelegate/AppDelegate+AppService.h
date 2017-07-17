//
//  AppDelegate+AppService.h
//  XiongMaoVPNPro
//
//  Created by ISOYasser on 16/6/18.
//  Copyright © 2016年 ISOYasser. All rights reserved.
//

#import "AppDelegate.h"

//推送和分享
static NSString *appKey = @"6cf1e2ce2c3a93e06e1c67ae";  //AppKey  *必填
static NSString *channel = nil; //发布聚到 选填
static BOOL isProduction = FALSE;  //是否为生产环境

@interface AppDelegate (AppService)

- (void) registerUmeng;

-(void)configurationPushInfo:(NSDictionary *)launchOptions;

@end
