//
//  LeftSortViewController.m
//  Touch
//
//  Created by lanou3g on 15/12/14.
//  Copyright © 2015年 syx. All rights reserved.
//

#import "LeftSortViewController.h"
#import "AppDelegate.h"
#import "OtherViewController.h"
#import "XHChatQQ.h"
#import "WXApi.h"
//#import "JumpToBizProfileReq.h"#import "WXApiObject.h"
//#import <JumpToBizProfileReq.h>
#import "WXApiObject.h"
#import <Foundation/Foundation.h>

@interface LeftSortViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UIView * _headView;
    UILabel * nameLabel;
}

@end

@implementation LeftSortViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;//隐藏标题栏
    

    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:24/255.0 green:36/255.0 blue:48/255.0 alpha:1.0]];
    
    self.view.backgroundColor=[UIColor colorWithRed:24/255.0 green:36/255.0 blue:48/255.0 alpha:1.0];
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *Identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;//设置cell点击效果（无
    cell.textLabel.font = [UIFont systemFontOfSize:20.0f];
    cell.backgroundColor=[UIColor colorWithRed:24/255.0 green:36/255.0 blue:48/255.0 alpha:1.0];
    
    cell.textLabel.textColor = [UIColor colorWithRed:38/255.0 green:200/255.0 blue:252/255.0 alpha:1.0];
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"去评价";
        cell.imageView.image = [UIImage imageNamed:@"leftbar_pingjia"];
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"熊猫官网";
        cell.imageView.image = [UIImage imageNamed:@"leftbar_panda"];
    } else if (indexPath.row == 2) {
        cell.textLabel.text = @"新浪微博";
        cell.imageView.image = [UIImage imageNamed:@"leftbar_weibo"];
    } else if (indexPath.row == 3){
        cell.textLabel.text = @"关注微信";
        cell.imageView.image = [UIImage imageNamed:@"leftbar_winxin"];
    }
    else if (indexPath.row == 4){
        cell.textLabel.text = @"熊猫交流群";
        cell.imageView.image = [UIImage imageNamed:@"leftbar_QQ"];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    switch (indexPath.row) {
            
        case 0:
        {
            //评价
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/app/id1125640621"]];
            //在APP内打开网页版appstore
          //  [self evaluate];
        }
            break;
        case 1:
            
            
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"http://www.xiongmao888.com"]];
            break;
        case 2:{//关注微博sinaweibo://xiongmaojiasu/profile?rightmod=1&wvr=6&mod=personnumber
            NSString *urlStr = [NSString stringWithFormat:@"http://m.weibo.cn/users/5890681053/qq"];
            NSURL *url = [NSURL URLWithString:urlStr];
            if([[UIApplication sharedApplication] canOpenURL:url]){
                [[UIApplication sharedApplication] openURL:url];
                return;
            }
            else{
                //
                NSString *urlStr = [NSString stringWithFormat:@"http://m.weibo.cn/users/5890681053/qq"];
                NSURL *url = [NSURL URLWithString:urlStr];
                if([[UIApplication sharedApplication] canOpenURL:url]){
                    [[UIApplication sharedApplication] openURL:url];
                    return;
                }
                
            }
        }
            
            break;
        case 3:{//关注微信weixin://dl/officialaccounts/
            JumpToBizWebviewReq *req = [[JumpToBizWebviewReq alloc]init];
            req.webType = WXBizProfileType_Normal;
            req.tousrname = @"gh_31ce9391f150"; //公众号原始ID
            [WXApi sendReq:req];
        }
            
            break;
        case 4:{//熊猫交流群
            NSString *urlStr = [NSString stringWithFormat:@"mqqapi://card/show_pslcard?src_type=internal&version=1&uin=%@&key=%@&card_type=group&source=external", @"162292739",@"c393bdd95ccdbcde94e051d97f7028f9480895212315ae596808152fb1236d76"];
            NSURL *url = [NSURL URLWithString:urlStr];
            if([[UIApplication sharedApplication] canOpenURL:url]){
                [[UIApplication sharedApplication] openURL:url];
                return;
            }
            else{
                
            }
        }
            break;
            
        default:
            break;
    }
}
- (void)evaluate{
    
    //初始化控制器
    SKStoreProductViewController *storeProductViewContorller = [[SKStoreProductViewController alloc] init];
    //设置代理请求为当前控制器本身
    storeProductViewContorller.delegate = self;
    //加载一个新的视图展示
    [storeProductViewContorller loadProductWithParameters:
     //appId唯一的
     @{SKStoreProductParameterITunesItemIdentifier : @"587767923"} completionBlock:^(BOOL result, NSError *error) {
         //block回调
         if(error){
             NSLog(@"error %@ with userInfo %@",error,[error userInfo]);
         }else{
             //模态弹出appstore
             [self presentViewController:storeProductViewContorller animated:YES completion:^{
                 
             }
              ];
         }
     }];
}

//取消按钮监听
- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

