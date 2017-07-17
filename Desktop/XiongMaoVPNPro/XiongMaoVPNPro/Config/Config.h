//
//  Config.h
//  XiongMaoVPNPro
//
//  Created by ISOYasser on 16/6/18.
//  Copyright © 2016年 ISOYasser. All rights reserved.
//

#ifndef Config_h
#define Config_h


#define kPushPhotoBrowserNotifitationName                                                                                                                 @"PushPhotoBrowser"
#define kPresentVideoPlayerNotifitationName                                                                                                               @"playCallBackVideo"

#define APPICONIMAGE [UIImage imageNamed:[[[[NSBundle mainBundle] infoDictionary] valueForKeyPath:@"CFBundleIcons.CFBundlePrimaryIcon.CFBundleIconFiles"] lastObject]]
#define APPNAME [[[NSBundle mainBundle] infoDictionary]                                                                                                   objectForKey:@"CFBundleDisplayName"]
#define Main_Color [UIColor colorWithRed:(3)/255.0 green:(160)/255.0 blue:(235)/255.0                                                                     alpha:1.0]
#define Main2_Color [UIColor colorWithRed:(135)/255.0 green:(202)/255.0 blue:(231)/255.0                                                                  alpha:1.0]
#define VTColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0                                                                   alpha:1.0]
#define Text_Color [UIColor colorWithRed:(51)/255.0 green:(71)/255.0 blue:(113)/255.0                                                                     alpha:1.0]
#define BackGround_Color [UIColor colorWithRed:(235)/255.0 green:(235)/255.0 blue:(241)/255.0                                                             alpha:1.0]

#define Default_Person_Image [UIImage                                                                                                                     imageNamed:@"default_parents"]
#define Default_General_Image [UIImage                                                                                                                    imageNamed:@"default_general"]

#define kScreenW [UIScreen                                                                                                                                mainScreen].bounds.size.width
#define kScreenH [UIScreen                                                                                                                                mainScreen].bounds.size.height
//以及各种第三方服务商的appId或者App key
#define UmengAppKey                                                                                                                                       @"5764bad1e0f55a77c9000add"         //友盟分享appKey
#define ShareQQAppID                                                                                                                                      @"1105407411"                       //腾讯appID
#define ShareQQAppKey                                                                                                                                     @"DWGXLudmky3Q9MOb"                 //腾讯appKey
#define WetChatAppId                                                                                                                                      @"wxfb4a9ce8a434401b"               //微信appID
#define WetChatAppSecret                                                                                                                                  @"248e42b93d576b65c4bfc0ba75f36873" //微信appSecret

#define TabsFileName                                                                                                                                      @"share.plist"

#define XMFilePathWithName(fileName) [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:fileName]

#define shareFilePaht XMFilePathWithName(TabsFileName)


#define SHEBEIHAO [[[UIDevice currentDevice] identifierForVendor] UUIDString]


#define XMSHUJUHUANCUN @"HUANCUN"

/******************VPN连接*****************/
#define AppStoreAppId                                                                                                              @"1125640621"

#define XMSHUJUHUANCUN                                                                                                             @"HUANCUN"
//vpn缓存protocol的路径
#define NEVPNProtocolIKEv2Path [NSSearchPathForDirectoriesInDomains (NSCachesDirectory,NSUserDomainMask,YES)[0] stringByAppendingPathComponent:@"NEVPNProtocolIKEv2.data"]

#define NEVPNProtocolIKEv2Key @"NEVPNProtocolIKEv2Key"

#endif /* Config_h */
