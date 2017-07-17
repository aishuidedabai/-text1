//
//  VPNManager.m
//  XiongMaoVPNPro
//
//  Created by ISOYasser on 16/6/23.
//  Copyright © 2016年 ISOYasser. All rights reserved.
//

#import "VPNConnectting.h"
#import "ProtolTools.h"

@interface VPNConnectting ()
@property (nonatomic, strong) NEVPNManager * vpnManager;
//@property (nonatomic, strong) NEVPNProtocolIKEv2 *p;
@end


@implementation VPNConnectting
//类的初始化
- (instancetype)init{
    if (self = [super init]) {
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc addObserver:self
               selector:@selector(vpnStatusDidChanged:)
                   name:NEVPNStatusDidChangeNotification
                 object:nil];
    }
    
    return self;
}

- (NEVPNManager *)vpnManager{
    if (!_vpnManager) {
        _vpnManager = [NEVPNManager sharedManager];
    }
    return _vpnManager;
}


-(void)VPNconnect
{
    NEVPNStatus status = self.vpnManager.connection.status;
    if (status == NEVPNStatusConnected
        || status == NEVPNStatusConnecting
        || status == NEVPNStatusReasserting) {
        [self disconnect];
        
    } else {
        [self connect];
    }
}

- (void)disconnect
{
    [self.vpnManager.connection stopVPNTunnel];
}

- (void)connect {
    [self connectVPN];
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self
           selector:@selector(vpnConfigDidChanged:)
               name:NEVPNConfigurationChangeNotification
             object:nil];
    
}

- (void)vpnConfigDidChanged:(NSNotification *)notification
{
    // TODO: Save configuration failed
    [self startConnecting];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:NEVPNConfigurationChangeNotification
                                                  object:nil];
}

- (void)startConnecting
{
    NSError *startError;
    [self.vpnManager.connection startVPNTunnelAndReturnError:&startError];
    if (startError) {
        NSLog(@"Start VPN failed: [%@]", startError.localizedDescription);
    }
}
#pragma masrk-----连接VPN
- (void) connectVPN{
    //保存
    [self installProfile];
    
    [self.vpnManager loadFromPreferencesWithCompletionHandler:^(NSError *error) {
        if (error) {
            
            NSLog(@"Load config failed [%@]", error.localizedDescription);
            return;
        }
#pragma mark ---------拿出VPN本地存取的数据进行连接
        //连接VPN
//        NEVPNProtocolIKEv2 * p = [ProtolTools getProtocol];
//        [self.vpnManager setProtocol:p];
//        self.vpnManager.localizedDescription = @"熊猫加速器";
//        self.vpnManager.enabled = YES;
//        [self.vpnManager saveToPreferencesWithCompletionHandler:^(NSError * _Nullable error) {
//        }];
    }];
}

#pragma masrk-----安装VPN
- (void)installProfile {
    
    //连接ip
    if(self.server==nil||self.server==NULL||[self.server isEqualToString:@""]||[self.server isEqualToString:@"<null>"])
    {
        self.server=@"123.57.157.48";
    }
    
    NSString *stt=[NSString stringWithFormat:@"%@",[_dicall valueForKey:@"is_test"]];
    NSString *username=nil;
    NSString *usepasswod=nil;
    if([stt isEqualToString:@"1"])//非注册
    {
        
        username =[NSString stringWithFormat:@"0$%@$%@$%@",_fuwuqid,[_dicall valueForKey:@"test_uid"],[_dicall valueForKey:@"test_username"]];
        usepasswod=[NSString stringWithFormat:@"%@",[_dicall valueForKey:@"test_password"]];
    }
    
    else{//注册用户
        
        usepasswod=[NSString stringWithFormat:@"%@",[_dicall valueForKey:@"password"]];
        username =[NSString stringWithFormat:@"0$%@$%@$%@",_fuwuqid,[_dicall valueForKey:@"uid"],[_dicall valueForKey:@"username"]];
    }
    
    NSString *remoteIdentifier = self.server;
    NSString *localIdnetifier = self.server;
    
    // Save password & psk
    [self createKeychainValue:usepasswod forIdentifier:@"VPN_PASSWORD"];
    
    NSLog(@"-------%@-----",usepasswod);
    // [self createKeychainValue:_presharedKey.text forIdentifier:@"PSK"];
    // Load config from perference
    
    [self.vpnManager loadFromPreferencesWithCompletionHandler:^(NSError *error) {
        
        if (error) {
            
            NSLog(@"Load config failed [%@]", error.localizedDescription);
            return;
        }
        
        NEVPNProtocolIKEv2 *p = (NEVPNProtocolIKEv2 *)self.vpnManager.protocol;
        if (p) {
        } else {
            p = [[NEVPNProtocolIKEv2 alloc] init];
        }
        p.username = username;
        p.serverAddress = self.server;
        // Get password persistent reference from keychain
        // If password doesn't exist in keychain, should create it beforehand.
        // [self createKeychainValue:@"your_password" forIdentifier:@"VPN_PASSWORD"];
        p.passwordReference = [self searchKeychainCopyMatching:@"VPN_PASSWORD"];
        // PSK
        p.authenticationMethod = NEVPNIKEAuthenticationMethodCertificate | NEVPNIKEAuthenticationMethodNone | NEVPNIKEAuthenticationMethodSharedSecret;//证书连接方式
        // [self createKeychainValue:@"your_psk" forIdentifier:@"PSK"];
        p.sharedSecretReference = [self searchKeychainCopyMatching:@"PSK"];
        /*
         // certificate 证书
         p.identityData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"client" ofType:@"p12"]];
         p.identityDataPassword = @"[Your certificate import password]";
         */
        p.identityData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"client" ofType:@"p12"]];
        p.identityDataPassword = @"1234qwqw";
        p.localIdentifier = localIdnetifier;
        p.remoteIdentifier = remoteIdentifier;
        
        NSLog(@"----------------%@",p.localIdentifier);
        p.useExtendedAuthentication = YES;
        p.disconnectOnSleep = NO;
        self.vpnManager.protocol = p;
        self.vpnManager.localizedDescription = @"熊猫加速器";
        self.vpnManager.enabled = YES;
        //TODO: 将p归档到本地
        [ProtolTools saverProtol:p];
        
        [self.vpnManager saveToPreferencesWithCompletionHandler:^(NSError *error) {
            if (error) {//初始化证书失败
                //                image22.image=[UIImage imageNamed:@"加速0001.png"];
                //                NSLog(@"Save config failed [%@]", error.localizedDescription);
            }
            else{//安装成功
                
                   [[NSUserDefaults standardUserDefaults] setObject:@"初始化成功" forKey:@"初始化成功"];
                
                
            }
        }];
        
        //        [self.vpnManager.connection startVPNTunnelAndReturnError:nil];
        //
    }];
}

