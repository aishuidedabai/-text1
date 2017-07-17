//
//  ZJSingle.h
//  tableView的多选
//
//  Created by James on 16/1/15.
//  Copyright © 2016年 James. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJSingle : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) NSArray *name;

@property (nonatomic, assign, getter = isOpened) BOOL opened;

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)singleWithDict:(NSDictionary *)dict;

@end