- (void)setupUI{
    
    UITableView * tableView = [[UITableView alloc]init];
    self.tableView = tableView;
    tableView.frame = self.view.bounds;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 115)];
    _headView.backgroundColor = [UIColor colorWithRed:24/255.0 green:36/255.0 blue:48/255.0 alpha:1.0];
    self.tableView.tableHeaderView = _headView;
    
    UIImageView * headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 40, 70, 70)];
    headImageView.image = [UIImage imageNamed:@"leftbar_default"];
    headImageView.layer.cornerRadius = headImageView.frame.size.width / 2;
    headImageView.clipsToBounds = YES;
    UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapPage3)];
    [headImageView addGestureRecognizer:tapGesturRecognizer];
    
    [_headView addSubview:headImageView];
    
    nameLabel= [[UILabel alloc]initWithFrame:CGRectMake(100, 42, [UIScreen mainScreen].bounds.size.width - 80, 40)];
    nameLabel.textColor=[UIColor colorWithRed:38/255.0 green:200/255.0 blue:252/255.0 alpha:1.0];
    nameLabel.font = [UIFont systemFontOfSize:15];
    [_headView addSubview:nameLabel];
    
    
    UILabel *accountLable=[[UILabel alloc]initWithFrame:CGRectMake(100, 75, 100, 30)];
    
    accountLable.textColor=[UIColor colorWithRed:38/255.0 green:200/255.0 blue:252/255.0 alpha:1.0];
    accountLable.font = [UIFont systemFontOfSize:17];
    [_headView addSubview:accountLable];
    
    
    NSString *str=[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    NSDictionary *parameters = @{@"device_type":@"IPHONE",@"hardware_sn":deviceUUID,@"soft_version":str};
    [EncryptAndEcode httpUrl:@"http://api.xiongmaoapi.com/api/xiongmao/sr1/" AndPostparameters:parameters block:^(NSDictionary *responseObject) {
        NSLog(@"-------->>----%@",responseObject);
        NSString *str=[NSString stringWithFormat:@"%@",[responseObject valueForKey:@"sr"]];
        if(![str isEqualToString:@"1"])
        {
            
            accountLable.text=@"黄金会员";
            headImageView.userInteractionEnabled=YES;
            NSDictionary * info= [SHInvoker getUserInfo];
            NSString *str=[NSString stringWithFormat:@"%@",[info valueForKey:@"phone"]];
            
            NSLog(@"------(%@)",[info valueForKey:@"phone"]);
            if(str==nil||str==NULL||[str isEqualToString:@"(null)"]||[str isEqualToString:@""])
            {
                nameLabel.text=@"熊猫VPN专业版";
            }
            else{
                nameLabel.text=str;
            }
        }
        else{
           accountLable.text=@"我是熊猫君";
           nameLabel.text=@"熊猫VPN专业版";
        }
    }];
    
    
//    //第一个时间
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    NSDate *firstDate = [dateFormatter dateFromString:@"2016-06-01 10:40:40"];
//    NSTimeInterval _fitstDate = [firstDate timeIntervalSince1970]*1;
//    //第二个时间（当前时间）
//    NSDate * senddate=[NSDate date];
//    NSString * locationString=[dateFormatter stringFromDate:senddate];
//    NSDate *secondDate = [dateFormatter dateFromString:locationString];
//    NSTimeInterval _secondDate = [secondDate timeIntervalSince1970]*1;
//    if (_fitstDate - _secondDate > 0) {
//       
//        
//    }
//    else{
//
//        
 //   }
    
    
    //    UIImageView * sunImage = [[UIImageView alloc]initWithFrame:CGRectMake(80, 55, 25, 25)];
    //    sunImage.image = [UIImage imageNamed:@"SUN"];
    //    [_headView addSubview:sunImage];
    //
    //    UIImageView * sunImage1 = [[UIImageView alloc]initWithFrame:CGRectMake(110, 55, 25, 25)];
    //    sunImage1.image = [UIImage imageNamed:@"SUN"];
    //    [_headView addSubview:sunImage1];
    //
    //    UIImageView * sunImage2 = [[UIImageView alloc]initWithFrame:CGRectMake(140, 57, 20, 21)];
    //    sunImage2.image = [UIImage imageNamed:@"MOON"];
    //    [_headView addSubview:sunImage2];
    
    //    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(5, 90, [UIScreen mainScreen].bounds.size.width, 20)];
    //    label.text = @"“ 编辑个性签名";
    //    label.textColor = [UIColor grayColor];
    //    [_headView addSubview:label];
    
    self.tableView.backgroundColor = [UIColor colorWithRed:24/255.0 green:36/255.0 blue:48/255.0 alpha:1.0];
    self.tableView.separatorColor =[UIColor colorWithRed:24/255.0 green:36/255.0 blue:48/255.0 alpha:1.0];//分割线颜色
    [self setExtraCellLineHidden:self.tableView];
}
//隐藏线条
-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}
-(void)tapPage3
{
    
    if([SHInvoker isLogined])
    {
        [FormValidator showAlertWithStr:@"您已经登录过了"];
    }
    else
    {
        AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        // OtherViewController *vc = [[OtherViewController alloc] init];
        [tempAppDelegate.leftSlideVC closeLeftView];//关闭左侧抽屉
        LoginVCNew *login =[[LoginVCNew alloc]init];
        [tempAppDelegate.mainNC pushViewController:login animated:NO];
        
    }
    
    //   [tempAppDelegate.mainNC pushViewController:vc animated:NO];
}

@end
