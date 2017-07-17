//
//  MainViewController+XMShareExtension.m
//  XiongMaoVPNPro
//
//  Created by ISOYasser on 16/6/18.
//  Copyright © 2016年 ISOYasser. All rights reserved.
//

#import "MainViewController+XMShareExtension.h"
#import "XMShareTools.h"
#import <UMSocial.h>
#import "BuyViewController.h"

@interface MainViewController (XMShareExtension)<XMShareViewDelegate>

@end

@implementation MainViewController (XMShareExtension)

#pragma mrk ------- 视图toucnsBegan方法，让分享视图消失
- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.share_is =!self.share_is;
    [self shareViewDismiss];

}

#pragma mark --- 分享视图首先在底部
- (void) showWillShareView{
    CGFloat share_Y = [UIScreen mainScreen].bounds.size.height;
    XMShareView * shareViewv = [[[NSBundle mainBundle] loadNibNamed:@"ShareView" owner:nil options:nil]lastObject];
    shareViewv.frame = CGRectMake(0, share_Y, [UIScreen mainScreen].bounds.size.width, 250);
    self.shareView = shareViewv;
    shareViewv.delegate = self;
    [self.view addSubview:shareViewv];
}


#pragma mark ------ 分享视图消失
- (void) shareViewDismiss{
    [UIView animateWithDuration:0.5 animations:^{
        CGFloat share_Y = [UIScreen mainScreen].bounds.size.height;
        self.shareView.frame = CGRectMake(0, share_Y, [UIScreen mainScreen].bounds.size.width, 250);
    } completion:^(BOOL finished) {
        
    }];
}
#pragma mark ------ 分享动画出现
- (void) showshareView{
    self.share_is = !self.share_is;
    if (self.share_is) {
        [UIView animateWithDuration:0.5 animations:^{
            CGFloat share_Y = [UIScreen mainScreen].bounds.size.height-300;
            self.shareView.frame = CGRectMake(0, share_Y, [UIScreen mainScreen].bounds.size.width, 250);
        } completion:^(BOOL finished) {
            
        }];
    }else{
        [self shareViewDismiss];
    }
}

#pragma mark ------ 消失分享动画
- (void) disMissShareViewToBotton{
    self.share_is =!self.share_is;
    [self shareViewDismiss];
}

- (void) shareClickName:(NSString *) shareName shareId:(NSString *) shareId shareKey:(NSString *) shareKey  shareTag:(NSInteger) tag{
    [XMShareTools shareName:shareName AppId:shareId appSecret:shareKey controller:self shareTag:tag];
}

@end
