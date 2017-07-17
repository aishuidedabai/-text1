//
//  XMBoardBTN.m
//  XiongMaoJiaSu
//
//  Created by ISOYasser on 16/5/25.
//  Copyright © 2016年 ISOYasser. All rights reserved.
//

#import "XMBoardBTN.h"

@implementation XMBoardBTN


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    if (self.masksToBounds) {
        if (self.cornerRadius) {
            self.layer.cornerRadius = self.cornerRadius;
        } else {
            //            self.layer.cornerRadius = 10;
        }
    } else {
        self.layer.cornerRadius = 0;
    }
    
    if (self.boardEnable) {
        if (self.boardWith) {
            self.layer.borderWidth = self.boardWith;
        } else {
            self.layer.borderWidth = 1;
        }
    } else {
        self.layer.borderWidth = 0;
    }
    
    if (self.boardColor) {
        self.layer.borderColor = self.boardColor.CGColor;
    } else {
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    }

}

@end
