//
//  NSObject+XMCountExtension.m
//  PersonDemo
//
//  Created by ISOYasser on 16/6/22.
//  Copyright © 2016年 ISOYasser. All rights reserved.
//

#import "NSObject+XMCountExtension.h"

@implementation NSObject (XMCountExtension)

+ (int) returnCountOpen{
    int number = 0;
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"key"]) {
        NSString * count = [[NSUserDefaults standardUserDefaults] objectForKey:@"key"];
        number = [count intValue] + 1;
    }else{
        number++;
    }
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",number] forKey:@"key"];
    return number;
}

@end
