//
//  XMBuyLabel.m
//  XiongMaoJiaSu
//
//  Created by ISOYasser on 16/5/26.
//  Copyright © 2016年 ISOYasser. All rights reserved.
//

#import "XMBuyLabel.h"

@implementation XMBuyLabel

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

+ (void)showLabel:(UIView *)superView info:(NSString *)info
{
    UILabel *tipLabel = [[UILabel alloc] init];
    [superView addSubview:tipLabel];
    tipLabel.backgroundColor = [UIColor whiteColor];
    tipLabel.textColor = [UIColor whiteColor];
    
    tipLabel.text = [NSString stringWithFormat:info];
    
    //frame
    CGFloat tipW = 180;
    CGFloat tipH = 40;
    CGFloat tipX = (superView.frame.size.width - tipW)/2;
    CGFloat tipY = (superView.frame.size.height - tipH)/2 ;
    tipLabel.frame = CGRectMake(tipX, tipY, tipW, tipH);
    
    //属性
    tipLabel.textAlignment = NSTextAlignmentCenter;
    //    tipLabel.backgroundColor = [UIColor grayColor];
    
    //圆角
    tipLabel.layer.cornerRadius = 5;
    tipLabel.layer.masksToBounds = YES;
    tipLabel.backgroundColor = [UIColor grayColor];
    
    tipLabel.font = [UIFont fontWithName:@"PingFang" size:14];
    
    [UIView animateWithDuration:1.0 animations:^{
        tipLabel.alpha = 1; 
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.3 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            tipLabel.alpha = 0;
        } completion:^(BOOL finished) {
            [tipLabel removeFromSuperview];
        }];
    }];
}


@end