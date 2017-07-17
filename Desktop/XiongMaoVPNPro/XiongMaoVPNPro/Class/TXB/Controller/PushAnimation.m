//
//  PushAnimation.m
//  PopPush
//
//  Created by 繁漪不绝_妖花绽放 on 15/11/12.
//  Copyright © 2015年 繁漪不绝_妖花绽放. All rights reserved.
//

#import "PushAnimation.h"

@implementation PushAnimation


-(void)animateTransitionEvent{
    
    [self.containerView addSubview:self.toViewController.view];
    self.toViewController.view.                                alpha     = 1.f;
    self.toViewController.view.                                frame     = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [UIView animateWithDuration:0.5
                          delay:0.0f
         usingSpringWithDamping:1
          initialSpringVelocity:0.f
                        options:0
                     animations:^{
//                        self.fromViewController.view.          frame     = CGRectMake(self.fromViewController.view.frame.origin.x+20, self.fromViewController.view.frame.origin.y+20, self.fromViewController.view.frame.size.width-40, self.fromViewController.view.frame.size.height-40);
                         self.fromViewController.view.         transform = CGAffineTransformMake(0.75, 0, 0, 0.75, 0, 0);
                             NSLog(@"%@",self.fromViewController);
                         [UIView animateWithDuration:0.5 animations:^{
                             //  改变第二个控制器frame
                             [UIView setAnimationDelay:0.5];
                             self.toViewController.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
                             self.toViewController.view.transform = CGAffineTransformMake(0.75, 0, 0, 0.75, 0, 0);
                         } completion:^(BOOL finished) {
                            [UIView animateWithDuration:0.5 animations:^{
                                self.toViewController.view.transform = CGAffineTransformMake(1, 0, 0, 1, 0, 0);
                                self.toViewController.view.    frame     = [UIScreen mainScreen].bounds;
                                self.fromViewController.view.  transform = CGAffineTransformMake(1, 0, 0, 1, 0, 0);
                            }];
                         }];
                         
                        } completion:^(BOOL finished) {
                            [UIView setAnimationDelay:1];
                            [self performSelector:@selector(comPleteTransiTion) withObject:nil afterDelay:1];
//                            [self comPleteTransiTion];
            }];
    
}

@end
