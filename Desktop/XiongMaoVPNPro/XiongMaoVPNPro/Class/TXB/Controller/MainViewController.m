 //
//  MainViewController.m
//  DrawerDemo
//
//  Created by lanou3g on 15/12/14.
//  Copyright © 2015年 syx. All rights reserved.
//

#import "MainViewController.h"
#import "AppDelegate.h"
#import "RootNavigationController.h"
#import "ShouYeHelpViewController.h"
#import "AlertView.h"
#import "AppDelegate.h"
#import "XMShareTools.h"
#import "MainViewController+XMShareExtension.h"
#import "EncryptAndEcode.h"
#import "AppDelegate.h"
#import "VersionManage.h"
#import "VPNConnectting.h"
#import "PushAnimation.h"
#import "BuyViewController.h"
#import "NSObject+XMCountExtension.h"
#import "GUAAlertView.h"

@interface MainViewController ()<
UIViewControllerAnimatedTransitioning,
UINavigationControllerDelegate
>
@property UIButton * btn;


@property (nonatomic, weak) UIBarButtonItem * share_btn;
@end

@implementation MainViewController

{
    //再定义一个imageview来等同于这个黑线
    UIImageView *navBarHairlineImageView;
    CABasicAnimation *rotation;
    NSArray *arr;
    UIButton *lb;//线路
    AlertView *alert ;
    NSString *panudan;//判断用户时间是否过期
    NSDictionary *dicall;//获得的用户信息
    NSString *ipaddress;//服务器ip
    NSString *fuwuqid;//服务器id
    VPNConnectting *vpn;
    AppDelegate *delegate;

    
}
//去评价
-(void)qupingjia
{
    //第一个时间
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *firstDate = [dateFormatter dateFromString:@"2016-07-09 12:40:40"];
    NSTimeInterval _fitstDate = [firstDate timeIntervalSince1970]*1;
    //第二个时间（当前时间）
    NSDate * senddate=[NSDate date];
    NSString * locationString=[dateFormatter stringFromDate:senddate];
    NSDate *secondDate = [dateFormatter dateFromString:locationString];
    NSTimeInterval _secondDate = [secondDate timeIntervalSince1970]*1;
    
    if (_fitstDate - _secondDate <= 0&&([NSObject returnCountOpen]%25==0)) {
        //第一个时间大
        GUAAlertView *v = [GUAAlertView alertViewWithTitle:@"熊猫君"
                                                   message:@"我是一只努力的熊猫君，努力打造国内最流畅，最快速的手游和pc体验，    好评免费送时间！！"
                                               buttonTitle:@"确定"
                                       buttonTouchedAction:^{
                                           
                                          [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/app/id1125640621"]];
                                           
                                       } dismissAction:^{
                                           NSLog(@"dismiss");
                                       }];
        [v show];
     
    }
    
    
    
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
     [self qupingjia];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    self.navigationController.delegate = self;
    
}
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 1;
}
-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    NSLog(@"动画处理");

    
}


-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                 animationControllerForOperation:(UINavigationControllerOperation)operation
                                              fromViewController:(UIViewController *)fromVC
                                                toViewController:(UIViewController *)toVC{
    if ([toVC isKindOfClass:[BuyViewController class]]) {
        PushAnimation *transition = [[PushAnimation alloc] init];
        return transition;
    }else{
        return nil;
    }
}

-(void)setup{
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}


#pragma mark /***************************往上是特殊pop和push……………………………………………………………………*/


//去掉导航栏黑线
- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}


//在页面消失的时候就让出现
-(void)viewDidDisappear:(BOOL)animated
{
    navBarHairlineImageView.hidden = NO;
    //特殊pop和push
     self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}
//跳往购买
-(void)tiaozhuan
{
    UIStoryboard * stroyBoard = [UIStoryboard storyboardWithName:@"Buy" bundle:[NSBundle mainBundle]];
    BuyViewController * buyVC = [stroyBoard instantiateViewControllerWithIdentifier:@"BuyViewController"];
    [self.navigationController pushViewController:buyVC animated:YES];
    
}



