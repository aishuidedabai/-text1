//
//  XMShareTools.m
//  XiongMaoVPNPro
//
//  Created by ISOYasser on 16/6/18.
//  Copyright © 2016年 ISOYasser. All rights reserved.
//

#import "XMShareTools.h"
#import "EncryptAndEcode.h"
#import "XMShare_Info_Model.h"
#import "XMImageTool.h"
#import <UMSocial.h>
#import <UMSocialQQHandler.h>

@implementation XMShareTools


+ (void)shareName:(NSString *)name AppId:(NSString *) AppId appSecret:(NSString *) appSecret controller:(UIViewController *) vc  shareTag:(NSInteger) tag{
    XMShare_Info_Model * share_info_model = [[XMShare_Info_Model alloc]init];
    share_info_model.url = @"http://www.xiongmao888.com/";
    share_info_model.desc = @"熊猫vpn做最快速的手游加速";
    share_info_model.img = @"http://www.xiongmao999.com/Statics/upload/logo.png";
    share_info_model.title = @"熊猫vpn欢迎您的加入";
    share_info_model.platform = @"WEIXIN";
    NSMutableArray * info_array = [NSMutableArray array];
    [info_array addObject:share_info_model];
    [NSKeyedArchiver archiveRootObject:info_array toFile:shareFilePaht];
    NSDictionary * parameters = @{@"device_type":@"IPHONE",@"hardware_sn":SHEBEIHAO};
    [EncryptAndEcode httpUrl:@"http://api.xiongmaoapi.com/api/xiongmao/get_share_info/" AndPostparameters:parameters block:^(NSDictionary *responseObject) {
        
        NSArray * shard_array = responseObject[@"list"];
        if (!shard_array) {
            NSDictionary * share_dic = shard_array[tag];
            
            XMShare_Info_Model * share_i_model = [XMShare_Info_Model shareWithDic:share_dic];
            //TODO: 归档
            NSMutableArray * info_array = [NSMutableArray array];
            [info_array addObject:share_i_model];
            
            [NSKeyedArchiver archiveRootObject:info_array toFile:shareFilePaht];
        }else{
            
        }
        
    }];
    //TODO: 解档
    NSArray * array = [NSKeyedUnarchiver unarchiveObjectWithFile:shareFilePaht];
    share_info_model = [array lastObject];
    
    //需要自定义面板样式的开发者需要自己绘制UI，在对应的分享按钮中调用此接口
    __weak typeof(self) weakSelf = self;
    [UMSocialData defaultData].extConfig.title = share_info_model.title;
    [XMImageTool return_image_url:share_info_model.img shareimage:^(UIImage *image) {
        if ([name isEqualToString:@"UMShareToQQ"]) {
            [UMSocialData defaultData].extConfig.qqData.url = share_info_model.url;
            [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToQQ] content:share_info_model.desc image:image location:nil urlResource:nil presentedController:vc completion:^(UMSocialResponseEntity *shareResponse){
                if (shareResponse.responseCode == UMSResponseCodeSuccess) {
                    [weakSelf shareResult:share_info_model.platform];
                }
            }];
            
        }else if ([name isEqualToString:@"UMShareToQzone"]){
            [UMSocialData defaultData].extConfig.qzoneData.url = share_info_model.url;
            [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToQzone] content:share_info_model.desc image:image location:nil urlResource:nil presentedController:vc completion:^(UMSocialResponseEntity *shareResponse){
                if (shareResponse.responseCode == UMSResponseCodeSuccess) {
                    [weakSelf shareResult:share_info_model.platform];
                }
            }];
            
        }else if ([name isEqualToString:@"UMShareToWechatSession"]){
            [UMSocialData defaultData].extConfig.wechatSessionData.url = share_info_model.url;
            [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatSession] content:share_info_model.desc image:image location:nil urlResource:nil presentedController:vc completion:^(UMSocialResponseEntity *shareResponse){
                if (shareResponse.responseCode == UMSResponseCodeSuccess) {
                    [weakSelf shareResult:share_info_model.platform];
                }
            }];
        }else{
            [UMSocialData defaultData].extConfig.wechatTimelineData.url = share_info_model.url;
            [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatTimeline] content:share_info_model.desc image:image location:nil urlResource:nil presentedController:vc completion:^(UMSocialResponseEntity *shareResponse){
                if (shareResponse.responseCode == UMSResponseCodeSuccess) {
                    [weakSelf shareResult:share_info_model.platform];
                }
            }];
        }
    }];
    
}

- (void) shareResult:(NSString *) platform{
    NSDictionary * dic = @{@"device_type":@"IPHONE",@"hardware_sn":SHEBEIHAO,@"platform":platform};
    NSLog(@"%@",dic);
    [EncryptAndEcode httpUrl:@"http://api.xiongmaoapi.com/api/xiongmao/share_success/" AndPostparameters:dic block:^(NSDictionary *responseObject) {
        if (![responseObject[@"success"] boolValue]) {
//            NSString * info_share = responseObject[@"msg"];
            //                                                                          NSLog(@"%@",responseObject);
//            [self makeUserAlert:info_share];
        }
        
    }];
}

@end
