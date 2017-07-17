//
//  ZJSpreadCell.m
//  tableView的多选
//
//  Created by James on 16/1/18.
//  Copyright © 2016年 James. All rights reserved.
//

#import "ZJSpreadCell.h"
#import "HelpTableViewCell.h"
@interface ZJSpreadCell()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation ZJSpreadCell

- (void)awakeFromNib {
    self.tableView.scrollEnabled = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.nameArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"ZJSpreadCell";
    
    HelpTableViewCell * cell = [[HelpTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    
    if(indexPath.row==0||indexPath.row==2||indexPath.row==5)
    {
        cell.lb.text = self.nameArray[indexPath.row];
        cell.lb.textColor=[UIColor colorWithRed:0.590196 green:0.590196 blue:0.5941176 alpha:1];
        cell.lb.font=[UIFont systemFontOfSize:13.f];
        cell.lb.frame=CGRectMake(25, 5, [UIScreen mainScreen].bounds.size.width-40,70);
    }
    else{
        
        cell.lb.frame=CGRectMake(25, 5, [UIScreen mainScreen].bounds.size.width-40,60);
        cell.lb.text= self.nameArray[indexPath.row];
        cell.lb.textColor=[UIColor colorWithRed:0.590196 green:0.590196 blue:0.5941176 alpha:1];
        cell.lb.font=[UIFont systemFontOfSize:13.f];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;//设置cell点击效果（无显示）
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    return cell;
}


/**
 *  代理方法通知外界选中了哪个cell
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 通知代理
    if ([self.delegate respondsToSelector:@selector(ZJSpreadCellDidSelectRowAtIndexPath:)]) {
        [self.delegate ZJSpreadCellDidSelectRowAtIndexPath:indexPath];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if(indexPath.row==0||indexPath.row==2||indexPath.row==5)
//    {
//    return 130;
//    }
   // else
    return 60;
}

/**
 *   设置图片箭头旋转
 */
-(void)setArrowImageViewWhitIfUnfold:(BOOL)unfold
{
    double degree;
    if(unfold){
        degree = M_PI_2;
    }
    else{
        degree = 0;
    }
    
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        _arrowImageView.layer.transform = CATransform3DMakeRotation(degree, 0, 0, 1);
    } completion:NULL];
}
@end
