//
//  AppDelegate+AppService.m
//  XiongMaoVPNPro
//
//  Created by ISOYasser on 16/6/18.
//  Copyright © 2016年 ISOYasser. All rights reserved.
//

#import "AppDelegate+AppService.h"
#import <UMSocial.h>
#import <UMSocialWechatHandler.h>
#import <UMSocialQQHandler.h>
#import <JPUSHService.h>

@implementation AppDelegate (AppService)

- (void) registerUmeng{
    
    [UMSocialData setAppKey:UmengAppKey];
    
    [UMSocialConfig setFinishToastIsHidden:YES position:UMSocialiToastPositionTop];
    
    [UMSocialWechatHandler setWXAppId:WetChatAppId appSecret:WetChatAppSecret url:@"http://www.umeng.com/social"];
    //设置手机QQ 的AppId，Appkey，和分享URL，需要#import "UMSocialQQHandler.h"
    [UMSocialQQHandler setQQWithAppId:ShareQQAppID appKey:ShareQQAppKey url:@"http://www.umeng.com/social"];
}


- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE) {
        //调用其他SDK，例如支付宝SDK等
    }
    return result;
}

-(void)configurationPushInfo:(NSDictionary *)launchOptions{
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    } else {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                          UIRemoteNotificationTypeSound |
                                                          UIRemoteNotificationTypeAlert)
                                              categories:nil];
    }
    
    [JPUSHService setupWithOption:launchOptions appKey:appKey
                          channel:channel apsForProduction:isProduction];
    
}


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
    
    [JPUSHService setTags:[NSSet setWithObjects:@"test", nil] alias:@"ZhangQian" callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:self];
    NSString * regitID = [JPUSHService registrationID];
    NSLog(@"----%@----",regitID);
    //    [JPUSHService setTags:[NSSet setWithObjects:@"test", nil] aliasInbackground:@"yxm"];
}

// ＊＊＊＊＊星标2＊＊＊＊＊＊＊
-(void)tagsAliasCallback:(int)iResCode
                    tags:(NSSet*)tags
                   alias:(NSString*)alias
{
    NSLog(@"rescode: %d, \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ntags: %@, \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\nalias: %@\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\n", iResCode, tags , alias);
}


/**
 *  当前APP处于前台活跃状态时接收到推送通知时调用的方法
 *  当前APP处于后台挂起时接到推送点击顶部提示框进到app中调用的方法
 *  当前APP处于后台挂起时接到推送点击通知栏消息进入到app中调用的方法
 *  @param application       <#application description#>
 *  @param userInfo          <#userInfo description#>
 *  @param completionHandler <#completionHandler description#>
 */
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    
    completionHandler(UIBackgroundFetchResultNewData);
    NSLog(@"收到通知:%@", [self logDic:userInfo]);
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"gotoMessageView" object:nil userInfo:<#(nullable NSDictionary *)#>];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"gotoMessageView" object:userInfo];
    
}
/**
 *  注册失败的Push 方法
 *
 *  @param application 应用描述
 *  @param error       错误信息
 */
- (void)application:(UIApplication *)application
didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1

- (void)application:(UIApplication *)application
didRegisterUserNotificationSettings:
(UIUserNotificationSettings *)notificationSettings {
    
    
    
}

- (void)application:(UIApplication *)application                   handleActionWithIdentifier:(NSString *)identifier
forLocalNotification:(UILocalNotification *)notification
  completionHandler:(void (^)())completionHandler {
    
}

- (void)application:(UIApplication *)application
handleActionWithIdentifier:(NSString *)identifier
forRemoteNotification:(NSDictionary *)userInfo
  completionHandler:(void (^)())completionHandler {
    
}
#endif

- (void)application:(UIApplication *)application
didReceiveLocalNotification:(UILocalNotification *)notification {
    [JPUSHService showLocalNotificationAtFront:notification     identifierKey:nil];
}
//编码问题
- (NSString *)logDic:(NSDictionary *)dic {
    if (![dic count]) {
        return nil;
    }
    NSString *tempStr1 =
    [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
                                                 withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\""     withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str =
    [NSPropertyListSerialization propertyListFromData:tempData
                                     mutabilityOption:NSPropertyListImmutable
                                               format:NULL
                                     errorDescription:NULL];
    return str;
}

@end
