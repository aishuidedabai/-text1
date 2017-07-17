//
//  XMShareView.m
//  XiongMaoVPNPro
//
//  Created by ISOYasser on 16/6/18.
//  Copyright © 2016年 ISOYasser. All rights reserved.
//

#import "XMShareView.h"
#import <UMSocial.h>


@interface XMShareView ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *space_weixin_pengyouquan;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *space_pengyouquan_qq;
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *space_qq_kongjian;
/**
 *  存放分享平台名称
 */
@property (nonatomic, strong) NSArray * share_Array;
/**
 *  存放分享平台的id
 */
@property (nonatomic, strong) NSArray * id_Array;
/**
 *  存放分享平台的key
 */
@property (nonatomic, strong) NSArray * key_Array;


@end

@implementation XMShareView


- (void) layoutSubviews{
    
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    CGFloat space_one = (screenW - 40 - 60 * 4)/3.0;
    self.space_weixin_pengyouquan.constant = space_one;
    self.space_pengyouquan_qq.constant = space_one;
}

- (NSArray *) share_Array{
    if (!_share_Array) {
        _share_Array = @[@"UMShareToWechatSession",@"UMShareToWechatTimeline",@"UMShareToQQ",@"UMShareToQzone"];
    }
    return _share_Array;
}

- (NSArray *) id_Array{
    if (!_id_Array) {
        _id_Array = @[WetChatAppId,WetChatAppId,ShareQQAppID,ShareQQAppID];
    }
    return _id_Array;
}

- (NSArray *)key_Array{
    if (!_key_Array) {
        _key_Array = @[WetChatAppSecret,WetChatAppSecret,ShareQQAppKey,ShareQQAppKey];
    }
    return _key_Array;
}


- (IBAction)shareClick:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(shareClickName:shareId:shareKey:shareTag:)]) {
        
        [self.delegate  shareClickName:self.share_Array[sender.tag] shareId:self.id_Array[sender.tag] shareKey:self.key_Array[sender.tag] shareTag:sender.tag];
    }
}

- (IBAction)dissmisShareView:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(disMissShareViewToBotton)]) {
        [self.delegate disMissShareViewToBotton];
    }
}


@end