-(void)tishiye
{
    GuideView *guide = [GuideView new];
    [guide showInView:[UIApplication sharedApplication].keyWindow maskBtn:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    vpn =[[VPNConnectting alloc]init];
    //初始化VPN
   
    
    delegate=[UIApplication sharedApplication].delegate;
       //监听
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Disconnect) name:@"tuichu" object:nil];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(anzhuang) name:@"anzhuang" object:nil];
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shuaxin) name:@"登录" object:nil];
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shuaxin) name:@"购买" object:nil];
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Connectted) name:@"连接成功" object:nil];
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Disconnceted) name:@"连接失败" object:nil];
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AnniuZhuangtai) name:@"安装证书的按钮" object:nil];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tiaozhuan) name:@"跳转" object:nil];
    
    alert = [AlertView sharedManager];
    self.title=@"熊猫VPN";
    //去掉导航栏黑线
    self.navigationController.navigationBar.translucent=NO;
    navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    //左边菜单按钮
    UIButton *menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    menuBtn.frame = CGRectMake(0, 0, 20, 18);
    [menuBtn setBackgroundImage:[UIImage imageNamed:@"nav__meun"] forState:UIControlStateNormal];
    [menuBtn addTarget:self action:@selector(openOrCloseLeftList) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];
    self.view.backgroundColor=[UIColor colorWithRed:2/225.0 green:35/225.0 blue:78/225.0 alpha:1];
    
    
    //右上角疑问
    UIBarButtonItem *barBtn3=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav__help"] style:UIBarButtonItemStylePlain target:self action:@selector(Dohlep)];
    [barBtn3 setTintColor:[UIColor whiteColor]];
    //分享
    UIBarButtonItem *barBtn4=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav__share"] style:UIBarButtonItemStylePlain target:self action:@selector(showshareView)];
    self.share_btn = barBtn4;
    [barBtn4 setTintColor:[UIColor whiteColor]];
    NSArray *buttonArray = [[NSArray alloc]initWithObjects:barBtn3,barBtn4, nil];
    self.navigationItem.rightBarButtonItems = buttonArray;
    
    
    
    //开始连接按钮
    self.btn = [[UIButton alloc]init];
    self.btn.center = self.view.center;
    self.btn.frame = CGRectMake(10, [UIScreen mainScreen].bounds.size.height-90-80, [UIScreen mainScreen].bounds.size.width-20, 65);

    
    
    /*========================*/
    self.btn.userInteractionEnabled=YES;
    self.btn.titleLabel.font=[UIFont systemFontOfSize:20.f];
    self.btn.layer.cornerRadius = 35;
    self.btn.layer.masksToBounds = YES;
    [self.view addSubview:self.btn];
    [self.btn addTarget:self action:@selector(btnClick1:) forControlEvents:UIControlEventTouchUpInside];
    
#pragma mark------进入app判断是否正在加速
    
    NSDictionary * info= [SHInvoker getUserInfo];
    NSString *strsign=[NSString stringWithFormat:@"%@",[info valueForKey:@"sign"]];
    XMLog(@"%@-------",strsign);
    if([strsign isEqualToString:@"连接成功"])
    {
        //已连接（连接成功）
        [self.btn setTitle:@"停止加速" forState:UIControlStateNormal];
        self.btn.backgroundColor=[UIColor colorWithRed:34/225.0 green:215/225.0 blue:109/225.0 alpha:1];
    }
    else{
        //未连接（连接失败）
        [self.btn setTitle:@"开始加速" forState:UIControlStateNormal];
        self.btn.backgroundColor = [UIColor colorWithRed:38/255.0 green:201/255.0 blue:209/252.0 alpha:1];
    }
    
    
   
    //地图
    UIImageView *addressImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.width/3, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width/2)];
    addressImage.image=[UIImage imageNamed:@"map"];
    [self.view addSubview:addressImage];
    
    //线路选择
    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/4, addressImage.frame.size.height+addressImage.frame.origin.y+55, 20, 20)];
 
    [self.view addSubview:image];
    lb=[[UIButton alloc]initWithFrame:CGRectMake(image.frame.size.width+image.frame.origin.x, addressImage.frame.size.height+addressImage.frame.origin.y+50, 120, 30)];
   

    [lb setTitleColor:[UIColor whiteColor] forState:0];
    lb.titleLabel.font=[UIFont systemFontOfSize:20.f];
    [self.view addSubview:lb];
    UIImageView *image1=[[UIImageView alloc]initWithFrame:CGRectMake(lb.frame.size.width+lb.frame.origin.x, addressImage.frame.size.height+addressImage.frame.origin.y+55, 20, 20)];
    [self.view addSubview:image1];
    image1.userInteractionEnabled = YES;

    
    
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tapGr.cancelsTouchesInView = NO;//系统处于手势点击状态，默认是no
    [self.view addGestureRecognizer:tapGr];
    
    
    NSString *str=[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    NSDictionary *parameters = @{@"device_type":@"IPHONE",@"hardware_sn":deviceUUID,@"soft_version":str};
    
#pragma mark------判断后台是否打开关闭
    [EncryptAndEcode httpUrl:@"http://api.xiongmaoapi.com/api/xiongmao/sr1/" AndPostparameters:parameters block:^(NSDictionary *responseObject) {
        NSLog(@"-------->>----%@",responseObject);
        NSString *str=[NSString stringWithFormat:@"%@",[responseObject valueForKey:@"sr"]];
        if(![str isEqualToString:@"1"])
        {
            [lb addTarget:self action:@selector(xuanze) forControlEvents:UIControlEventTouchUpInside];
            UITapGestureRecognizer * g = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(xuanze)];
            [image1 addGestureRecognizer:g ];
        }
        else{
            
            NSNotification *notification =[NSNotification notificationWithName:@"关闭" object:nil userInfo:nil];
            //通过通知中心发送通知
            [[NSNotificationCenter defaultCenter] postNotification:notification];
        }
         }];
    image.image=[UIImage imageNamed:@"home_meiguo"];
    image1.image=[UIImage imageNamed:@"home_switch"];
    
    [self huoquipValue:^(NSString *value) {
        
    }];//IP
    [self denglu];//登录
    
    //TODO: 分享视图的底部位置
    [self showWillShareView];
    
}


