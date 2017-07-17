//
//  VPNConnectting.h
//  XiongMaoVPNPro
//
//  Created by 唐晓波的电脑 on 16/6/23.
//  Copyright © 2016年 ISOYasser. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <NetworkExtension/NetworkExtension.h>
#import <NetworkExtension/NEVPNManager.h>
#import <NetworkExtension/NEVPNConnection.h>
#import <NetworkExtension/NEVPNProtocolIKEv2.h>
#import <AdSupport/AdSupport.h>
#import <sys/utsname.h>


@interface VPNConnectting : NSObject

@property (nonatomic, strong) NSString *server;//连接ip
@property (nonatomic, strong) NSDictionary * dicall;//用户数据
@property (nonatomic, strong) NSString * fuwuqid;//服务器地址

- (void) installProfile;

-(void)VPNconnect;

- (void)disconnect;



@end

