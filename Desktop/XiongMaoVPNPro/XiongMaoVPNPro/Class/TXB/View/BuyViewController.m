

//
//  BuyViewController.m
//  XiongMaoJiaSu
//
//  Created by 唐晓波的电脑 on 16/5/24.
//  Copyright © 2016年 ISOYasser. All rights reserved.
//

#import "BuyViewController.h"
#import "XMBoardBTN.h"
#import "Order.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import "XMLineTypeMiddleLabel.h"
#import "XMBuy_Info_Model.h"
#import "AFNetworking.h"
#import "AppDelegate.h"
#import "LCProgressHUD.h"
#import "XMBuyLabel.h"
#import "MainViewController.h"
#import "PopAnimation.h"
//gg
@interface BuyViewController ()<
UIViewControllerAnimatedTransitioning,
UINavigationControllerDelegate
>
@property (weak, nonatomic) UIView * bgView;
//7
@property (weak, nonatomic) IBOutlet UILabel *day_7_label;
@property (weak, nonatomic) IBOutlet UILabel *day_7_price;
@property (weak, nonatomic) IBOutlet XMLineTypeMiddleLabel *day_7_o_price;
//30
@property (weak, nonatomic) IBOutlet UILabel *day_30_label;
@property (weak, nonatomic) IBOutlet UILabel *day_30_price;
@property (weak, nonatomic) IBOutlet XMLineTypeMiddleLabel *day_30_o_price;
//90
@property (weak, nonatomic) IBOutlet UILabel *day_90_label;
@property (weak, nonatomic) IBOutlet UILabel *day_90_price;
@property (weak, nonatomic) IBOutlet XMLineTypeMiddleLabel *day_90_o_price;
//180
@property (weak, nonatomic) IBOutlet UILabel *day_180_label;
@property (weak, nonatomic) IBOutlet UILabel *day_180_price;
@property (weak, nonatomic) IBOutlet XMLineTypeMiddleLabel *day_180_o_price;
//365
@property (weak, nonatomic) IBOutlet UILabel *day_365_label;
@property (weak, nonatomic) IBOutlet UILabel *day_365_price;
@property (weak, nonatomic) IBOutlet XMLineTypeMiddleLabel *day_365_o_price;@end

@implementation BuyViewController
{
    NSDictionary *dic;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.delegate = self;
}



-(void)backToIndex
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    
}

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 1.5;
}

