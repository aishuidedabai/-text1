//
//  BaseAnimation.m
//  AUtoLayOut
//
//  Created by 繁漪不绝_妖花绽放 on 15/11/12.
//  Copyright © 2015年 繁漪不绝_妖花绽放. All rights reserved.
//

#import "BaseAnimation.h"

@interface BaseAnimation()

@property(nonatomic,weak)id<UIViewControllerContextTransitioning>   transtionContext;

//@property(nonatomic,weak)UIViewController                          *fromViewController;

//@property(nonatomic,weak)UIViewController                          *toVeiwController;

@property(nonatomic,weak)UIView                                    *containerView;

@end


@implementation BaseAnimation
-(instancetype)init
{
    self = [super init];
    if (self) {
        [self deafultSet];
    }
    return self;
}

-(void)deafultSet{
    _transitionDuration = 1.0f;
}


-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return _transitionDuration;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    self.fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    self.toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    NSLog(@"%@, %@", self.fromViewController, self.toViewController);
    self.containerView = self.fromViewController.view.superview;
    self.transtionContext = transitionContext;
    [self animateTransitionEvent];
}

-(void)animateTransitionEvent{
    
}

-(void)comPleteTransiTion{
    NSLog(@"调用了");
    [self.transtionContext completeTransition:!self.transtionContext.transitionWasCancelled];
}






@end
