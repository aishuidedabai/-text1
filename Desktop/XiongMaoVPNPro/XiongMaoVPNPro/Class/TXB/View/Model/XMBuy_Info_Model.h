//
//  XMBuy_Info_Model.h
//  XiongMaoJiaSu
//
//  Created by ISOYasser on 16/6/6.
//  Copyright © 2016年 ISOYasser. All rights reserved.
//
/**
 *   [title] => 周卡会员
 [days] => 7
 [price] => 9.00
 [code] => month_07
 */
#import <Foundation/Foundation.h>

@interface XMBuy_Info_Model : NSObject

@property(nonatomic, strong) NSString * title;

@property (nonatomic, strong) NSString * days;

@property (nonatomic, strong) NSString * price;

@property (nonatomic, strong) NSString * code;

@property (nonatomic, strong) NSString * price2;

+ (instancetype) buyWithDic:(NSDictionary *)dic;
@end
