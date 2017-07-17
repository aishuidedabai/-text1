//
//  EncryptAndEcode.h
//  XiongMaoJiaSu
//
//  Created by 唐晓波的电脑 on 16/6/7.
//  Copyright © 2016年 ISOYasser. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EncryptAndEcode : NSObject

+(void)httpUrl:(NSString *)url AndPostparameters:(NSDictionary *)parameters block:(void(^)(NSDictionary* responseObject))block;
@end
