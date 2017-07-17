//
//  XHChatQQ.m
//  XHChatQQExample
//
//  Created by xiaohui on 16/6/7.
//  Copyright © 2016年 qiantou. All rights reserved.
//  https://github.com/CoderZhuXH/XHChatQQ

#import "XHChatQQ.h"


@implementation XHChatQQ

+(BOOL)haveQQ//是否安装了QQ
{
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]];
}
+(void)chatWithQQ:(NSString *)QQ
{
    NSString *url = [NSString stringWithFormat:@"mqq://im/chat?chat_type=wpa&uin=%@&version=1&src_type=web",@"800133216"];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}
@end
