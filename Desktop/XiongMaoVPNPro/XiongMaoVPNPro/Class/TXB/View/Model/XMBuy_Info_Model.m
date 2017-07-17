//
//  XMBuy_Info_Model.m
//  XiongMaoJiaSu
//
//  Created by ISOYasser on 16/6/6.
//  Copyright © 2016年 ISOYasser. All rights reserved.
//
/**
 [title] => 周卡会员
 [days] => 7
 [price] => 9.00
 [code] => month_07
 [price2] => 12
 */
#import "XMBuy_Info_Model.h"

@implementation XMBuy_Info_Model

- (instancetype) initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        //        [self setValuesForKeysWithDictionary:dic];
        self.title = dic[@"title"];
        self.days = dic[@"days"];
        self.price = dic[@"price"];
        self.code = dic[@"code"];
        self.price2 = dic[@"price2"];
    }
    return self;
}
+ (instancetype) buyWithDic:(NSDictionary *)dic
{
    return [[self alloc]initWithDic:dic];
}


@end
