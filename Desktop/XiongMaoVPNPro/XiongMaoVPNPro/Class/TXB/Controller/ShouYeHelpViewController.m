//
//  ShouYeHelpViewController.m
//  XiongMaoJiaSu
//
//  Created by 唐晓波的电脑 on 16/5/27.
//  Copyright © 2016年 ISOYasser. All rights reserved.
//

#import "ShouYeHelpViewController.h"
#import "ZJSpreadCell.h"
#import "ZJSingle.h"

@interface ShouYeHelpViewController ()
@property (nonatomic, strong) NSArray             *dataArray;

@end

@implementation ShouYeHelpViewController
//隐藏uitabar底部栏
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"帮助中心";
    self.view.backgroundColor=[UIColor whiteColor];
    UIImage* backImage = [UIImage imageNamed:@"icon_back"];
    CGRect backframe = CGRectMake(0,0,14,18);
    UIButton* backButton= [[UIButton alloc] initWithFrame:backframe];
    [backButton setBackgroundImage:backImage forState:UIControlStateNormal];
    backButton.titleLabel.font=[UIFont systemFontOfSize:13];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
    
    UITableView * tv=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-10)];
    tv.delegate=self;
    tv.dataSource=self;
    [self.view addSubview:tv];
    
    
    // Do any additional setup after loading the view.
}

- (NSArray *)dataArray{
    if (!_dataArray) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"test.plist" ofType:nil];
        NSMutableArray *testArray = [[NSMutableArray alloc] initWithContentsOfFile:path];
        
        // 大的字典转成大的模型
        NSMutableArray *tempArray = [NSMutableArray array];
        for (int i = 0; i < testArray.count; i++)
        {
            ZJSingle *single = [ZJSingle singleWithDict:testArray[i]];
            
            // 添加到临时数组
            [tempArray addObject:single];
        }
        _dataArray = tempArray;
    }
    return  _dataArray;
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self setExtraCellLineHidden:tableView];
    
    ZJSpreadCell *cell;
    static NSString *ID = @"ZJSpreadCell";
    cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ZJSpreadCell" owner:nil options:nil] firstObject];
        
        cell.delegate = self;
        //设置cell点击无任何效果和背景色
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
   // cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    ZJSingle *single = self.dataArray[indexPath.row];
    
    cell.nameLable.text = single.title;
  
    
    cell.nameArray = single.name;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZJSingle *single = self.dataArray[indexPath.row];
    
    if (single.opened) {
        
        if(indexPath.row==2||indexPath.row==1||indexPath.row==3)
        {
            return (single.name.count + 1) * 50;
        }
        if(indexPath.row==0)
        {
            return (single.name.count + 1) * 60+10;
            
        }

         else return  (single.name.count + 1) * 40;
    }
    return 45;
    
    
    
//    ZJSingle *single = self.dataArray[indexPath.row];
//    
//    if (single.opened) {
//        if(indexPath.row==0||indexPath.row==2||indexPath.row==5)
//    {
//        return (single.name.count + 1) * 60;
//
//    }
//        else return  (single.name.count + 1) * 45;
//    }
//    return 45;
}

- ( CGFloat )tableView:( UITableView *)tableView heightForHeaderInSection:( NSInteger )section
{
    return 0.001;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ZJSingle *single = self.dataArray[indexPath.row];
    single.opened = !single.opened;
    
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
    /**设置图片箭头旋转*/
    ZJSpreadCell *cell = (ZJSpreadCell*)[tableView cellForRowAtIndexPath:indexPath];
    [cell setArrowImageViewWhitIfUnfold:single.opened];
    
    [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

#pragma mark -- ZJSpreadCellDelegate
-(void)ZJSpreadCellDidSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"点击cell要做的事情");
    
}

@end