//这个有一个手指离开过程（touchesBegan没有）这个方法执行在手指离开时
-(void)viewTapped:(UITapGestureRecognizer*)tapGr
{
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.leftSlideVC closeLeftView];
    
}

//点击连接
- (void) btnClick1:(UIButton *) btn{
 
    if(![[[NSUserDefaults standardUserDefaults] objectForKey:@"初始化成功"] isEqualToString:@"初始化成功"])
    {
//        static dispatch_once_t onceToken;
//        dispatch_once(&onceToken, ^{
            //开始连接按钮
            [vpn VPNconnect];
            
      //  });
    }
    else{
    [self.btn setTitle:@"" forState:0];
    //动画缩放
    [UIView animateWithDuration:0.4 animations:^{
        //        self.btn.frame = CGRectMake(30, 200, 70, 70);
        
        self.btn.bounds = CGRectMake(0, 0, 70, 70);
        
       
        
          
    } completion:^(BOOL finished) {
        
        // self.btn.userInteractionEnabled=NO;
        [self.btn setImage:[UIImage imageNamed:@"btn@3x"] forState:UIControlStateNormal];
        
        rotation= [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        
        [rotation setToValue:@(M_PI*2)];
        
        [rotation setDuration:0.5f];
        [rotation setRepeatCount:MAXFLOAT];
        
        [self.btn.layer addAnimation:rotation forKey:@"rotation"];
        //  self.btn.userInteractionEnabled=NO;
        [self kaishilianjie];
        
       
        
    }];
    }
    
}



- (void) openOrCloseLeftList{
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (tempAppDelegate.leftSlideVC.closed){
        [tempAppDelegate.leftSlideVC openLeftView];
    }
    else{
        [tempAppDelegate.leftSlideVC closeLeftView];
    }
}
//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//      AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//     [tempAppDelegate.leftSlideVC closeLeftView];
//}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=NO;
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.leftSlideVC setPanEnabled:YES];
    navBarHairlineImageView.hidden = YES;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    arr = @[@"免费线路",@"美国线路01",@"韩国线路",@"日本线路",@"收费线路",@"新加坡线路",@"香港线路",@"台湾线路"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tongzhi:) name:@"test" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tongzhi1:) name:@"test1" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(duanwang) name:@"断网" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(youwang) name:@"有网" object:nil];
    
 
}


- (void)tongzhi1:(NSNotification *)text{
    NSLog(@"%@",text.userInfo);
    
    NSString *str=[NSString stringWithFormat:@"%@",text.userInfo];
    NSInteger m=[str integerValue];
    
    if(m==0)
    {
        arr = @[@"免费线路",@"美国线路01",@"韩国线路",@"日本线路",@"收费线路",@"新加坡线路",@"香港线路",@"台湾线路"];
    }
    if(m==1)
    {
        arr = @[@"免费线路",@"美国线路01",@"韩国线路",@"日本线路"];
    }
    if(m==2)
    {
        arr = @[@"收费线路",@"新加坡线路",@"香港线路",@"台湾线路"];
    }
    NSLog(@"－－－－－接收到通知------");
    
}


