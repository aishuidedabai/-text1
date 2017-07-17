//
//  XMShare_Info_Model.h
//  XiongMaoJiaSu
//
//  Created by ISOYasser on 16/6/6.
//  Copyright © 2016年 ISOYasser. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMShare_Info_Model : NSObject<NSCopying>

@property (nonatomic, strong) NSString * platform;

@property (nonatomic, strong) NSString * img;

@property (nonatomic, strong) NSString * url;

@property (nonatomic, strong) NSString * title;

@property (nonatomic, strong) NSString * desc;

- (instancetype) initWithDic:(NSDictionary *)dic;

+ (instancetype) shareWithDic:(NSDictionary *)dic;

@end
