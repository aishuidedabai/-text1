//
//  XMImageTool.m
//  XiongMaoJiaSu
//
//  Created by ISOYasser on 16/6/14.
//  Copyright © 2016年 ISOYasser. All rights reserved.
//

#import "XMImageTool.h"
#import "SDWebImageManager.h"

@implementation XMImageTool

+ (void) return_image_url:(NSString *) image_url shareimage:(void (^)(UIImage * image))shareImage{
    SDWebImageManager *sdManager = [SDWebImageManager sharedManager];
    if (![sdManager diskImageExistsForURL:[NSURL URLWithString:image_url]]) {
        [sdManager downloadWithURL:[NSURL URLWithString:image_url]
                           options:0
                          progress:nil
                         completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished) {
                             if (image) {
                                 SDImageCache *cache = [SDImageCache sharedImageCache];
                                 [cache storeImage:image forKey:image_url];
                                 shareImage(image);
                             }
                         }];
    }else{
        SDImageCache * imageCache = [SDImageCache sharedImageCache];
//        UIImage * iamge = [imageCache imageFromDiskCacheForKey:image_url];
//        return [imageCache imageFromDiskCacheForKey:image_url];
        shareImage([imageCache imageFromDiskCacheForKey:image_url]);
    }
}

@end
