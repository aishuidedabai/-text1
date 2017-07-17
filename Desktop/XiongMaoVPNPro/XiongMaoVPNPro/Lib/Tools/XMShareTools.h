//
//  XMShareTools.h
//  XiongMaoVPNPro
//
//  Created by ISOYasser on 16/6/18.
//  Copyright © 2016年 ISOYasser. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <UMSocial.h>

@interface XMShareTools : NSObject

+ (void)shareName:(NSString *)name AppId:(NSString *) AppId appSecret:(NSString *) appSecret controller:(UIViewController *) vc shareTag:(NSInteger) tag;

@end
