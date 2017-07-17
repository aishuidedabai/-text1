//
//  AppDelegate.m
//  XiongMaoVPNPro
//
//  Created by ISOYasser on 16/6/17.
//  Copyright © 2016年 ISOYasser. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "LeftSortViewController.h"
#import "AppDelegate+AppService.h"

#import "VersionManage.h"
#import <AVFoundation/AVFoundation.h>
#import "LaunchAnimationTool.h"
#import "WXApi.h"
#import "AppDelegate+AppLifeCircle.h"
#import "LZXViewController.h"

@interface AppDelegate ()
@property (nonatomic, strong) UIWindow *topWindow;
@property (nonatomic, assign) UIBackgroundTaskIdentifier bgTaskId;
@end

@implementation AppDelegate




- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self DTouch];
    _currentIndex=1;//判断提示框勾选哪一个
    
   
    
    self.window  = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    MainViewController * mainVC = [[MainViewController alloc]init];
    self.mainNC = [[RootNavigationController alloc]initWithRootViewController:mainVC];
    LeftSortViewController * leftSoutVC = [[LeftSortViewController alloc]init];
    UINavigationController * leftNC = [[UINavigationController alloc]initWithRootViewController:leftSoutVC];
    self.leftSlideVC = [[LeftSlideViewController alloc]initWithLeftView:leftNC andMainView:self.mainNC];
    self.window.rootViewController = self.leftSlideVC;
    //设置NavigationBar背景颜色
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:2/225.0 green:35/225.0 blue:78/225.0 alpha:0]];
    //设置点击状态的UITabBarItem颜色
    //    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:2/225.0 green:35/225.0 blue:78/225.0 alpha:1], NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    //标题栏颜色
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    [self.window makeKeyAndVisible];
    
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]){
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
        NSLog(@"第一次启动");
        
  
        // 初始化引导页控制器
        LZXViewController *view = [[LZXViewController alloc]init];
        // 设置引导页图片
        view.dataArray = [NSArray arrayWithObjects:@"启动页1.png",@"启动页2.png",@"启动页3.png", nil];
        // 设置跳转界面
        view.controller = [[MainViewController alloc]init];
        RootNavigationController *root = [[RootNavigationController alloc]initWithRootViewController:view];
          self.window.rootViewController = root;
        
  

        
    }else{
        NSLog(@"已经不是第一次启动了");
    }
    
    
    //TODO: 友盟(分享)注册
    [self registerUmeng];
    
    //TODO: 极光推送
    [self configurationPushInfo:launchOptions];
    
    [self wangluo];
    
    [LaunchAnimationTool showLaunchAnimationViewToWindow];

   
    
    return YES;
}
-(void)wangluo
{
    //创建网络监听管理者对象
    AFNetworkReachabilityManager *manager1 = [AFNetworkReachabilityManager sharedManager];
    /*
     typedef NS_ENUM(NSInteger, AFNetworkReachabilityStatus) {
     AFNetworkReachabilityStatusUnknown          = -1,//未识别的网络
     AFNetworkReachabilityStatusNotReachable     = 0,//不可达的网络(未连接)
     AFNetworkReachabilityStatusReachableViaWWAN = 1,//2G,3G,4G...
     AFNetworkReachabilityStatusReachableViaWiFi = 2,//wifi网络
     };
     */
    //设置监听
    [manager1 setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未识别的网络");
                
                break;
                
            case AFNetworkReachabilityStatusNotReachable:
            {
                NSLog(@"不可达的网络(未连接)");
                NSNotification *notification =[NSNotification notificationWithName:@"断网" object:nil userInfo:nil];
                //通过通知中心发送通知
                [[NSNotificationCenter defaultCenter] postNotification:notification];
            }
                
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
            {
                NSLog(@"2G,3G,4G...的网络");
                NSNotification *notification =[NSNotification notificationWithName:@"有网" object:nil userInfo:nil];
                //通过通知中心发送通知
                [[NSNotificationCenter defaultCenter] postNotification:notification];
                
            }
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
            {
                NSLog(@"wifi的网络");
                NSNotification *notification =[NSNotification notificationWithName:@"有网" object:nil userInfo:nil];
                //通过通知中心发送通知
                [[NSNotificationCenter defaultCenter] postNotification:notification];
                
            }
                
                break;
            default:
                break;
        }
    }];
    //开始监听
    [manager1 startMonitoring];
    

}

