//
//  XMShareView.h
//  XiongMaoVPNPro
//
//  Created by ISOYasser on 16/6/18.
//  Copyright © 2016年 ISOYasser. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XMShareViewDelegate <NSObject>

- (void) shareClickName:(NSString *) shareName shareId:(NSString *) shareId shareKey:(NSString *) shareKey shareTag:(NSInteger) tag;

- (void) disMissShareViewToBotton;

@end

@interface XMShareView : UIView

@property (nonatomic, weak) id<XMShareViewDelegate> delegate;

@end
