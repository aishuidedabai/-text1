//
//  PopAnimation.m
//  PopPush
//
//  Created by 繁漪不绝_妖花绽放 on 15/11/12.
//  Copyright © 2015年 繁漪不绝_妖花绽放. All rights reserved.
//

#import "PopAnimation.h"

@implementation PopAnimation


-(void)animateTransitionEvent{
    
    [self.containerView addSubview:self.fromViewController.view];
    [UIView animateWithDuration:0.5
                          delay:0.0f
         usingSpringWithDamping:1
          initialSpringVelocity:0.f
                        options:0.0
                     animations:^{

                         [UIView animateWithDuration:0.5 animations:^{
                             self.fromViewController.view.transform = CGAffineTransformMake(0.75, 0, 0, 0.75, 0, 0);
                             self.toViewController.view.transform = CGAffineTransformMake(0.75, 0, 0, 0.75, 0, 0);
                         } completion:^(BOOL finished) {
                            [self.containerView addSubview:self.toViewController.view];
                             self.toViewController.view.alpha = 0.0f;
                             [UIView animateWithDuration:0.5 animations:^{
                                   self.fromViewController.view.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
                                 self.toViewController.view.alpha = 1.0f;
                             }];
                             [UIView animateWithDuration:0.5 animations:^{
                                 self.toViewController.view.transform = CGAffineTransformMake(1, 0, 0, 1, 0, 0);
                             }];
                         }];
                     } completion:^(BOOL finished) {
                         [self performSelector:@selector(comPleteTransiTion) withObject:nil afterDelay:2];
                     }];
    
    
    
}

@end