//-(void)applicationWillResignActive:(UIApplication *)application
//{
//    //开启后台处理多媒体事件
//    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
//    AVAudioSession *session=[AVAudioSession sharedInstance];
//    [session setActive:YES error:nil];
//    //后台播放
//    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
//    //这样做，可以在按home键进入后台后 ，播放一段时间，几分钟吧。但是不能持续播放网络歌曲，若需要持续播放网络歌曲，还需要申请后台任务id，具体做法是：
//    _bgTaskId=[AppDelegate backgroundPlayerID:_bgTaskId];
//    //其中的_bgTaskId是后台任务UIBackgroundTaskIdentifier _bgTaskId;
//}
//+(UIBackgroundTaskIdentifier)backgroundPlayerID:(UIBackgroundTaskIdentifier)backTaskId
//{
//    //设置并激活音频会话类别
//    AVAudioSession *session=[AVAudioSession sharedInstance];
//    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
//    [session setActive:YES error:nil];
//    //允许应用程序接收远程控制
//    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
//    //设置后台任务ID
//    UIBackgroundTaskIdentifier newTaskId=UIBackgroundTaskInvalid;
//    newTaskId=[[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:nil];
//    if(newTaskId!=UIBackgroundTaskInvalid&&backTaskId!=UIBackgroundTaskInvalid)
//    {
//        [[UIApplication sharedApplication] endBackgroundTask:backTaskId];
//    }
//    return newTaskId;
//}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    //提示更新
    VersionManage *manager = [[VersionManage alloc] init];
    [manager checkVerSionWithCallBack:^{
        
    }];
    
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    //创建通知
    NSNotification *notification =[NSNotification notificationWithName:@"tuichu" object:nil userInfo:nil];
    //通过通知中心发送通知
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    
}

//3dtouch走的方法
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler {
    
    
    if ([shortcutItem.type isEqualToString:@"guanzhuweixin"]) {
        
        
    }
    else if ([shortcutItem.type isEqualToString:@"qupingjia"]) {
       
        //评价
        NSString *str = [NSString stringWithFormat:@"https://appsto.re/cn/TM-fdb.i" ];//?id=%@
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        
    }
    else if ([shortcutItem.type isEqualToString:@"xiongmaojiaoliuqun"]) {
        
        NSString *urlStr = [NSString stringWithFormat:@"mqqapi://card/show_pslcard?src_type=internal&version=1&uin=%@&key=%@&card_type=group&source=external", @"385379831",@"c393bdd95ccdbcde94e051d97f7028f9480895212315ae596808152fb1236d76"];
        NSURL *url = [NSURL URLWithString:urlStr];
        if([[UIApplication sharedApplication] canOpenURL:url]){
            [[UIApplication sharedApplication] openURL:url];
            return;
        }
        
    }
    
}

//3dtouch
-(void)DTouch
{
    // 动态添加快捷启动
    UIApplicationShortcutIcon *icon = [UIApplicationShortcutIcon iconWithTemplateImageName:@""];
    UIApplicationShortcutItem *item = [[UIApplicationShortcutItem alloc] initWithType:@"guanzhuweixin" localizedTitle:@"一键加速" localizedSubtitle:nil icon:icon userInfo:nil];
    
    UIApplicationShortcutIcon *icon1 = [UIApplicationShortcutIcon iconWithTemplateImageName:@"leftbar_pingjia"];
    UIApplicationShortcutItem *item1 = [[UIApplicationShortcutItem alloc] initWithType:@"qupingjia" localizedTitle:@"去评价" localizedSubtitle:nil icon:icon1 userInfo:nil];
    UIApplicationShortcutIcon *icon2 = [UIApplicationShortcutIcon iconWithTemplateImageName:@"leftbar_QQ"];
    UIApplicationShortcutItem *item2 = [[UIApplicationShortcutItem alloc] initWithType:@"xiongmaojiaoliuqun" localizedTitle:@"熊猫交流群" localizedSubtitle:nil icon:icon2 userInfo:nil];
    [[UIApplication sharedApplication] setShortcutItems:@[item2,item1,item]];
}



@end