static int m;
- (void)vpnStatusDidChanged:(NSNotification *)notification
{
    
    NEVPNStatus status = _vpnManager.connection.status;
    switch (status) {
        case NEVPNStatusConnected:
        {
            //存进去沙盒
            NSDictionary *dd=@{SHInvokerUserInfolocationSign:@"连接成功"};
            [SHInvoker saveUserInfo:dd];
            NSNotification *notification =[NSNotification notificationWithName:@"连接成功" object:nil userInfo:nil];
            //通过通知中心发送通知
            [[NSNotificationCenter defaultCenter] postNotification:notification];
            
        }
            break;
        case NEVPNStatusInvalid:
        case NEVPNStatusDisconnected:
        {
            
            NSDictionary * info= [SHInvoker getUserInfo];
            NSString *strsign=[NSString stringWithFormat:@"%@",[info valueForKey:@"sign"]];
            if(m==1||[strsign isEqualToString:@"连接成功"])
            {
                NSNotification *notification =[NSNotification notificationWithName:@"连接失败" object:nil userInfo:nil];
                //通过通知中心发送通知
                [[NSNotificationCenter defaultCenter] postNotification:notification];
                //存进去沙盒进行判断是否在加速中
                NSDictionary *dd=@{SHInvokerUserInfolocationSign:@"连接失败"};
                [SHInvoker saveUserInfo:dd];
            }
            m=1;
            
        }
            
            //ljgg
            break;
        case NEVPNStatusConnecting:
        case NEVPNStatusReasserting:
            
            //正在连接中...
            
            //            _actionButton.enabled = YES;
            //            [_actionButton setTitle:@"Connecting..." forState:UIControlStateNormal];
            //            _activityIndicator.hidden = NO;
            //            [_activityIndicator startAnimating];
            break;
        case NEVPNStatusDisconnecting:
            
            //正在失去连接。。。
            //            _actionButton.enabled = NO;
            //            [_actionButton setTitle:@"Disconnecting..." forState:UIControlStateDisabled];
            //            _activityIndicator.hidden = NO;
            //            [_activityIndicator startAnimating];
            break;
        default:
            break;
    }
}



static NSString * const serviceName = @"im.zorro.ipsec_demo.vpn_config";

- (NSMutableDictionary *)newSearchDictionary:(NSString *)identifier {
    NSMutableDictionary *searchDictionary = [[NSMutableDictionary alloc] init];
    
    [searchDictionary setObject:(__bridge id)kSecClassGenericPassword forKey:(__bridge id)kSecClass];
    
    NSData *encodedIdentifier = [identifier dataUsingEncoding:NSUTF8StringEncoding];
    [searchDictionary setObject:encodedIdentifier forKey:(__bridge id)kSecAttrGeneric];
    [searchDictionary setObject:encodedIdentifier forKey:(__bridge id)kSecAttrAccount];
    [searchDictionary setObject:serviceName forKey:(__bridge id)kSecAttrService];
    
    return searchDictionary;
}


- (NSData *)searchKeychainCopyMatching:(NSString *)identifier {
    NSMutableDictionary *searchDictionary = [self newSearchDictionary:identifier];
    
    // Add search attributes
    [searchDictionary setObject:(__bridge id)kSecMatchLimitOne forKey:(__bridge id)kSecMatchLimit];
    
    // Add search return types
    // Must be persistent ref !!!!
    [searchDictionary setObject:@YES forKey:(__bridge id)kSecReturnPersistentRef];
    
    CFTypeRef result = NULL;
    SecItemCopyMatching((__bridge CFDictionaryRef)searchDictionary, &result);
    
    return (__bridge_transfer NSData *)result;
}

- (BOOL)createKeychainValue:(NSString *)password forIdentifier:(NSString *)identifier {
    NSMutableDictionary *dictionary = [self newSearchDictionary:identifier];
    
    OSStatus status = SecItemDelete((__bridge CFDictionaryRef)dictionary);
    
    NSData *passwordData = [password dataUsingEncoding:NSUTF8StringEncoding];
    [dictionary setObject:passwordData forKey:(__bridge id)kSecValueData];
    
    status = SecItemAdd((__bridge CFDictionaryRef)dictionary, NULL);
    
    if (status == errSecSuccess) {
        return YES;
    }
    return NO;
}

@end
