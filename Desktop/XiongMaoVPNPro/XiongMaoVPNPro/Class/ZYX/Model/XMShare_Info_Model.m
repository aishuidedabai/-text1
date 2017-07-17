//
//  XMShare_Info_Model.m
//  XiongMaoJiaSu
//
//  Created by ISOYasser on 16/6/6.
//  Copyright © 2016年 ISOYasser. All rights reserved.
//
/*
 @property (nonatomic, strong) NSString * platform;
 
 @property (nonatomic, strong) NSString * img;
 
 @property (nonatomic, strong) NSString * title;
 
 @property (nonatomic, strong) NSString * desc;
 */

#import "XMShare_Info_Model.h"
#import "MJExtension.h"

@implementation XMShare_Info_Model

- (instancetype) initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        //        [self setValuesForKeysWithDictionary:dic];
        self.platform = dic[@"platform"];
        self.img = dic[@"img"];
        self.title = dic[@"title"];
        self.desc = dic[@"desc"];
        self.url = dic[@"url"];
    }
    return self;
}

+ (instancetype) shareWithDic:(NSDictionary *)dic
{
    return [[self alloc]initWithDic:dic];
}

MJCodingImplementation

@end
