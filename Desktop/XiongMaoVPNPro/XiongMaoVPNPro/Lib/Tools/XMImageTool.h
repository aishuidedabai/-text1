//
//  XMImageTool.h
//  XiongMaoJiaSu
//
//  Created by ISOYasser on 16/6/14.
//  Copyright © 2016年 ISOYasser. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface XMImageTool : NSObject

+ (void) return_image_url:(NSString *) image_url shareimage:(void (^)(UIImage * image))shareImage;

@end