- (void)tongzhi:(NSNotification *)text{
    NSLog(@"%@",text.userInfo);
    NSString *str=[NSString stringWithFormat:@"%@",text.userInfo];
    NSInteger m=[str integerValue];
    [lb setTitle:arr[m] forState:0];
    NSLog(@"－－－－－接收到通知------%@",arr);
    arr = @[@"免费线路",@"美国线路01",@"韩国线路",@"日本线路",@"收费线路",@"新加坡线路",@"香港线路",@"台湾线路"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark 弹窗显示
//弹出框显示
-(void)xuanze
{
 
    alert.titleArray = arr;
    [alert show];
    
}
-(void)Dohlep
{
    ShouYeHelpViewController * help=[ShouYeHelpViewController new];
    [self.navigationController pushViewController:help animated:YES];
}

/*----------------------------登录------------------------------------------------------------------*/
-(void)denglu
{
    //登录
    NSString *str=[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];

    NSDictionary * info= [SHInvoker getUserInfo];
    NSString *username =[NSString stringWithFormat:@"%@",[info valueForKey:@"phone"]];
    NSString * paaword=[NSString stringWithFormat:@"%@",[info valueForKey:@"password"]];
    if(username==nil||username==NULL|| [username isEqualToString:@"(null)"])
    {
        username=@"";
    }
    if(paaword == nil || paaword == NULL || [paaword isEqualToString:@"(null)"])
    {
        paaword =@"";
    }
    XMLog(@"--------------%@",username);
    
    NSDictionary *parameters = @{@"device_type":@"IPHONE",@"hardware_sn":deviceUUID,@"soft_version":str,@"username":username,@"password":paaword};
    [EncryptAndEcode httpUrl:@"http://api.xiongmaoapi.com/api/xiongmao/login/" AndPostparameters:parameters block:^(NSDictionary *responseObject) {
        
        dicall=responseObject;
       
        NSString *strrr=[NSString stringWithFormat:@"%@",[responseObject valueForKey:@"success"]];
        if([strrr isEqualToString:@"1"])
        {
        //第一个时间
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *firstDate = [dateFormatter dateFromString:[dicall valueForKey:@"expire"]];
        NSTimeInterval _fitstDate = [firstDate timeIntervalSince1970]*1;
        
        
        //第二个时间（当前时间）
        NSDate * senddate=[NSDate date];
        NSString * locationString=[dateFormatter stringFromDate:senddate];
        NSDate *secondDate = [dateFormatter dateFromString:locationString];
        NSTimeInterval _secondDate = [secondDate timeIntervalSince1970]*1;
        
        NSLog(@"-------两个时间比----%f",_fitstDate - _secondDate);//单位秒
        if (_fitstDate - _secondDate > 0) {
            //第一个时间大
            NSLog(@"-------未过期时间比----%f",_fitstDate - _secondDate);
        }
        else{
            panudan=@"1";//过期了
        }
        
        
   
        }
    }];
    
}

#pragma mark----------------获取ip---------------

 -(void) huoquipValue:(void (^)(NSString * value))shareValue
{
   //ip获取
   NSDictionary *info= [SHInvoker getUserInfo];
    NSString *str=[NSString stringWithFormat:@"%@",[info valueForKey:@"phone"]];
    NSDictionary *parameters = @{@"device_type":@"IPHONE",@"username":str};
    [EncryptAndEcode httpUrl:@"http://api.xiongmaoapi.com/api/xiongmao/get_server_lists/" AndPostparameters:parameters block:^(NSDictionary *responseObject) {
        
        NSString *str=[NSString stringWithFormat:@"%@",[responseObject valueForKey:@"usertype"]];
        
        NSArray *arrip=[responseObject valueForKey:@"list"];
        
        ipaddress=[self stringDeleteString:[NSString stringWithFormat:@"%@",[arrip valueForKey:@"serverip"]]];
      
        fuwuqid=[self stringDeleteString:[NSString stringWithFormat:@"%@",[arrip valueForKey:@"id"]]];

        int x = arc4random() % 3;
        if([str  isEqualToString:@"1"])//付费用户
        {
             delegate.currentIndex=x+1;
           NSArray* addadress=@[@"新加坡线路",@"香港线路",@"台湾线路"];
      
         //   shareValue(@"付费用户"); block传值;

             [lb setTitle:addadress[x] forState:0];
        }
        else{
            delegate.currentIndex=x+1;
            NSArray *addressfree=@[@"美国线路01",@"韩国线路",@"日本线路"];
             [lb setTitle:addressfree[x] forState:0];
            
        }
    }];
    
}

//去除字符中特定字符串
-(NSString *) stringDeleteString:(NSString *)str
{
    NSMutableString *str1 = [NSMutableString stringWithString:str];
    for (int i = 0; i < str1.length; i++) {
        unichar c = [str1 characterAtIndex:i];
        NSRange range = NSMakeRange(i, 1);
        if ( c == '"'|| c == ',' || c == '(' || c == ')'|| c == ' '|| c == '\n'|| c == '\r') { //此处可以是任何字符
            [str1 deleteCharactersInRange:range];
            --i;
        }
    }
    NSString *newstr = [NSString stringWithString:str1];
    return newstr;
}

/*-----------------------------------------------开始连接-----------------------------------------------*/
//开始连接
-(void)kaishilianjie
{
    if([panudan isEqualToString:@"1"])//已经过期了
    {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@""
                                                                       message:@"您的服务已经到期，请到套餐页面购买"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {
                                                                  
                                                                  //未连接 套餐到期
                                                                  [self.btn setTitle:@"开始加速" forState:UIControlStateNormal];
                                                                  self.btn.backgroundColor = [UIColor colorWithRed:38/255.0 green:201/255.0 blue:209/252.0 alpha:1];
                                                                  self.btn.userInteractionEnabled=YES;
                                                                  [self.btn.layer removeAllAnimations];
                                                                  //    self.btn.imageView = nil;
                                                                  [self.btn setImage:nil forState:UIControlStateNormal];
                                                                  [UIView animateWithDuration:0.5 animations:^{
                                                                      self.btn.bounds = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-20, 65);
                                                                  }];
                                                                  
                                                              }];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    
    else{
        
   
        
        if(dicall.count==0||dicall==nil||dicall==NULL)
        {
            [self denglu];
        }
        if(ipaddress==nil||fuwuqid==nil)
        {
            [self huoquipValue:^(NSString *value) {
                
            }];
        }
        else{
            vpn.dicall=dicall;
            vpn.server=ipaddress;
            vpn.fuwuqid=fuwuqid;
            [vpn VPNconnect];
        }
        
    }
    
}




static NSString * num;
-(void)anzhuang
{
    
    if(dicall.count==0||dicall==nil||dicall==NULL)
    {
        [self denglu];
    }
    if(ipaddress==nil||fuwuqid==nil)
    {
        [self huoquipValue:^(NSString *value) {
            
        }];
    }
    else{
        
        vpn.dicall=dicall;
        vpn.server=ipaddress;
        vpn.fuwuqid=fuwuqid;
        [vpn installProfile];
    }
    
}
//断网
-(void)duanwang
{
    [FormValidator showAlertWithStr:@"网络不好啊。。。。"];
}

//有网
-(void)youwang
{

   
}
#pragma mark---------获取更新线路和登录状态---
-(void)shuaxin
{
    [self denglu];
    [self huoquipValue:^(NSString *value) {
        
    }];
}

//连接成功
-(void)Connectted
{
    //已连接（连接成功）
    [self.btn setTitle:@"停止加速" forState:UIControlStateNormal];
    self.btn.backgroundColor=[UIColor colorWithRed:34/225.0 green:215/225.0 blue:109/225.0 alpha:1];
    self.btn.userInteractionEnabled=YES;
    [self.btn.layer removeAllAnimations];
    //    self.btn.imageView = nil;
    [self.btn setImage:nil forState:UIControlStateNormal];
    [UIView animateWithDuration:0.5 animations:^{
        self.btn.bounds = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-20, 65);
    }];
}
//连接失败
-(void)Disconnceted
{
    
    ipaddress=@"123.57.157.48";//连接失败的时候
    [self.btn setTitle:@"开始加速" forState:UIControlStateNormal];
    self.btn.backgroundColor = [UIColor colorWithRed:38/255.0 green:201/255.0 blue:209/252.0 alpha:1];
    self.btn.userInteractionEnabled=YES;
    [self.btn.layer removeAllAnimations];
    //    self.btn.imageView = nil;
    [self.btn setImage:nil forState:UIControlStateNormal];
    [UIView animateWithDuration:0.5 animations:^{
        self.btn.bounds = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-20, 65);
    }];
    
}
//证书安装成功或者失败的按钮状态
-(void)AnniuZhuangtai
{
//    [self.btn setTitle:@"开始加速" forState:UIControlStateNormal];
//    self.btn.backgroundColor = [UIColor colorWithRed:38/255.0 green:201/255.0 blue:209/252.0 alpha:1];
    
}
//断开连接
-(void)Disconnect
{
    [vpn disconnect];
    //存进去沙盒进行判断是否在加速中
    NSDictionary *dd=@{SHInvokerUserInfolocationSign:@"连接失败"};
    [SHInvoker saveUserInfo:dd];

    [FormValidator showAlertWithStr:failTipe];
}







@end
