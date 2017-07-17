//
//  AlertView.m
//  UIalertView
//
//  Created by apple on 16/5/10.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "AlertView.h"
#import "AppDelegate.h"
#import "LXAlertView.h"
#import "BuyViewController.h"
#import "MainViewController.h"
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define ScreenBounds [UIScreen mainScreen].bounds
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)


@interface AlertView()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIView *backView;
@property (nonatomic,strong) UISegmentedControl * segmentControl;


@end

@implementation AlertView
{
    AppDelegate * delegate;
}


+(id)GlodeBottomView{
    return [self new];
}

+ (AlertView *)sharedManager {
    static AlertView *sharedAccountManagerInstance = nil;
    
    static dispatch_once_t predicate; dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[self alloc] init];
    });
    
    return sharedAccountManagerInstance;
    
}



-(void)show{
    UIWindow *current = [UIApplication sharedApplication].keyWindow;
    self.backgroundColor = RGBA(0, 0, 0, 0.2);
    [current addSubview:self];
    
    [UIView animateWithDuration:0.3 animations:^{
        [UIView setAnimationCurve:(UIViewAnimationCurveEaseOut)];
        self.backView.frame = CGRectMake(10, 0, ScreenWidth-20, ScreenHeight);
    }];
}

#pragma mark - 懒加载
-(UIView*)backView{
    if (_backView == nil) {
        self.backView = [UIView new];
        _backView.bounds = CGRectMake(10,0, ScreenWidth-20, ScreenHeight);
        [self addSubview:_backView];
    }
    return _backView;
}

-(UILabel*)titleLabel{
    if (_titleLabel == nil) {
        self.titleLabel = [UILabel new];
        _titleLabel.bounds = CGRectMake(50, 0, ScreenWidth - 100, ScreenHeight);
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textColor = RGB(83, 83, 83);
        [_backView addSubview:_titleLabel];
    }
    return _titleLabel;
}


//隐藏线条
-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}
-(void)setTitleArray:(NSArray *)titleArray{
    _titleArray = titleArray;
    [self setExtraCellLineHidden: self.tableView];
      m=0;
    if (titleArray.count * 50 >= (ScreenHeight *3/4)) {
        self.backView.frame = CGRectMake(10, ScreenHeight *1/3, ScreenWidth-20, ScreenHeight);
        self.tableView.frame = CGRectMake(10, ScreenHeight *1/3-250, ScreenWidth-20, ScreenHeight -2*(ScreenHeight *1/3-150));
       // self.titleLabel.center = CGPointMake(ScreenWidth/2, ScreenHeight *1/3);
        
    }else{
        
        self.backView.frame = CGRectMake(10, 30, ScreenWidth-20, ScreenHeight);
        self.tableView.frame = CGRectMake(10,  30 , ScreenWidth-20, ScreenHeight -60);//tableview坐标
       // self.titleLabel.center = CGPointMake(ScreenWidth/2, ScreenHeight -  titleArray.count * 50);
    }

      [_tableView reloadData];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dissMIssView];
}
-(void)willMoveToSuperview:(UIView *)newSuperview{
    self.frame = ScreenBounds;
    [self setUpCellSeparatorInset];
}
- (void)setUpCellSeparatorInset
{
//    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
//        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
//    }
//    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
//        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
//    }
}

-(void)dissMIssView{
 [UIView animateWithDuration:0.3 animations:^{
     [UIView setAnimationCurve:(UIViewAnimationCurveEaseIn)];
     self.backView.frame = CGRectMake(20, ScreenHeight, ScreenWidth-40, ScreenHeight);
}completion:^(BOOL finished) {
    [self removeFromSuperview];
   }];
}


#pragma UITableView-delegate

