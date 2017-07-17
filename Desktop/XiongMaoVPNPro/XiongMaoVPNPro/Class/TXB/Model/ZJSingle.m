//
//  ZJSingle.m
//  tableView的多选
//
//  Created by James on 16/1/15.
//  Copyright © 2016年 James. All rights reserved.
//

#import "ZJSingle.h"

@implementation ZJSingle

- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)singleWithDict:(NSDictionary *)dict{
    
    return [[self alloc ]initWithDict:dict];
            
}

@end
