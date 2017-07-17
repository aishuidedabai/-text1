//
//  ZJSpreadCell.h
//  tableView的多选
//
//  Created by James on 16/1/18.
//  Copyright © 2016年 James. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  ZJSpreadCellDelegate <NSObject>

@optional

-(void)ZJSpreadCellDidSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface ZJSpreadCell : UITableViewCell

@property (nonatomic,weak) id<ZJSpreadCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

/**名字的label*/
@property (weak, nonatomic) IBOutlet UILabel *nameLable;

/**旋转的箭头图片*/
@property (weak, nonatomic) IBOutlet UIImageView *arrowImageView;

/**分组的数组*/
@property(strong,nonatomic)NSArray * nameArray;

/**设置图片箭头旋转*/
-(void)setArrowImageViewWhitIfUnfold:(BOOL)unfold;

@end
