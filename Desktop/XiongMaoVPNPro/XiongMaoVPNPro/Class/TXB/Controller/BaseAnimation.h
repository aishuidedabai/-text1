//
//  BaseAnimation.h
//  AUtoLayOut
//
//  Created by 繁漪不绝_妖花绽放 on 15/11/12.
//  Copyright © 2015年 繁漪不绝_妖花绽放. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface BaseAnimation : NSObject
<
UIViewControllerAnimatedTransitioning
>

@property(nonatomic)NSTimeInterval transitionDuration;

-(void)animateTransitionEvent;


@property(nonatomic,weak)UIViewController *fromViewController;

@property(nonatomic,weak)UIViewController *toViewController;

@property(nonatomic,readonly,weak)UIView *containerView;


-(void)comPleteTransiTion;

@end