-(id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    if ([toVC isKindOfClass:[MainViewController class]]) {
        PopAnimation *popAnimation = [[PopAnimation alloc] init];
        return popAnimation;
    }else{
        return nil;
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"购买";
    //返回按钮的颜色
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_back"] style:UIBarButtonItemStylePlain target:self action:@selector(backToIndex)];
    
    AFNetworkReachabilityManager *manager1 = [AFNetworkReachabilityManager sharedManager];
    //设置监听
    [manager1 setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:
            {
                NSLog(@"不可达的网络(未连接)");
                [self duanwang];
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
            {
                [self connectInternet];
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
            {
                [self connectInternet];
                
            }
                break;
            default:
                break;
        }
    }];
    [manager1 startMonitoring];

    
    
}


- (void) connectInternet{

    [self viewWillLayoutSubviews];
      [LCProgressHUD hide];
}

- (void) duanwang{
 
    
    NSArray *list_array = [[NSUserDefaults standardUserDefaults] objectForKey:XMSHUJUHUANCUN];
    NSMutableArray * info_array = [NSMutableArray array];
    XMBuy_Info_Model * buy_info_model = [[XMBuy_Info_Model alloc]init];
    for (NSDictionary * buy_dic in list_array) {
        NSLog(@"%@",buy_dic);
        buy_info_model = [XMBuy_Info_Model buyWithDic:buy_dic];
        [info_array addObject:buy_info_model];
    }
    
    buy_info_model = info_array[0];
    self.day_7_label.text = buy_info_model.title;
    self.day_7_price.text = buy_info_model.price;
    self.day_7_o_price.text = [NSString stringWithFormat:@"原价：%@",buy_info_model.price2];
    buy_info_model = info_array[1];
    self.day_30_label.text = buy_info_model.title;
    self.day_30_price.text = buy_info_model.price;
    self.day_30_o_price.text = [NSString stringWithFormat:@"原价：%@",buy_info_model.price2];
    buy_info_model = info_array[2];
    self.day_90_label.text = buy_info_model.title;
    self.day_90_price.text = buy_info_model.price;
    self.day_90_o_price.text = [NSString stringWithFormat:@"原价：%@",buy_info_model.price2];
    buy_info_model = info_array[3];
    self.day_180_label.text = buy_info_model.title;
    self.day_180_price.text = buy_info_model.price;
    self.day_180_o_price.text = [NSString stringWithFormat:@"原价：%@",buy_info_model.price2];
    buy_info_model = info_array[4];
    self.day_365_label.text = buy_info_model.title;
    self.day_365_price.text = buy_info_model.price;
    self.day_365_o_price.text = [NSString stringWithFormat:@"原价：%@",buy_info_model.price2];
}


- (void)viewWillLayoutSubviews{
 

    NSDictionary * parameters = @{@"device_type":@"IPHONE"};
    [EncryptAndEcode httpUrl:@"http://api.xiongmaoapi.com/api/xiongmao/get_price_list/" AndPostparameters:parameters block:^(NSDictionary *responseObject) {
        
        NSMutableArray * info_array = [NSMutableArray array];
        XMBuy_Info_Model * buy_info_model = [[XMBuy_Info_Model alloc]init];
        if ([responseObject[@"success"] boolValue]) {
            NSArray * list_array = responseObject[@"list"];
            for (NSDictionary * buy_dic in list_array) {
                NSLog(@"%@",buy_dic);
                buy_info_model = [XMBuy_Info_Model buyWithDic:buy_dic];
                [info_array addObject:buy_info_model];
            }
            buy_info_model = info_array[0];
            self.day_7_label.text = buy_info_model.title;
            self.day_7_price.text = buy_info_model.price;
            self.day_7_o_price.text = [NSString stringWithFormat:@"原价：%@",buy_info_model.price2];
            buy_info_model = info_array[1];
            self.day_30_label.text = buy_info_model.title;
            self.day_30_price.text = buy_info_model.price;
            self.day_30_o_price.text = [NSString stringWithFormat:@"原价：%@",buy_info_model.price2];
            buy_info_model = info_array[2];
            self.day_90_label.text = buy_info_model.title;
            self.day_90_price.text = buy_info_model.price;
            self.day_90_o_price.text = [NSString stringWithFormat:@"原价：%@",buy_info_model.price2];
            buy_info_model = info_array[3];
            self.day_180_label.text = buy_info_model.title;
            self.day_180_price.text = buy_info_model.price;
            self.day_180_o_price.text = [NSString stringWithFormat:@"原价：%@",buy_info_model.price2];
            buy_info_model = info_array[4];
            self.day_365_label.text = buy_info_model.title;
            self.day_365_price.text = buy_info_model.price;
            self.day_365_o_price.text = [NSString stringWithFormat:@"原价：%@",buy_info_model.price2];
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:list_array forKey:XMSHUJUHUANCUN];
            [defaults synchronize];
            [LCProgressHUD hide];

        }
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)buyClick:(UIButton *)sender {
    switch (sender.tag) {
        case 7:{

           [self payForMoney:sender.tag];

        }
            break;
        case 30:{
 [self payForMoney:sender.tag];
        }
            break;
        case 90:{
 [self payForMoney:sender.tag];
        }
            break;
        case 180:{
 [self payForMoney:sender.tag];
        }
            break;
        case 365://全年卡
        {
 [self payForMoney:sender.tag];
        }
            break;
            
        default:
            break;
    }
   
}





//实现appinfoView的代理中得方法
- (void)loginPushController{
//    [XMLoginTool dengLuWithSucessBlock:^{
//        
//    } fromVC:self];}
}
#pragma mark---支付
- (void) payForMoney:(NSInteger)tag{
    NSString *leixing=[NSString string];
    if(tag==7)
    {
        leixing=@"month_07";
    }
    if(tag==30)
    {
        leixing=@"month_30";
    }
    
    if(tag==90)
    {
        leixing=@"month_90";
    }
    if(tag==180)
    {
        leixing=@"month_180";
    }
    if(tag==365)
    {
        leixing=@"month_365";
    }
    
    
    [LCProgressHUD showLoading:nil];
    //付款
    
   

    NSDictionary *parameters = @{@"device_type":@"IPHONE",@"hardware_sn":deviceUUID,@"paytype":@"ALIPAY_IPHONE",@"month":leixing};

    [EncryptAndEcode httpUrl:@"http://api.xiongmaoapi.com/api/xiongmao/create_order/" AndPostparameters:parameters block:^(NSDictionary *responseObject) {
        
        NSLog(@"———解密后的数据———%@",responseObject);
        
        
        [LCProgressHUD hide];
        
        NSString *str=[NSString stringWithFormat:@"%@",[responseObject valueForKey:@"success"]];
        if(![str isEqualToString:@"1"])//非1失败
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:[responseObject valueForKey:@"msg"] delegate:self cancelButtonTitle: @"确定" otherButtonTitles:nil];
            [alert show];
            
        }
        else{
            
            dic=responseObject;
        //付款
        [self fukuan];
        
        }
    }];
}
-(void)fukuan
{
    
    NSDictionary *dicc=[dic valueForKey:@"list"];
    NSString *partner = @"2088221600650688";
    NSString *seller = @"sale@youqu-inc.com";
    NSString *privateKey = @"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAM9oQc0Q1L+uJstsiaYtLgurW5AkxfyYveWS+2Ln6Hfy38hmNijh2YuAIg++q2P6rJWxXc847Q1bXRnA26vpXzeTL+38cdNTRp2f9mF1pFRX/8Phnl7LANqcuCn3WwKep9f/WhCZnKkxb9xqf+7QNV2G+eRmY8j99W52vEKla8WVAgMBAAECgYEAoq1IZxpbdBiZTxbLhC6NnhOCVrWxIKWA1G8Lg5EX8fTqdxlMQ5aZdeRDUwwfC+UStrqONLmWnNJbXJa69cSuq9PEaUpTKamRKPuEtxPyCeEw237YrUvJ6PiwV6lGQg+JCiHun4cASf+r+yUGjLU3IoVYwn+Hf5JhTcqe+TRej0UCQQDtNlRYktOGlSCDXlwJrVwqAvG1m5dQ7amxzVw4z/Fqzb59etL2YDwbSpbgrtQ4CoDM02tm0MiZuTnVZ2VgQbVzAkEA39WbifYoT3DY5j2oDwCyXspXupb2ApFY2zaAdm89qEZcr6RME8feRd8YhZSD8+3s1fvIXgE9K9HJYsLBJ6mW1wJATFt4uypIPMI0PRVauyK60Csycysqgjp+rWVVklQdeivQbcPjtLs1nfNcreaZGZEH9Ob5Y5dBe3pMS42E7H86UQJAYN/GLXOIBrnEZgGRVszqZfQU/ACSAJJ/boCsIJYMjWPGgY4ODxGVtY/UwRuB8HSs5//MvEK1At4M1t2LU2smiQJBAMSH6rLq9dNJU+G5aSI7BNChFlSN8MeyDN+mWhZHnDxcKc5tw4j64xQ+sbR281lAE/jM/WG3L7Z/9YJe2jcZyRk=";
    /*============================================================================*/
    //partner和seller获取失败,提示
    if ([partner length] == 0 ||
        [seller length] == 0 ||
        [privateKey length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少partner或者seller或者私                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 钥。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.seller = seller;
    order.tradeNO = [NSString stringWithFormat:@"%@",[dicc valueForKey:@"order_id"]]; //订单ID（由商家?自?行制定）
    order.productName =[NSString stringWithFormat:@"%@",[dicc valueForKey:@"title"]]; //商品标题
    order.productDescription =[NSString stringWithFormat:@"%@",[dicc valueForKey:@"desc"]]; //商品描述
    
      order.amount = [NSString stringWithFormat:@"%@",[dicc valueForKey:@"price"]]; //商品价格
    order.notifyURL = @"http://api.xiongmaoapi.com/alipay/notify_url.php"; //回调URL
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"XiongmaoVPN";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            //【callback处理支付结果】
            NSLog(@"reslut = %@",resultDic);
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:resultDic message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
            
        }];
        
    }
    [NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(huoqujine) userInfo:nil repeats:NO];
    
    
}
-(void)huoqujine
{
    NSDictionary *dicc=[dic valueForKey:@"list"];
    [LCProgressHUD showLoading:nil];
    
    NSDictionary *parameters = @{@"device_type":@"IPHONE",@"hardware_sn":deviceUUID,@"order_id":[dicc valueForKey:@"order_id"]};
    NSLog(@"-------%@",[dicc valueForKey:@"order_id"]);
    [EncryptAndEcode httpUrl:@"http://api.xiongmaoapi.com/api/xiongmao/get_order_status/" AndPostparameters:parameters block:^(NSDictionary *responseObject) {
        
        NSLog(@"———解密后的数据———%@",responseObject);
        [LCProgressHUD hide];
        NSDictionary *dd=[responseObject valueForKey:@"list"];
        NSString *str=[NSString stringWithFormat:@"%@",[dd valueForKey:@"status"]];

        if([str isEqualToString:@"UNPAID"])//失败
        {
              [FormValidator showAlertWithStr:@"支付失败"];
        }
        else{
             [FormValidator showAlertWithStr:@"支付成功"];
            //创建通知
            NSNotification *notification =[NSNotification notificationWithName:@"购买" object:nil userInfo:nil];
            //通过通知中心发送通知
            [[NSNotificationCenter defaultCenter] postNotification:notification];
                
        }
        
    }];

}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
