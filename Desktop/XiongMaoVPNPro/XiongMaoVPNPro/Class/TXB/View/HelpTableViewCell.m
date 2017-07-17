//
//  HelpTableViewCell.m
//  XiongMaoJiaSu
//
//  Created by 唐晓波的电脑 on 16/5/30.
//  Copyright © 2016年 ISOYasser. All rights reserved.
//

#import "HelpTableViewCell.h"

@implementation HelpTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.contentView.backgroundColor = [UIColor whiteColor];


    self.lb = [[UITextView alloc]initWithFrame:CGRectMake(25, -100, [UIScreen mainScreen].bounds.size.width-40,1)];
    self.lb.userInteractionEnabled=NO;
  
    [self.contentView addSubview:self.lb];

    
    
    return self;
}

@end
