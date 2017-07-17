//
//  MainViewController.h
//  DrawerDemo
//
//  Created by lanou3g on 15/12/14.
//  Copyright © 2015年 syx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMShareView.h"


@interface MainViewController : UIViewController
@property (nonatomic,strong) UITableView * tableView;

/**
 *  分享View
 */
@property (nonatomic, strong) XMShareView * shareView;
/**
 *  分享View是否消失
 */
@property (nonatomic, assign) BOOL share_is;

-(void) huoquipValue:(void (^)(NSString * value))shareValue;


-(void)kaishilianjie;


@end
