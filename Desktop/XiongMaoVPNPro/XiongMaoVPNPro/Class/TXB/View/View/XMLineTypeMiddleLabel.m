//
//  XMLineTypeMiddleLabel.m
//  XiongMaoJiaSu
//
//  Created by ISOYasser on 16/5/24.
//  Copyright © 2016年 ISOYasser. All rights reserved.
//

#import "XMLineTypeMiddleLabel.h"

@implementation XMLineTypeMiddleLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawTextInRect:(CGRect)rect{
    [super drawTextInRect:rect];
    
    CGSize textSize = [[self text] sizeWithFont:[self font]];
    CGFloat strikeWidth = textSize.width;
    CGRect lineRect;
    CGFloat origin_x;
    CGFloat origin_y;
    
    origin_x = (rect.size.width - strikeWidth)/2 ;
    
    origin_y =  rect.size.height/2;
    
    lineRect = CGRectMake(origin_x , origin_y, strikeWidth, 1);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextFillRect(context, lineRect);
    
}


@end