-(UITableView*)tableView{
    if (_tableView == nil) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(50, 0, ScreenWidth-100, ScreenHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.layer.cornerRadius=10;
        _tableView.layer.masksToBounds=YES;
        [self.backView addSubview:_tableView];
    }
    return _tableView;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    delegate =[UIApplication sharedApplication].delegate;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = _titleArray[indexPath.row];
    cell.textLabel.font=[UIFont systemFontOfSize:15.f];
    cell.textLabel.frame = CGRectMake(50, 0, ScreenWidth-100, ScreenHeight);
    if(indexPath.row==1)
    {
        if(m==0||m==1)
        {
      cell.imageView.image=[UIImage imageNamed:@"home_meiguo"];
        }
        else  cell.imageView.image=[UIImage imageNamed:@"line_xinjiapo"];

    }

    if(indexPath.row==2)
    {
        if(m==0||m==1)
        {
            cell.imageView.image=[UIImage imageNamed:@"home_hanguo"];
        }
        else  cell.imageView.image=[UIImage imageNamed:@"home_xianggang"];
        
        
    }
    if(indexPath.row==3)
    {
        if(m==0||m==1)
        {
             cell.imageView.image=[UIImage imageNamed:@"home_riben"];
        }
        else  cell.imageView.image=[UIImage imageNamed:@"home_taiwan"];
       
    }
    if(indexPath.row==4)
    {
        cell.userInteractionEnabled = NO;
         cell.textLabel.font=[UIFont systemFontOfSize:17.f];
    }
    if(indexPath.row==0)
    {
         cell.textLabel.font=[UIFont systemFontOfSize:17.f];
        cell.userInteractionEnabled = NO;
    }
    if(indexPath.row==5)
    {
        cell.imageView.image=[UIImage imageNamed:@"line_xinjiapo"];
    }
    if(indexPath.row==6)
    {
        cell.imageView.image=[UIImage imageNamed:@"home_xianggang"];
    }
    if(indexPath.row==7)
    {
        cell.imageView.image=[UIImage imageNamed:@"home_taiwan"];
    }
    if(indexPath.row>=5)
    {
      UIImage *image= [UIImage imageNamed:@"line_charge"];
      UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
      CGRect frame = CGRectMake(0.0, 0.0, image.size.width, image.size.height);
      button.frame = frame;
      [button setBackgroundImage:image forState:0];
      button.backgroundColor= [UIColor clearColor];
      cell.accessoryView= button;
    }
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 100;
//}

//头部添加按钮
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 80;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, 0, ScreenWidth-20, 80)];
    view.backgroundColor = [UIColor whiteColor];
    [self.backView addSubview:view];
    NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:@"全部"];
    NSRange messageRange = {0,[message length]};
    [message addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:messageRange];
    
    NSMutableAttributedString * telephone = [[NSMutableAttributedString alloc]initWithString:@"免费"];
    NSRange telephoneRange = {0,[telephone length]};
    [message addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:telephoneRange];
    
    NSMutableAttributedString *message1 = [[NSMutableAttributedString alloc] initWithString:@"收费"];
    NSRange messageRange1 = {0,[message1 length]};
    [message addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:messageRange1];
    
    _segmentControl = [[UISegmentedControl alloc]initWithItems:@[message,telephone,message1]];
    _segmentControl.frame = CGRectMake(10, 30, view.bounds.size.width - 20, 40);
    
    _segmentControl.selectedSegmentIndex = m;
    _segmentControl.tintColor = [UIColor colorWithRed:30 / 256.0 green:185 / 256.0 blue:230 / 256.0 alpha:1];
    [view addSubview:_segmentControl];
    [_segmentControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    
    
        UIButton *bt2 = [[UIButton alloc] initWithFrame:CGRectMake(view.frame.size.width-50, 5, 40, 40)];
        [bt2 setTitle:@"X" forState:(UIControlStateNormal)];
        [bt2 setTitleColor:RGB(83, 83, 83) forState:(UIControlStateNormal)];
        [bt2 addTarget:self action:@selector(BT:) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    
    return view;

}

//-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(50, 0, ScreenWidth-100, 100)];
//    view.backgroundColor = [UIColor whiteColor];
//    [self.backView addSubview:view];
////    UIButton *bt = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth/2-100, 40, 100, 30)];
////    [bt setTitle:@"确定" forState:(UIControlStateNormal)];
////    [bt setTitleColor:RGB(83, 83, 83) forState:(UIControlStateNormal)];
////    [bt addTarget:self action:@selector(BT:) forControlEvents:(UIControlEventTouchUpInside)];
////    bt.layer.borderColor = RGB(83, 83, 83).CGColor;
////    bt.layer.masksToBounds = YES;
////    bt.layer.cornerRadius = 4;
////    [bt.layer setBorderWidth:1.0];
//
// //   [view addSubview:bt];
//    return view;
//}

static NSInteger m;
- (void)segmentAction:(UISegmentedControl *)seg{
    NSLog(@"%ld",seg.selectedSegmentIndex);
      _segmentControl.selectedSegmentIndex = seg.selectedSegmentIndex;
    NSString *numstr1=[NSString stringWithFormat:@"%ld",(long)seg.selectedSegmentIndex];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"test1" object:nil userInfo:numstr1];

     m= [numstr1 integerValue];
    
    
    if(m==0)
    {
        _titleArray = @[@"免费线路",@"美国线路01",@"韩国线路",@"日本线路",@"收费线路",@"新加坡线路",@"香港线路",@"台湾线路"];
    }
    if(m==1)
    {
        _titleArray = @[@"免费线路",@"美国线路01",@"韩国线路",@"日本线路"];
    }
    if(m==2)
    {
        _titleArray = @[@"收费线路",@"新加坡线路",@"香港线路",@"台湾线路"];
    }
    
    [_tableView reloadData];

    
    //存数据
    [[NSUserDefaults standardUserDefaults] setObject:numstr1 forKey:@"判断表格"];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([self.delegate respondsToSelector:@selector(clickButton:)]) {
        [self.delegate clickButton:indexPath.row];
    }if (self.GlodeBottomView) {
        self.GlodeBottomView(indexPath.row,self.titleArray[indexPath.row]);
    }
    [self dissMIssView];
    
    if(m==0||m==1)
    {
       delegate.currentIndex=indexPath.row;
    }
    [self.tableView reloadData];
    NSString *numstr=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"test" object:nil userInfo:numstr];
    
    if((m==0&&(indexPath.row>4))||m==2)
    {
        LXAlertView *alert1=[[LXAlertView alloc] initWithTitle:@"提示" message:@"收费线路会带来更优质的游戏和浏览网页体验，三条线路可随意选择（ps：国外网站随意上，你懂的）" cancelBtnTitle:@"取消" otherBtnTitle:@"确定" clickIndexBlock:^(NSInteger clickIndex) {
            NSLog(@"点击index====%ld",clickIndex);
            
            
            if(clickIndex==1)
            {
                NSLog(@"去购买");
                if([SHInvoker isLogined])//已经登录
                {
                    
                    NSNotification *notification =[NSNotification notificationWithName:@"跳转" object:nil userInfo:nil];
                    //通过通知中心发送通知
                    [[NSNotificationCenter defaultCenter] postNotification:notification];
                }
                else
                {
                            AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                            [tempAppDelegate.leftSlideVC closeLeftView];//关闭左侧抽屉
                            LoginVCNew *login =[[LoginVCNew alloc]init];
                            [tempAppDelegate.mainNC pushViewController:login animated:NO];
                  

                }
                
            }
        }];
        alert1.animationStyle=LXASAnimationTopShake;
        [alert1 showLXAlertView];
    }
    
    NSLog(@"选择的是---------%ld",indexPath.row);
}

//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
//        [cell setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
//    }
//    
//    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
//        [cell setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
//    }
//}



- (UITableViewCellAccessoryType)tableView:(UITableView*)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath*)indexPath
{
//    __block NSString *str=[NSString new];
//    MainViewController *main=[MainViewController new];
//    // 拿到block传的值
//    [main huoquipValue:^(NSString *value) {
//        str=value;
//            NSLog(@"------%@",str);
//    }];
     NSString * strnum = [[NSUserDefaults standardUserDefaults] objectForKey:@"判断表格"];
    if(indexPath.row==delegate.currentIndex&&[strnum isEqualToString:@"2"]){
        return UITableViewCellAccessoryCheckmark;
    }
    else if(indexPath.row==delegate.currentIndex&&![strnum isEqualToString:@"2"]){
            return UITableViewCellAccessoryCheckmark;
        }{
        return UITableViewCellAccessoryNone;
    }
}


@end
